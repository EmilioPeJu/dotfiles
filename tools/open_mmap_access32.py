#!/usr/bin/env python
import argparse
import mmap
import struct


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--path', default='resource0')
    parser.add_argument('--offset', type=int_or_hex, default=0)
    parser.add_argument('--value', type=int_or_hex_or_string, default=None)
    return parser.parse_args()


def int_or_hex(value):
    if value.startswith('0x'):
        return int(value, 16)

    return int(value)


def int_or_hex_or_string(value):
    if value.startswith('0x') or value.isdigit():
        return int_or_hex(value)

    return struct.pack('I', value.encode('utf-8')[:4])


def main():
    args = parse_args()
    with open(args.path, 'r+b') as f:
        mm = mmap.mmap(f.fileno(), 0)
        mm.seek(args.offset)
        if args.value is not None:
            # write if a value was passed
            mm.write(struct.pack('I', args.value))
            mm.flush()
        else:
            data = mm.read(4)
            value = struct.unpack('I', data)[0]
            print('0x{:08x} ({})'.format(value, repr(data)[1:]))

        mm.close()


if __name__ == '__main__':
    main()
