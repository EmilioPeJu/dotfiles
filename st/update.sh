#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash -p git -p stdenv -p xorg.libX11 -p xorg.libXft -p xorg.libXinerama -p ncurses -p pkgconfig -p fontconfig -p freetype
git init
git remote add origin https://git.suckless.org/st
git fetch --all
git checkout origin/master
make
