#!/bin/bash
git init
git remote add origin https://git.suckless.org/st
git fetch --all
git checkout origin/master
make
