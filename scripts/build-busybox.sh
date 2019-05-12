#!/bin/bash
cd /code/src
[[ ! -d busybox ]] && git clone "https://github.com/mirror/busybox"
cd busybox
git pull
make oldconfig
# have fun and
# make sure to enable
# build static binary
make menuconfig && \
    make -j4 && \
    make install
