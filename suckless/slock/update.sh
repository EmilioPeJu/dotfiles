#!/usr/bin/env bash
if [ ! -d src ]; then
    git clone https://git.suckless.org/slock src
    pushd src
    git fetch --all
    git reset --hard origin/master
    popd
    ln -sf src/slock
fi
cp -rf config.h src/config.h
pushd src
git pull
make
popd
