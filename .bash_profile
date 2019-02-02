#!/bin/bash
if [[ "$(tty)" = "/dev/tty1" ]]; then
        export XKB_DEFAULT_OPTIONS=ctrl:nocaps
	/usr/bin/sway
	exit 0
fi
