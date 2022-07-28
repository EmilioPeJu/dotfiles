#!/usr/bin/env bash
. ~/.config/init-common.sh
# notification daemon
dunst &
# compositor
xcompmgr &
# top bar
~/tools/dwmbar &
# system monitor
conky -d
# keyboard layout
setxkbmap us -variant altgr-intl -option ctrl:nocaps
# clipboard manager
clipmenud &
# set background
~/.fehbg &
