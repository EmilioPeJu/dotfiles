#!/usr/bin/env python
import argparse

import logging
import queue
import socket
import subprocess
import threading
import time
import sys

from collections import namedtuple
from typing import Generator, List, Set, Tuple
from scapy.all import *

try:
    from kubernetes import client, config, watch
    has_kubelib = True
except ImportError:
    has_kubelib = False


log = logging.getLogger(__name__)
level2num = {"debug": logging.DEBUG,
             "info": logging.INFO,
             "warn": logging.WARN,
             "error": logging.ERROR}


ServiceEvent = namedtuple("ServiceEvent", ["type", "ip", "port"])


class ServiceEventType(object):
    ADDED = 'ADDED'
    DELETED = 'DELETED'


def forward_request(req_data: bytes, req_addr: Tuple[str, int],
                    endpoint: Tuple[str, int]):
    """Forwards a request to a search endpoint keeping the requester's source
       IP and source port"""
    log.info("Sending from %s to %s", repr(req_addr), repr(endpoint))
    pkt = IP(src=req_addr[0],
             dst=endpoint[0]) / UDP(sport=req_addr[1],
                                    dport=endpoint[1]) / req_data
    send(pkt)


def services_events_task(namespace: str, port: int,
                         eventq: 'queue.Queue[ServiceEvent]'):
    """Contains loop to get services' events and push them to a queue

    Args:
        namespace: used to select namespace that services belongs to
        port: specify the UDP port that the service should be listening
        eventq: queue used to push events
    """
    while True:
        try:
            if not has_kubelib:
                log.info("kubernetes library not found, falling back "
                         "to running kubectl")
            services_events = kubelib_services_events \
                if has_kubelib else kubectl_services_events
            for events in services_events(namespace, port):
                log.info("Got services events %s", repr(events))
                for event in events:
                    eventq.put(event)
        except Exception as e:
            log.error("Problems: %s\nRetrying ...", e)
            time.sleep(5)


def kubectl_services_events(namespace: str,
                            port: int) -> Generator[List[ServiceEvent],
                                                    None, None]:
    """Generator for services' events using kubectl command

    Args:
        namespace: used to select namespace that services belongs to
        port: specify the UDP port that the service should be listening
    """
    while True:
        log.info("Getting endpoints")
        cmd = ["kubectl", "get", "services", "--namespace",
               namespace]
        output = subprocess.check_output(cmd).decode()
        result = []
        for line in output.split("\n")[1:-1]:
            cols = line.split()
            srv_port = int(cols[4].split(":")[0])
            if srv_port == port and cols[4].endswith("UDP"):
                ip = cols[3]
                result.append(
                    ServiceEvent(ServiceEventType.ADDED, ip, port))
        yield result
        time.sleep(10)


def kubelib_services_events(namespace: str,
                            port: int) -> Generator[List[ServiceEvent],
                                                    None,
                                                    None]:
    """Generator for services' events using kubernetes library

    Args:
        namespace: used to select namespace that services belongs to
        port: specify the UDP port that the service should be listening
    """
    config.load_kube_config()
    api_watch = watch.Watch()
    v1 = client.CoreV1Api()
    while True:
        for event in api_watch.stream(v1.list_namespaced_service,
                                      namespace=namespace):
            log.debug("Got kubernetes event: %s", event)
            result = []
            event_type = event.get('type')
            for ingress in event['object'].status.load_balancer.ingress:
                ip = ingress.ip
                for ports in event['object'].spec.ports:
                    srv_port = ports.port
                    proto = ports.protocol
                    if srv_port == port and proto == 'UDP':
                        result.append(ServiceEvent(event_type, ip, port))
            if result:
                yield result


def handle_request(req_data: bytes, req_addr: Tuple[str, int],
                   search_endpoints: Set[Tuple[str, int]]):
    """Forwards data from a request to each one of the search endpoints"""
    for endpoint in search_endpoints:
        forward_request(req_data, req_addr, endpoint)


def handle_events(eventq: 'queue.Queue[ServiceEvent]',
                  search_endpoints: Set[Tuple[str, int]]):
    """Updates search_endpoints acording to events received via an event queue

    Args:
        eventq: queue to receive services events
        search_endpoints: set that will be updated acording to events
    """
    while True:
        try:
            event = eventq.get(False)
        except queue.Empty:
            return
        if event.type == ServiceEventType.ADDED:
            search_endpoints.add((event.ip, event.port))
        elif event.type == ServiceEventType.DELETED:
            search_endpoints.discard((event.ip, event.port))
        else:
            log.error("Incorrect service event type: %s", event.type)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=5064)
    parser.add_argument('--namespace', type=str, required=True)
    parser.add_argument('--loglevel', type=str, default="info")
    return parser.parse_args()


def main():
    args = parse_args()
    search_endpoints = set()
    logging.basicConfig(level=level2num.get(args.loglevel.lower(), "info"))
    eventq = queue.Queue()
    threading.Thread(None, services_events_task, "services_events",
                     args=(args.namespace, args.port, eventq)).start()
    ssock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    ssock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
    ssock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    ssock.bind(("0.0.0.0", args.port))
    while True:
        data, addr = ssock.recvfrom(9000)
        handle_events(eventq, search_endpoints)
        handle_request(data, addr, search_endpoints)


if __name__ == "__main__":
    main()
