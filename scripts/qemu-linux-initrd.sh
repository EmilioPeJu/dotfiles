#!/bin/bash
# make sure to have built linux and busybox
cd /code/src
qemu-system-x86_64 \
    -kernel linux/arch/x86_64/boot/bzImage \
    -initrd busybox/initramfs.img \
    -append "root=/dev/ram rdinit=/sbin/init nokaslr" \
    -s -S
