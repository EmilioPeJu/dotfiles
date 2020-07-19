#!/usr/bin/env bash
chosen=$(mount | awk '/'$USER'\/mnt/ { print $3 }' | dmenu)
sudo umount "$chosen"
