#!/usr/bin/env bash
. ~/.config/init-common.sh
# notification daemon
dunst &
# compositor
xcompmgr &
# top bar
# system monitor
conky -d
# keyboard layout
setxkbmap us -variant altgr-intl -option ctrl:nocaps
# set background
~/.fehbg &
# synchronize clipboard and primary buffer
autocutsel -selection CLIPBOARD &
autocutsel -selection PRIMARY &
