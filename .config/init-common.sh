#!/usr/bin/env bash
# socket activation would not allow to connect immediately
systemctl start --user pulseaudio
#gammastep &
# Lower those distracting colors
vibrant-cli HDMI-1 0.7
xgamma -rgamma 1.0 -ggamma 0.6 -bgamma 0.6
# player server
one-instance mpd
