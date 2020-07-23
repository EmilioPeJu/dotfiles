#!/usr/bin/env bash
name="$(basename $PWD)"
cp -rf src build
pushd build
[[ -f ../config.h ]] && cp -rf ../config.h .
for patch in ../*.diff; do
    patch -p1 < $patch
done
if command -v musl-gcc &>/dev/null; then
    [[ -x configure ]] && ./configure --prefix=$PREFIXPATH/$name --cc=musl-gcc
    make &&
    make install PREFIX=$PREFIXPATH/$name CC=musl-gcc && popd && rm -rf build
else
    [[ -x configure ]] && ./configure --prefix=$PREFIXPATH/$name
    make &&
    make install PREFIX=$PREFIXPATH/$name && popd && rm -rf build
fi
