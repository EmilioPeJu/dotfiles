#!/usr/bin/env bash
. ~/.config/init-common.sh
# socket activation would not allow to connect immediately
systemctl start --user pulseaudio
# my beautiful monitor
xrandr --output HDMI1 --auto --left-of eDP1
# my beautiful headphones
echo connect EB:06:EF:1D:A2:F5 | bluetoothctl
# player server
one-instance mpd
# notification daemon
dunst &
# compositor
xcompmgr &
# top bar
$HOME/suckless/dwm/dwmbar &
# system monitor
conky -d
