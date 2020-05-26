#!/bin/bash
cd $SRCPATH
qemu-system-x86_64 \
    -kernel linux/arch/x86_64/boot/bzImage \
    -hda busybox/rootfs.img \
    -append "root=/dev/sda rw nokaslr" \
    -s -S
