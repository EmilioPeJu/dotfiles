#!/usr/bin/env python
import subprocess
import pyudev


def keyboard_hook(device):
    if device.get('ID_SERIAL') == 'ZSA_Technology_Labs_Voyager':
        subprocess.run(['setmylayout.sh'])


def main():
    monitor = pyudev.Monitor.from_netlink(pyudev.Context())
    for device in iter(monitor.poll, None):
        if device.action == 'add' and 'ID_INPUT_KEYBOARD' in device.properties:
            keyboard_hook(device)


if __name__ == '__main__':
    main()
