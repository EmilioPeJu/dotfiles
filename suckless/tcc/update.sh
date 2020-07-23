#!/usr/bin/env bash
if [ ! -d src ]; then
    git clone  git://repo.or.cz/tinycc.git src
    pushd src
    git fetch --all
    git checkout release_0_9_27
    popd
fi
cd src
git pull
