#!/usr/bin/env bash

kbid=$(xinput list --id-only 'keyboard:ZSA Technology Labs Voyager')
setxkbmap -device $kbid -layout us -variant altgr-intl -option ctrl:nocaps
