#!/usr/bin/env bash
name="$(basename $PWD)"
if [ ! -d src ]; then
    git clone https://git.suckless.org/$name src
    pushd src
    git fetch --all
    git checkout origin/master
    popd
fi
cd src
git pull
