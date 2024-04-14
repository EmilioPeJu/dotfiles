#!/usr/bin/env bash
. ~/.config/init-common.sh
# compositor
picom -b
# notification daemon
dunst &
# system monitor
conky -d
# keyboard layout
setxkbmap us -variant altgr-intl -option ctrl:nocaps
# synchronize clipboard and primary buffer
autocutsel -selection CLIPBOARD &
autocutsel -selection PRIMARY &
