#!/usr/bin/env bash
# socket activation would not allow to connect immediately
systemctl start --user pulseaudio
# player server
one-instance mpd
# my beautiful headphones
{ echo connect EB:06:EF:1D:A2:F5 | bluetoothctl; } &
