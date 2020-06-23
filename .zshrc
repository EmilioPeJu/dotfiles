# Created by newuser for 4.3.11

if [[ -f ~/.bashrc_local ]]; then
    source ~/.bashrc_local
fi

# unset HISTFILE
# autoload -Uz compinit promptinit
# compinit
# promptinit

# prompt zefram

source ~/.zsh/setopt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/bindkeys.zsh

eval "$(fasd --init auto)"

# Plugins and Frameworks

# Oh-my-zsh
export ZSH=~"/.zsh/oh-my-zsh"
export ZSH_CUSTOM=~"/.zsh/oh-my-zsh-custom"
export SHELL="$(which zsh)"
export ZSH_TMUX_AUTOSTART=true

ZSH_THEME="lukerandall-mod"

plugins=(zsh-autosuggestions git tmux dirhistory zsh-syntax-highlighting)

source ~/.zsh/oh-my-zsh/oh-my-zsh.sh

export TERM=xterm-256color
