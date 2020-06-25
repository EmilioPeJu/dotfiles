#!/usr/bin/env bash
if [ ! -d src ]; then
    git clone https://git.suckless.org/st src
    pushd src
    git fetch --all
    git checkout origin/master
    popd
    ln -sf src/st
fi
cd src
git pull
