#!/bin/bash
cd /code/src
[[ ! -d linux ]] && git clone https://github.com/torvalds/linux
cd linux
git pull
# check old .config and ask for new options
make oldconfig
# have fun
make menuconfig && \
make -j4        && \
make modules
