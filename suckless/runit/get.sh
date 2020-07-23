#!/usr/bin/env bash
name="$(basename $PWD)"
if [ ! -d src ]; then
    version="2.1.2"
    wget http://smarden.org/runit/runit-$version.tar.gz
    tar xvfz runit-$version.tar.gz
fi
