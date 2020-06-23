#!/usr/bin/env bash
if [ ! -d src ]; then
    git clone https://github.com/muennich/sxiv.git src
    pushd src
    git fetch --all
    git reset --hard origin/master
    popd
    ln -sf src/sxiv
fi
pushd src
git pull
cp -f config.h src/config.h
make
popd
