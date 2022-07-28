#!/usr/bin/env bash
# make sure to have built linux and busybox in $SRCPATH

qemu-system-x86_64 \
    -kernel $SRCPATH/linux/arch/x86_64/boot/bzImage \
    -initrd $SRCPATH/busybox/initramfs.img \
    -append "debug pnp.debug=1" \
    -s -nographic \
    -netdev tap,ifname=tap0,id=mynet0,script=no,downscript=no \
    -device virtio-net-pci,netdev=mynet0 \
    -device ipmi-bmc-sim,id=bmc0 -device pci-ipmi-kcs,bmc=bmc0 \
    -device qemu-xhci \
    "$@"
# -S to start it stopped
