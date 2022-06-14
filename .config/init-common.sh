#!/usr/bin/env bash
# socket activation would not allow to connect immediately
systemctl start --user pulseaudio

gammastep &
# player server
one-instance mpd
