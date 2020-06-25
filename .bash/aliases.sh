#!/bin/bash
# user alias
alias se='rifle $(fzf)'
alias see='$EDITOR $(fzf)'
alias remake="make clean uninstall; make"
alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
alias youtube-dl="youtube-dl --exec 'notify-send {} finished'"
alias cat2="cat << EOF >>"
alias ed="$EDITOR"
alias gf="git fetch --all"
alias gd="git diff --color=always --ws-error-highlight=all"
alias gc="git commit"
alias ga="git add"
alias gall="git add --all"
alias gr="git rebase"
alias gl="git log --color=always --graph --branches --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gb="git blame"
alias gg="git gui"
alias gp="git remote | xargs -L1 git push --all"
alias gcc-unsafe="gcc -fno-stack-protector -z execstack"
alias gcc-dump="gcc -fdump-tree-all -fdump-ipa-all -fdump-rtl-all"
# include-freestanding-c99 contains relevant headers
alias gcc-freestanding-c99="gcc -std=c99 -nostdinc -nostdlib -ffreestanding -I $HOME/include-freestanding-c99"
alias r2help="r2 -q -c '?*~...' -"
alias t="trans -speak -d en:es"
# useful for simulating a serial port
alias socat-pty="socat -d -d pty,rawer pty,rawer"
alias tmp="pushd && cd /run/user/$(id -u)"
alias rename-latin1-to-utf8="convmv -f iso-8859-15 -t utf-8 --notest -r ."
alias mc="make clean-tests"
alias java-bytecodes="javap -c -p -verbose -s";
