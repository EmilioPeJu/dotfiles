#!/usr/bin/env bash

if type -p autojump &> /dev/null; then
    autojumpbindir=$(dirname $(readlink -f $(which autojump)))
    . $autojumpbindir/../share/autojump/autojump.bash
fi

if type -p direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

if type -p starship &> /dev/null; then
    eval "$(starship init bash)"
fi

if type -p podman &> /dev/null; then
    eval "$(podman completion bash)"
fi
