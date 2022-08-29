# Created by newuser for 4.3.11

if [[ -f ~/.bashrc_local ]]; then
    source ~/.bashrc_local
fi

# unset HISTFILE
# autoload -Uz compinit promptinit
# compinit
# promptinit

# prompt zefram

source ~/.zsh/init.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/bindkeys.zsh

# Plugins and Frameworks

# Oh-my-zsh
export ZSH=~"/.zsh/oh-my-zsh"
export ZSH_CUSTOM=~"/.zsh/oh-my-zsh-custom"

#ZSH_THEME="lukerandall-mod"

plugins=(zsh-autosuggestions git dirhistory zsh-syntax-highlighting)

source ~/.zsh/oh-my-zsh/oh-my-zsh.sh

export TERM=xterm-256color
