#!/usr/bin/env bash
# socket activation would not allow to connect immediately
systemctl start --user pulseaudio
# my beautiful headphones
echo connect EB:06:EF:1D:A2:F5 | bluetoothctl
# player server
mpd
# notification daemon
mako &
