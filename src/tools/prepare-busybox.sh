#!/usr/bin/env bash
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
ln -s sbin/init
# Boot script SysV style
# create single mode startup script
# which is the default mode if there is
# no inittab
cat > etc/init.d/rcS <<EOF
echo "Init started"
mount -t proc none /proc
mount -t sysfs none /sys
mount -t debugfs none /sys/kernel/debug
mount -t devtmpfs dev /dev
# default inittab try to use the following non-existant devices
ln -s /dev/null /dev/tty2
ln -s /dev/null /dev/tty3
ln -s /dev/null /dev/tty4
ln -s /dev/null /dev/tty5
mdev -s
ip addr add 172.16.0.2/16 dev eth0
ip link set eth0 up
mkdir /nix
# is nolock needed because lockd is not reachable?
mount -t nfs -o nolock 172.16.0.1:/nix /nix
mkdir /src
mount -t nfs -o nolock 172.16.0.1:/home/user/src /src
${LAST_COMMAND}
EOF
chmod +x etc/init.d/rcS
# important: suid as root for busybox
fakeroot chown root bin/busybox
fakeroot chmod +s bin/busybox
find . | fakeroot cpio -o --format=newc > ../initramfs.img
