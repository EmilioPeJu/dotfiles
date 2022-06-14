#!/usr/bin/env bash
#
# Copied from Luke
#
mountable=$(lsblk -lp | awk '/part $/ { print $1,"(" $4 ")" }')
chosen=$(echo "$mountable" | dmenu -i -p "Mount which drive?" | awk '{ print $1 }')
[[ ! -e "$chosen" ]] && exit 1
pname=${chosen##*/}
dst_path=$HOME/mnt/$pname
mkdir -p "$dst_path"
sudo mount -o rw "$chosen" "$dst_path" && notify-send "$chosen mounted" &&
$TERMINAL -e ranger $dst_path
