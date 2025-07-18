#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
sleep "$1"
notify-send "Timeout ($1)"
mpv  $SCRIPT_DIR/alarm.opus
