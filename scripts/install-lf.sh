#!/bin/bash
[[ ! -d "$HOME/.golang" ]] && install-go.sh
go get -v github.com/gokcehan/lf
