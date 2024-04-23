#!/usr/bin/env bash

# user environment variables
export PATH="$PATH:$HOME/tools"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.node/bin:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.golang/bin:$HOME/.go/bin"
export NODE_PATH="$NODE_PATH:$HOME/.node/lib/node_modules"
export GOPATH="$HOME/.go"
export TERMINAL="kitty"
export PREFIXPATH="$HOME/prefix"
export SRCPATH="$HOME/src"
export PATH="$PATH:$SRCPATH/tools"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
if type -p caget &> /dev/null; then
    export EPICS_BASE=$(readlink -f $(which caget))/../../
    export EPICS_CA_MAX_ARRAY_BYTES=15000000
fi

export GPG_TTY=$TTY

# Fix misbehaving java applications in dwm
export _JAVA_AWT_WM_NONREPARENTING=1

if type -p nvim &> /dev/null; then
    if [ -n "$NVIM" ]; then
        export EDITOR="nvr"
    else
        export EDITOR="nvim"
    fi
elif type -p vim &> /dev/null; then
    export EDITOR="vim"
fi
