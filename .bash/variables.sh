#!/usr/bin/env bash

# user environment variables
#export SHELL="$(which zsh)"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.node/bin:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.golang/bin:$HOME/.go/bin"
export NODE_PATH="$NODE_PATH:$HOME/.node/lib/node_modules"
export GOPATH="$HOME/.go"
export TERMINAL="alacritty"
export PREFIXPATH="$HOME/prefix"
export SRCPATH="$HOME/src"
export NIX_PATH="$HOME/.nix-defexpr-user:$NIX_PATH"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
if type -p caget &> /dev/null; then
    export EPICS_BASE=$(readlink -f $(which caget))/../../
    export EPICS_CA_MAX_ARRAY_BYTES=15000000
fi
# Fix misbehaving java applications in dwm
export _JAVA_AWT_WM_NONREPARENTING=1

# prioritize neovim over vim
if type -p nvim &> /dev/null; then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi
