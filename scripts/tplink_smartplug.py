#!/usr/bin/env python3
#
# TP-Link Wi-Fi Smart Plug Protocol Client
# For use with TP-Link HS-100 or HS-110
#
# by Lubomir Stroetmann
# Copyright 2016 softScheck GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import argparse
import logging
import socket
import sys
from struct import pack
log = logging.getLogger(__name__)
datalog = logging.getLogger("datalog")

version = 0.31


def configure_logging():
    log.addHandler(logging.StreamHandler(sys.stderr))
    log.setLevel(logging.INFO)
    log.propagate = False
    datalog.addHandler(logging.StreamHandler(sys.stdout))
    datalog.propagate = False
    datalog.setLevel(logging.INFO)


# Predefined Smart Plug Commands
# For a full list of commands, consult tplink_commands.txt
commands = {
    'info':      '{"system":{"get_sysinfo":{}}}',
    'on':        '{"system":{"set_relay_state":{"state":1}}}',
    'off':       '{"system":{"set_relay_state":{"state":0}}}',
    'ledoff':    '{"system":{"set_led_off":{"off":1}}}',
    'ledon':     '{"system":{"set_led_off":{"off":0}}}',
    'cloudinfo': '{"cnCloud":{"get_info":{}}}',
    'wlanscan':  '{"netif":{"get_scaninfo":{"refresh":0}}}',
    'time':      '{"time":{"get_time":{}}}',
    'schedule':  '{"schedule":{"get_rules":{}}}',
    'countdown': '{"count_down":{"get_rules":{}}}',
    'antitheft': '{"anti_theft":{"get_rules":{}}}',
    'reboot':    '{"system":{"reboot":{"delay":1}}}',
    'reset':     '{"system":{"reset":{"delay":1}}}',
    'energy':    '{"emeter":{"get_realtime":{}}}'
}


# Encryption and Decryption of TP-Link Smart Home Protocol
# XOR Autokey Cipher with starting key = 171
def encrypt(string):
    if not isinstance(string, bytes):
        string = string.encode()
    key = 171
    result = bytearray()
    for i in string:
        a = key ^ i
        key = a
        result.append(a)
    msg = pack('>I', len(string)) + bytes(result)
    return msg


def decrypt(string):
    key = 171
    result = bytearray()
    for i in string:
        a = key ^ i
        key = i
        result.append(a)
    return bytes(result)


def parse_args():
    # Parse commandline arguments
    parser = argparse.ArgumentParser(
        description="TP-Link Wi-Fi Smart Plug Client v" + str(version))

    # Check if hostname is valid
    def validHostname(hostname):
        try:
            socket.gethostbyname(hostname)
        except socket.error:
            parser.error("Invalid hostname.")
        return hostname

    # Check if port is valid
    def validPort(port):
        if not port.isdigit() or int(port) <= 1024 or int(port) > 65535:
            parser.error("Invalid port number.")
        return int(port)

    parser.add_argument("-t", "--target", metavar="<hostname>", required=True,
                        help="Target hostname or IP address",
                        type=validHostname)
    parser.add_argument("-p", "--port", metavar="<port>", default=9999,
                        required=False, help="Target port", type=validPort)
    parser.add_argument("-q", "--quiet", dest='quiet', action='store_true',
                        help="Only show result")
    parser.add_argument("--timeout", default=10, required=False,
                        help="Timeout to establish connection")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-c", "--command", metavar="<command>",
                       help="Preset command to send. Choices are: "
                             + ", ".join(commands), choices=commands)
    group.add_argument("-j", "--json", metavar="<JSON string>",
                       help="Full JSON string of command to send")

    return parser.parse_args()


def main():
    # Set target IP, port and command to send
    configure_logging()
    args = parse_args()
    if args.quiet:
        log.disabled = True
    if args.command is None:
        cmd = args.json
    else:
        cmd = commands[args.command]

    # Send command and receive reply
    try:
        sock_tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock_tcp.settimeout(int(args.timeout))
        sock_tcp.connect((args.target, args.port))
        sock_tcp.settimeout(None)
        sock_tcp.sendall(encrypt(cmd))
        # we want to send user messages to standard error so that the data can
        # be easily piped to another command like jq
        log.info(f"Sent:     {cmd}\nReceiving... ")
        data = sock_tcp.recv(2048)
        sock_tcp.close()

        decrypted = decrypt(data[4:]).decode()
        datalog.info(decrypted)
    except socket.error:
        quit(f"Could not connect to host {args.target}:{args.port}")


if __name__ == "__main__":
    main()
