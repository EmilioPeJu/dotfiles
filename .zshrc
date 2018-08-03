# Created by newuser for 4.3.11
unset HISTFILE
autoload -Uz compinit promptinit
compinit
promptinit

prompt zefram

if [[ -f ~/.bashrc_local ]]; then
    source ~/.bashrc_local
fi
source ~/.zsh/setopt.sh
source ~/.zsh/functions.sh
source ~/.zsh/bindkeys.sh
eval "$(fasd --init posix-alias zsh-hook wcomp wcomp-install)"
