#!/usr/bin/env bash
if [ -n "$1" ]; then
    list_selected="$1"
else
    list_selected=$(ls ~/remind/lists/ | dmenu)
fi

option_selected=$(sort -R ~/remind/lists/${list_selected} | sed '/^#/d' | head -n1)
notify-send -- "${option_selected}"
