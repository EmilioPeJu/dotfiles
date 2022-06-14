#!/usr/bin/env bash
cd $SRCPATH
[[ ! -d busybox ]] && git clone "git://git.busybox.net/busybox"
cd busybox
git pull
# have fun and
# make sure to enable
# build static binary
make menuconfig && \
    make -j4 && \
    make install
