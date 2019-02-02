#!/bin/bash
if [[ "$(tty)" = "/dev/tty1" ]]; then
	/usr/bin/sway
	exit 0
fi
