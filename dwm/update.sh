#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash -p git -p stdenv -p xorg.libX11 -p xorg.libXft -p xorg.libXinerama
git init
git remote add origin https://git.suckless.org/dwm
git fetch --all
git reset --hard origin/master
make
