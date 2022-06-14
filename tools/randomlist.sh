#!/usr/bin/env bash
list_selected=$(ls ~/remind/lists/ | dmenu)
option_selected=$(sort -R ~/remind/lists/${list_selected} | sed '/^#/d' | head -n1)
notify-send -- "${option_selected}"
