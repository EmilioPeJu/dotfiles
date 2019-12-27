#!/bin/bash
set -x
result="$($@)"
notify-send "$result"
