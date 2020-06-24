#!/usr/bin/env bash
if [ ! -d src ]; then
    git clone git://git.suckless.org/smdev src
    pushd src
    git fetch --all
    git reset --hard origin/master
    popd
    ln -sf src/smdev
fi
cp -rf config.h src/config.h
pushd src
git pull
make
popd
