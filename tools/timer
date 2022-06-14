#!/usr/bin/env bash
if [[ -z "$1" ]]; then
    timerfile="$(find $HOME -name '.timer_*' -maxdepth 1 | dmenu)"
else
    timerfile="${HOME}/.timer_${1}"
fi
[[ ! -f "${timerfile}" ]] && echo 0 > "${timerfile}"
oldtime="$( tail -1 "${timerfile}" )"
currenttime="$(date +%s)"
let current="${currenttime}-${oldtime}"
notify-send "Timer: $current"
echo "${currenttime}" >> "${timerfile}"
