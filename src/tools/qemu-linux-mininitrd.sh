#!/usr/bin/env bash
# make sure to have built linux and busybox
cd $SRCPATH
qemu-system-x86_64 \
    -kernel linux/arch/x86_64/boot/bzImage \
    -initrd minrootfs.cpio.gz \
    -append "root=/dev/ram rdinit=/init nokaslr" \
    -s -S
