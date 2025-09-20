#!/usr/bin/env bash
SCRIPT_DIR=$(dirname $0)
cd $SCRIPT_DIR/..
qemu-system-x86_64 -enable-kvm -m 256 -cdrom result/iso/nixos-*.iso
