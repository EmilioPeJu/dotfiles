#!/usr/bin/env python
import struct
import sys
#
# use evtest instead (if you happen to have it)
#
# pass the device event id as first parameter,
# see registered input devices in /proc/bus/input/devices
#

def main():
    f = open(f"/dev/input/event{sys.argv[1]}", "rb")
    while 1:
        data = f.read(24)
        # 4I = time
        # H = type (e.g EV_KEY)
        # H = code (e.g KEY_A)
        # I = value (e.g 0 for release, 1 for press)
        print(struct.unpack("4IHHI", data))


if __name__ == "__main__":
    main()


