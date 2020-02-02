#!/bin/bash

# Copyright 2008 Carl-Daniel Hailfinger

LANG=C
dmesgfile=$1
debug_lspci_devs=`lspci -nvvD |
	grep -i "^[0-9a-f]\|debug port" |
	grep -iB1 "debug port" |
	grep -i "^[0-9a-f]" |
	cut -f 1 -d" " |
	sort |
	xargs echo`
test -z "$debug_lspci_devs" &&
	debug_lspci_devs="None"
echo "The following PCI devices support a USB debug port (says lspci): $debug_lspci_devs"
test "$debug_lspci_devs" = "None" &&
	echo "Possible reasons: lspci not run as root, lspci too old, USB controller does not support a debug device"
debug_dmesg_devs_with_port=`( test -z "$dmesgfile" &&
	dmesg ||
	cat "$dmesgfile") |
	grep -i "ehci.*debug port" |
	sed "s/.* \([0-9a-f]*:*[0-9a-f]\{2\}:[0-9a-f]\{2\}\.[0-9a-f]\).*ebug port /\1 /" |
	sort`
debug_dmesg_devs=`echo "$debug_dmesg_devs_with_port" |
	cut -f 1 -d" " |
	xargs echo`
test -z "$debug_dmesg_devs" && debug_dmesg_devs="None"
echo "The following PCI devices support a USB debug port (says the kernel): $debug_dmesg_devs"
test "$debug_dmesg_devs" = "None" && {
	echo "Possible reasons: dmesg scrolled off, kernel too old, USB controller does not support a debug device"
	test "$debug_lspci_devs" != "None" &&
		echo "You can specify a file containing kernel bootup messages as argument to this program"
	}
test "$debug_lspci_devs" != "$debug_dmesg_devs" && {
	echo "lspci and the kernel do not agree on USB debug device support. Exiting."
	exit 1
	}
test "$debug_dmesg_devs" = "None" && {
	echo "No USB controller with debug capability found"
	exit 1
	}
for dev in $debug_dmesg_devs; do
	bus=`lsusb -v |
		grep "^Bus\|iSerial.*" |
		grep -B1 "iSerial.*$dev" |
		grep "^Bus" |
		sed "s/Bus *0*\([0-9a-f]*\).*/\1/"`
	port=`echo "$debug_dmesg_devs_with_port" |
		grep "^$dev" |
		cut -f 2 -d" "`
	echo "PCI device $dev, USB bus $bus, USB physical port $port"
	done
echo "Currently connected high-speed devices:"	
lsusb -t |
	grep 480M
