# Created by newuser for 4.3.11

if [[ -f ~/.bashrc_local ]]; then
    source ~/.bashrc_local
fi

# unset HISTFILE
# autoload -Uz compinit promptinit
# compinit
# promptinit

# prompt zefram

source ~/.zsh/setopt.sh
source ~/.zsh/functions.sh
source ~/.zsh/bindkeys.sh

eval "$(fasd --init auto)"

# Plugins and Frameworks
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Oh-my-zsh
export ZSH=~"/.zsh/oh-my-zsh"
export ZSH_CUSTOM=~"/.zsh/oh-my-zsh-custom"

ZSH_THEME="tjkirch"

plugins=(git tmux dirhistory zsh-syntax-highlighting)

source ~/.zsh/oh-my-zsh/oh-my-zsh.sh

