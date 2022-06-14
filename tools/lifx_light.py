#!/usr/bin/env python
import argparse
import random
import socket
import struct
import sys
import time
from binascii import hexlify
from ctypes import \
    c_byte, c_char, c_float, c_int16,  c_uint8,  c_uint16, c_uint32, \
    c_uint64, LittleEndianStructure, sizeof, Union
sequence = 0


class PayloadFields(LittleEndianStructure):
    _pack_ = 1
    # should have each field of the payload
    pass


class EmptyFields(PayloadFields):
    _fields_ = [("dummy", c_byte*0)]


class Payload(Union):
    # should have "fields" to access each individual field
    # and "raw" to get the bytes to send
    _pack_ = 1
    _fields_ = [
        ("fields", EmptyFields),
        ("raw", c_byte*0)
    ]


class DeviceSetPowerFields(PayloadFields):
    _fields_ = [
        ("power", c_uint16)
    ]


class DeviceSetPowerPayload(Payload):
    TYPE = 21
    _fields_ = [
        ("fields", DeviceSetPowerFields),
        ("raw", c_byte * 2)
    ]


def set_power_status(ip, on=True):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    payload = DeviceSetPowerPayload()
    payload.fields.power = 0xffff if on else 0
    raw_message = create_packet(ip, payload)
    sock.sendto(raw_message, (ip, 56700))
    sock.close()


class SetPowerFields(PayloadFields):
    _fields_ = [
        ("power", c_uint16),
        ("duration", c_uint32)
    ]


class SetPowerPayload(Payload):
    TYPE = 117
    _fields_ = [
        ("fields", SetPowerFields),
        ("raw", c_byte * 6)
    ]


def set_power(ip, power, duration):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    payload = SetPowerPayload()
    payload.fields.power = power
    payload.fields.duration = duration
    raw_message = create_packet(ip, payload)
    sock.sendto(raw_message, (ip, 56700))
    sock.close()


class SetColorFields(PayloadFields):
    _fields_ = [
        ("reserved", c_byte),
        ("hue", c_uint16, 16),
        ("saturation", c_uint16, 16),
        ("brightness", c_uint16, 16),
        ("kelvin", c_uint16, 16),
        ("duration", c_uint32, 32)
    ]


class SetColorPayload(Payload):
    TYPE = 102
    _fields_ = [
        ("fields", SetColorFields),
        ("raw", c_byte*13)
    ]


def set_color(ip, hsbk, duration):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    payload = SetColorPayload()
    hue, saturation, brightness, kelvin = hsbk
    payload.fields.hue = hue
    payload.fields.saturation = saturation
    payload.fields.brightness = brightness
    payload.fields.kelvin = kelvin
    payload.fields.duration = duration
    raw_message = create_packet(ip, payload)
    sock.sendto(raw_message, (ip, 56700))
    sock.close()


class WaveformTypes(object):
    SAW = 0
    SINE = 1
    HALF_SINE = 2
    TRIANGLE = 3
    PULSE = 4


class SetWaveformOptionalFields(PayloadFields):
    _fields_ = [
        ("reserved", c_byte),
        ("transient", c_byte),
        ("hue", c_uint16),
        ("saturation", c_uint16),
        ("brightness", c_uint16),
        ("kelvin", c_uint16),
        ("period", c_uint32),
        ("cycles", c_float),
        ("skew_ratio", c_int16),
        ("waveform", c_byte),
        ("set_hue", c_byte),
        ("set_sat", c_byte),
        ("set_bright", c_byte),
        ("set_kelvin", c_byte),
    ]


class SetWaveformOptionalPayload(Payload):
    TYPE = 119
    _fields_ = [
        ("fields", SetWaveformOptionalFields),
        ("raw", c_byte*25)
    ]


def set_waveform_optional(ip, transient, hsbk, period, cycles, skew_ratio,
                          waveform, set_hue, set_sat, set_bright, set_kelvin):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    payload = SetWaveformOptionalPayload()
    hue, saturation, brightness, kelvin = hsbk
    payload.fields.hue = hue
    payload.fields.saturation = saturation
    payload.fields.brightness = brightness
    payload.fields.kelvin = kelvin
    payload.fields.period = period
    payload.fields.cycles = cycles
    payload.fields.skew_ratio = skew_ratio
    payload.fields.waveform = waveform
    payload.fields.set_hue = set_hue
    payload.fields.set_sat = set_sat
    payload.fields.set_bright = set_bright
    payload.fields.set_kelvin = set_kelvin
    raw_message = create_packet(ip, payload)
    sock.sendto(raw_message, (ip, 56700))
    sock.close()


class GetStatePayload(Payload):
    TYPE = 101


class GetStateResponseFields(PayloadFields):
    _fields_ = [
        ("hue", c_uint16),
        ("saturation", c_uint16),
        ("brightness", c_uint16),
        ("kelvin", c_uint16),
        ("reserved1", c_uint16),
        ("power", c_uint16),
        ("label", c_char * 32),
        ("reserved2", c_char * 8)
    ]


class GetStateResponsePayload(Payload):
    TYPE = 107
    _fields_ = [
        ("fields", GetStateResponseFields),
        ("raw", c_byte * 52)
    ]


