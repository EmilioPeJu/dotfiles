#!/usr/bin/env python
import socket
import sys

port = int(sys.argv[1])
ssock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
ssock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# REUSEPORT is similar but seems to load balance when traffic is unicast
# while REUSEADDR sends to the same server every time
#ssock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
ssock.bind(("0.0.0.0", port))
while True:
    data, addr = ssock.recvfrom(256)
    print(f"{addr}: {data}")

ssock.close()
