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
