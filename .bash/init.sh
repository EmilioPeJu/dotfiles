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
if type -p atuin &> /dev/null; then
    source ~/.bash/bash-preexec.sh
    eval "$(atuin init bash)"
fi
