#!/bin/bash
# $1 input network interface
# $2 output network interface
sysctl -w net.ipv4.ip_forward=1
iptables -A FORWARD -i "$1" -j ACCEPT
iptables -t nat -A POSTROUTING -o "$2" -j MASQUERADE
