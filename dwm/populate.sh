#!/bin/bash
git init
git remote add origin https://git.suckless.org/dwm
git fetch --all
git reset --hard origin/master
make