def get_state(ip):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    payload = GetStatePayload()
    raw_message = create_packet(ip, payload, True)
    sock.sendto(raw_message, (ip, 56700))
    data, source = sock.recvfrom(4096)
    header = LifxHeader()
    header.raw[:] = data[:HEADER_SIZE]
    assert(header.fields.type == GetStateResponsePayload.TYPE)
    payload = GetStateResponsePayload()
    payload.raw[:] = data[HEADER_SIZE:]
    sock.close()
    return payload.fields


class LifxHeaderFields(LittleEndianStructure):
    _pack_ = 1
    _fields_ = [
        # FRAME HEADER (8 bytes)
        # total size in bytes
        ("size", c_uint16, 16),
        # always 1024
        ("protocol", c_uint16, 12),
        # is there frame address header?
        # always, therefore  1
        ("addressable", c_uint16, 1),
        # all devices that receive it should process it?
        # 1 if yes, 0 if the target field is used to filter
        ("tagged", c_uint16, 1),
        # message origin indicator: always 0
        ("origin", c_uint16, 2),
        # frame id used to match response
        # 0 if we don"t care about the response
        ("source", c_uint32, 32),
        # FRAME ADDRESS HEADER (16 bytes)
        # first 6 bytes is MAC address
        # all zeroes if we don"t want to filter
        ("target", c_byte * 8),
        ("reserved1", c_uint64, 48),
        # do we want answer?
        ("res_required", c_uint64, 1),
        # do we want acknowledgement?
        ("ack_required", c_uint64, 1),
        ("reserved2", c_uint64, 6),
        # sequence number to match each request"s answer
        # as one frame could have many requests
        ("sequence", c_uint64, 8),
        # PROTOCOL HEADER (12 bytes)
        ("reserved3", c_uint64, 64),
        # message type
        ("type", c_uint16, 16),
        ("reserved4", c_uint16, 16)
        # PAYLOAD comes after
    ]


HEADER_SIZE = 36


class LifxHeader(Union):
    _fields_ = [
        ("fields", LifxHeaderFields),
        ("raw", c_byte * HEADER_SIZE)
    ]


def create_packet(ip: str, payload: Payload, res_required=False):
    global sequence
    header = LifxHeader()
    header.fields.size = 36
    header.fields.protocol = 1024
    header.fields.addressable = 1
    header.fields.tagged = 1
    header.fields.origin = 0
    header.fields.source = random.randint(1, 2**32 - 1)
    header.fields.target[:] = [0] * 8
    header.fields.res_required = 1 if res_required else 0
    header.fields.sequence = sequence
    sequence += 1
    header.fields.type = payload.TYPE
    raw_payload = bytes(payload.raw)
    header.fields.size += len(raw_payload)
    raw_header = bytes(header.raw)
    raw_message = raw_header + raw_payload
    return raw_message


def set_bright(ip, bright, duration):
    state = get_state(ip)
    set_color(ip, (state.hue, state.saturation,
                   bright, state.kelvin), duration)


def set_waveform_bright(ip, transient, bright, period, cycles, skew_ratio,
                        waveform):
    state = get_state(ip)
    set_waveform_optional(ip, transient,
                          (state.hue, state.saturation, bright, state.kelvin),
                          period, cycles, skew_ratio, waveform, 0, 0, 1, 0)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip", required=True,
                        help="IP of the bulb to control")
    parser.add_argument("--bright", type=int, default=None,
                        help="brightness to set")
    parser.add_argument("--power", type=int, default=None,
                        help="power to set")
    parser.add_argument("--duration", type=int, default=500,
                        help="Duration used to set brightness or power")
    parser.add_argument("--waveform", type=int, default=None,
                        help="waveform type: "
                             "\t0: saw\n\t1: sine\n\t2: half-sine\n"
                             "\t3: triangle\n\t4: pulse")
    parser.add_argument("--wavebright", type=int, default=0xffff,
                        help="Brightness to define the waveform")
    parser.add_argument("--transient", action="store_true",
                        help="If set, the after the waveform, it wll return "
                             "to initial value of brightness")
    parser.add_argument("--period", type=int, default=1000,
                        help="period of waveform in ms")
    parser.add_argument("--cycles", type=float, default=1.0,
                        help="Cycles to repeat waveform")
    parser.add_argument("--skew_ratio", type=int, default=0,
                        help="it defines the non-duty cycle in a "
                             "pulse waveform")
    parser.add_argument("--status", action="store_true",
                        help="Get status of the light")
    return parser.parse_args()


def main():
    args = parse_args()
    if args.power is not None:
        set_power(args.ip, args.power, args.duration)
    if args.bright:
        set_bright(args.ip, args.bright, args.duration)
        time.sleep(args.duration / 1000)
    if args.waveform is not None:
        set_waveform_bright(args.ip,
                            1 if args.transient else 0, args.wavebright,
                            args.period, args.cycles, args.skew_ratio,
                            args.waveform)
    if args.status:
        state = get_state(args.ip)
        print(f"STATUS\nlabel: {state.label[:].decode()}\n"
              f"(Hue,Sat,Bright,Kelvin): ({state.hue},"
              f"{state.saturation},"
              f"{state.brightness},"
              f"{state.kelvin})\n"
              f"power: {state.power}\n")


if __name__ == "__main__":
    main()
