#!/usr/bin/env python
import socket
import sys

target = sys.argv[1]
port = int(sys.argv[2])
data = sys.argv[3]
csock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# to send broadcast we need to use a broadcast IP as destionation
# but we also need a broadcast MAC in L2, which is achieved
# with the following option
csock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
csock.sendto(data.encode(), (target, port))
csock.close()
