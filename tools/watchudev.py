#!/usr/bin/env pythonu
import subprocess
import pyudev

from watchudevserials import serial2script


def main():
    monitor = pyudev.Monitor.from_netlink(pyudev.Context())
    for device in iter(monitor.poll, None):
        print(dict(device.properties))
        if device.action == 'add' and 'ID_SERIAL' in device.properties:
            serial = device.get('ID_SERIAL')
            script = serial2script.get(serial)
            if script is not None:
                print(f'Serial: {serial}, Script: {script}')
                subprocess.run([script])


if __name__ == '__main__':
    main()
