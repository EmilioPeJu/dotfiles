#!/usr/bin/env dls-python3
import argparse
import socket
import sys
import subprocess
import time

from binascii import hexlify

PORT = 30719


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--mac', required=True)
    parser.add_argument('--ip', required=True)
    parser.add_argument('--mask', required=True)
    parser.add_argument('--gw', required=True)
    return parser.parse_args()


def discover(sock):
    sock.sendto(b"CAENels Dev?",
                ("255.255.255.255", PORT))
    sock.settimeout(1)
    start = time.time()
    while time.time() < start + 2:
        try:
            ans, addr = sock.recvfrom(1024)
            print(f"Reply from {addr}:")
            # I suspect \x21\x00 is a code for indicating the format
            if ans.startswith(b"CAENels Dev:"):
                print(f"\tversion: {ans[12]}.{ans[13]}")
                mac = ans[14:14 + 6]
                print(f"\tmac: {mac[0]:02x}", end="")
                for i in range(1, 6):
                    print(f":{mac[i]:02x}", end="")
                print()
                ip = ans[20:20+4]
                print(f"\tip: {ip[0]}.{ip[1]}.{ip[2]}.{ip[3]}")
                mask = ans[24:24+4]
                print(f"\tmask: {mask[0]}.{mask[1]}.{mask[2]}.{mask[3]}")
                gw = ans[28:28+4]
                print(f"\tgw: {gw[0]}.{gw[1]}.{gw[2]}.{gw[3]}")
                # this looks like a template for setting network
                # parameters, i.e: you can see similarity with
                # network_set format
                rest = ans[32:]
                print(f"\trest: {hexlify(rest)}")
        except socket.timeout:
            pass


def network_set(sock, mac, ip, mask, gw):
    msg = b"CAENels Set:" + bytes.fromhex(mac.replace(":", "")) \
          + b"\x27\x11" \
          + socket.inet_aton(ip) \
          + socket.inet_aton(mask) \
          + socket.inet_aton(gw)
    # all receive messages, one with matching mac sets parameters
    sock.sendto(msg, ("255.255.255.255", PORT))


def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    sock.bind(("", PORT))
    discover(sock)
    args = parse_args()
    network_set(sock, args.mac, args.ip, args.mask, args.gw)


if __name__ == "__main__":
    main()
