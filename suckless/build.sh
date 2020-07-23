#!/usr/bin/env bash
set -e
name="$(basename $PWD)"
cp -rf src build
pushd build
cp -rf ../config.h .
for patch in ../*.diff; do
    patch -p1 < $patch
done
make install PREFIX=$PREFIXPATH/$name &&
popd &&
rm -rf build
