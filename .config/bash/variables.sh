#!/usr/bin/env bash

# user environment variables
# PATH
export PATH="$PATH:$HOME/tools"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.node/bin:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.golang/bin:$HOME/.go/bin"
export PATH="$PATH:$SRCPATH/tools"

export NODE_PATH="$NODE_PATH:$HOME/.node/lib/node_modules"
export GOPATH="$HOME/.go"
export PREFIXPATH="$HOME/prefix"
export SRCPATH="$HOME/src"

export R2_RCFILE=/home/user/.config/radare2/radare2rc
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export TERMINAL="kitty"
export QEMU=qemu-system-x86_64

if type -p caget &> /dev/null; then
    export EPICS_BASE=$(dirname $(dirname $(readlink -f $(which caget))))
    export EPICS_CA_MAX_ARRAY_BYTES=15000000
fi

export GPG_TTY=$TTY

# Fix misbehaving java applications in dwm
export _JAVA_AWT_WM_NONREPARENTING=1

if type -p nvim &> /dev/null; then
    if [ -n "$NVIM" ]; then
        export EDITOR="nvr --remote-wait"
    else
        export EDITOR="nvim"
    fi
elif type -p vim &> /dev/null; then
    export EDITOR="vim"
fi

#export VISUAL=ewrap
