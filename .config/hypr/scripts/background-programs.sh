#!/usr/bin/env bash
hyprctl dispatch exec [ workspace special:firefox silent ] firefox
hyprctl dispatch exec [ workspace special:magic silent ] kitty -e tmux
