#!/usr/bin/env bash
hyprctl dispatch exec [ workspace special:firefox silent ] -- firefox
hyprctl dispatch exec [ workspace special:magic silent ] -- kitty -e tmux
hyprctl dispatch exec [ workspace 10 silent ] -- kitty -e journalctl -xe -f
#hyprctl dispatch exec [ workspace special:telegram silent ] -- Telegram
#hyprctl dispatch exec [ workspace 10 silent ] -- kitty -e btop
#hyprctl dispatch exec [ workspace 10 silent ] -- kitty -e syz-manager -config ~/linux-mentor/syzkaller.conf
