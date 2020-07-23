#!/usr/bin/env bash
name="$(basename $PWD)"
cp -rf src build
pushd build
[[ -f ../config.h ]] && cp -rf ../config.h .
for patch in ../*.diff; do
    patch -p1 < $patch
done
if command -v musl-gcc &>/dev/null; then
    make install PREFIX=$PREFIXPATH/$name CC=musl-gcc && popd && rm -rf build
else
    make install PREFIX=$PREFIXPATH/$name && popd && rm -rf build
fi
