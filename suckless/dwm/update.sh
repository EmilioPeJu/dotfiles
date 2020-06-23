#!/usr/bin/env bash
if [ ! -d src ]; then
    git clone https://git.suckless.org/dwm src
    pushd src
    git fetch --all
    git reset --hard origin/master
    popd
    ln -sf src/dwm
fi
cp -rf config.h src/config.h
pushd src
git pull
make
popd
