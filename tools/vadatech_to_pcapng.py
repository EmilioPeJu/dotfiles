#!/usr/bin/env python
import struct
import sys

ENABLE_COMMENT = False


def write_section_header_block():
    block_len = 28
    sys.stdout.buffer.write(struct.pack("IIIIlI",
        # block type
        0x0a0d0d0a,
        # block total length
        block_len,
        # byte-order magic
        0x1a2b3c4d,
        # mayor and minor version
        1,
        # section length (-1 means it's not specified)
        -1,
        # and block total length again
        block_len))


def write_interface_description_block():
    block_len = 20
    # type = 1
    sys.stdout.buffer.write(struct.pack("IIIII",
        # block type
        1,
        # block total length
        block_len,
        # link-type
        0xc7,
        # snapshot len = 0 meaning no limit
        0,
        # no options
        # block length again
        block_len))


def read_write_packet():
    data_line = input()
    if not data_line.startswith('0x'):
        return

    source = input()
    ts_line = input()
    part1, part2 = ts_line.split('.', 1)
    timestamp_us = int(float(part2) * 1e3) + int(part1) * int(1e6)
    payload = bytes([int(item, 16) for item in data_line.split()])
    # pcapng packet payload (considering kontron pseudo-header)
    packet_len = len(payload) + 2
    body_len = packet_len + ((4 - packet_len % 4) if packet_len % 4 else 0)
    options = bytearray()
    if ENABLE_COMMENT:
        comment = f"{source} - {data_line}".encode()
        comment_option = \
            struct.pack(
                'HH',
                1,  # opt_comment
                len(comment)) \
            + comment \
            + b'\x00' * ((4 - len(comment) % 4) if len(comment) % 4 else 0)
        options.extend(comment_option)

    if options:
        # if there are options, add the end-of-options option
        options.extend(b'\x00\x00\x00\x00')

    block_len = 32 + body_len + len(options)

    # following EPB format
    pcapng_data = \
        struct.pack('IIIIIIIBB',
                    # block type
                    6,
                    # block total length
                    block_len,
                    # interface ID
                    0,
                    # timestamp
                    timestamp_us >> 32,
                    timestamp_us & 0xffffffff,
                    # captured packet length =
                    #     min(snapshot length, original packet length)
                    packet_len,
                    # original packet length
                    packet_len,
                    # packet data
                    # kontron pseudo-header
                    # not sure if it's counting only command + command_data
                    # inside the IPMI packet, this is ignored by wireshark
                    packet_len - 7,
                    # ignoring port inside, not sure what it means,
                    # this ignored by wireshark
                    0) \
        + payload + b'\x00'*(body_len - packet_len) \
        + options  \
        + struct.pack('I', block_len)

    sys.stdout.buffer.write(pcapng_data)


def main():
    write_section_header_block()
    write_interface_description_block()
    while True:
        try:
            read_write_packet()
        except EOFError:
            break


if __name__ == "__main__":
    main()
