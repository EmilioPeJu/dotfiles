#!/usr/bin/env bash
. ~/.config/init-common.sh
# Add folder with all installed fonts as font path
xset +fp \
    $(dirname $(readlink -f /run/current-system/sw/share/X11-fonts/fonts.alias))
# socket activation would not allow to connect immediately
systemctl start --user pulseaudio
# my beautiful headphones
echo connect EB:06:EF:1D:A2:F5 | bluetoothctl
# player server
mpd
# notification daemon
mako &
