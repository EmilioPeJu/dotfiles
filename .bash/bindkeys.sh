#!/usr/bin/env bash

bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'
bind '"\e;":"nvim +term +star\C-m"'
bind '"\ei":"search_edit\C-m"'
bind '"\eo":"ranger_cd\C-m"'
bind '"\ep":"search_cd\C-m"'
bind '"\eu":"search_edit_content\C-m"'
