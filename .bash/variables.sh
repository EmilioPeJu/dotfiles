#!/usr/bin/env bash

# user environment variables
#export SHELL="$(which zsh)"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.node/bin:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.golang/bin:$HOME/.go/bin"
export NODE_PATH="$NODE_PATH:$HOME/.node/lib/node_modules"
export GOPATH="$HOME/.go"
export EDITOR="vim"
export TERMINAL="alacritty"
export PREFIXPATH="$HOME/prefix"
export SRCPATH="$HOME/src"
export NIX_PATH="$HOME/.nix-defexpr-user:$NIX_PATH"
if command -v find-dls-epics-base &> /dev/null; then
    export EPICS_BASE=$(find-dls-epics-base)
fi
export EPICS_CA_MAX_ARRAY_BYTES=15000000
# Fix misbehaving java applications in dwm
export _JAVA_AWT_WM_NONREPARENTING=1

