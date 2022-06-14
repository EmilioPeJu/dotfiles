#!/bin/bash
# this prepares the minimum to be able to run a shell
# it could be used as an initramfs or as a rootfs
: ${INCLUDE_FILE:-} # do you need to include extra things?
: ${LAST_COMMAND:-/bin/sh}
if [[ ! -d $SRCPATH/busybox/_install ]]; then
    build-busybox.sh
fi
cd $SRCPATH/busybox/_install
if [[ -e "$INCLUDE_FILE" ]]; then
    cp -rf "$INCLUDE_FILE" .
fi
mkdir -p {proc,sys,etc,etc/init.d}
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
$LAST_COMMAND
EOF
chmod +x etc/init.d/rcS
# important: suid as root for busybox
fakeroot chown root bin/busybox
fakeroot chmod +s bin/busybox
fakeroot find . | cpio -o --format=newc > ../initramfs.img
