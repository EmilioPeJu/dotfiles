#!/usr/bin/env bash
hyprctl dispatch exec [ workspace special:firefox silent ] -- firefox
hyprctl dispatch exec [ workspace special:magic silent ] -- kitty -e tmux
hyprctl dispatch exec [ workspace 4 silent ] -- kitty -e journalctl -xe -f
hyprctl dispatch exec [ workspace 4 silent ] -- kitty -e atop
hyprctl dispatch exec [ workspace 5 silent ] -- Telegram
