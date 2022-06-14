#!/usr/bin/env bash
res=$(cat ~/scripts/symbols | dmenu)
echo -n "${res: -1}" | xclip -i -selection clipboard
echo -n "${res: -1}" | xclip -i -selection primary
