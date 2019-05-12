#!/bin/bash
# this prepares the minimum to be able to run a shell
# it could be used as an initramfs or as a rootfs
if [[ ! -d /code/src/busybox ]]; then
    build-busybox.sh
fi
cd /code/src/busybox/_install
mkdir {proc,sys,etc,etc/init.d}
# Boot script SysV style
# create single mode startup script
# which is the default mode if there is
# no inittab
cat > etc/init.d/rcS <<EOF
mount -t proc proc /proc
mount -t sys sys /sys
mkdir /dev/pts
mount -t devpts devpts /dev/pts
mdev -s
/bin/sh
EOF
chmod +x etc/init.d/rcS
# important: suid as root for busybox
chown root bin/busybox
chmod +s bin/busybox

find . | cpio -o --format=newc > ../initramfs.img
