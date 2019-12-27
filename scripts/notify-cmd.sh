#!/bin/bash
set -x
result="$($@)"
notify-send -a $1 "$result"
