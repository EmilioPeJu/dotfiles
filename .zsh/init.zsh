#!/usr/bin/env zsh
#
if type -p fasd &> /dev/null; then
    eval "$(fasd --init auto)"
fi
if type -p starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
if type -p direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
