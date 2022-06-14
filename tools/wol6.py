#!/usr/bin/env python
import argparse
import re
import socket


def parse_args():
    argparser = argparse.ArgumentParser()

    def _validate_mac(mac):
        if not re.match(r'([0-9a-fA-F]:?){12}', mac):
            raise TypeError("Invalid MAC")

        return mac

    argparser.add_argument("MAC", type=_validate_mac,
                           help="MAC with format aa:bb:cc:dd:ee:ff")

    return argparser.parse_args()


def mac_str2bin(mac):
    result = bytearray()
    clean_mac = mac.replace(":", "")
    for hexpair in [clean_mac[i:i+2] for i in range(0, 12, 2)]:
        result.append(int(hexpair, 16))
    return bytes(result)


def main():
    args = parse_args()
    bin_mac = mac_str2bin(args.MAC)
    sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM, 17)
    message = b"\xff"*6 + bin_mac*16
    sock.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_MULTICAST_LOOP, True)
    # send to all-nodes multicast address
    sock.sendto(message, ("ff02::1", 40000))
    sock.close()


if __name__ == "__main__":
    main()
