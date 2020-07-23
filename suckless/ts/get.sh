#!/usr/bin/env bash
name="$(basename $PWD)"
if [ ! -d src ]; then
    wget http://vicerveza.homeunix.net/~viric/soft/ts/ts-1.0.tar.gz
    tar xvfz ts-1.0.tar.gz
    mv ts-1.0 src
fi
