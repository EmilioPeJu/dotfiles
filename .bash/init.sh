#!/usr/bin/env bash

if type -p fasd &> /dev/null; then
    eval "$(fasd --init auto)"
fi
if type -p starship &> /dev/null; then
    eval "$(starship init bash)"
fi
if type -p direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi
if type -p remind &> /dev/null; then
    remind ~/.reminders
fi
if type -p task &> /dev/null; then
    task
fi
# auto cd in vim when a terminal change directory
if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
    function cd {
        command cd $@
        /run/current-system/sw/bin/python <<EOF
from pynvim import attach
nvim = attach("socket", path="$NVIM_LISTEN_ADDRESS")
nvim.command("cd $PWD")
nvim.close()
EOF
    }
fi
