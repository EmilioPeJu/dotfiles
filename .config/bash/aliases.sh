#!/usr/bin/env bash
# user alias
alias cat2="cat << EOF >>"
alias ju="cd ~/notes && jupyter lab"
alias ga="git add"
alias gall="git add --all"
alias gb="git blame"
alias gc="git commit"
alias gcc-dump="gcc -fdump-tree-all -fdump-ipa-all -fdump-rtl-all"
# include-freestanding-c99 contains relevant headers
# -nostdlib implies -nostartupfiles
alias gcc-freestanding-c99="gcc -std=c99 -nostdinc -nostdlib -ffreestanding -I $HOME/include-freestanding-c99"
alias gcc-unsafe="gcc -fno-stack-protector -z execstack"
alias gch="git checkout HEAD"
alias gd="git diff --color=always --ws-error-highlight=all"
alias gf="git fetch --all"
alias gg="git gui"
alias gl="git log --color=always --graph --branches --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp="git remote | xargs -L1 git push --all"
alias gr="git rebase"
alias java-bytecodes="javap -c -p -verbose -s";
alias ls='ls --color=auto'
alias n='nnn -e'
alias remake="make clean uninstall; make"
alias rename-latin1-to-utf8="convmv -f iso-8859-15 -t utf-8 --notest -r ."
alias r2help="r2 -q -c '?*~...' -"
alias se='search'
alias see='search_edit'
alias sec='search_content'
alias seec='search_edit_content'
alias secd='search_cd'
alias show-device-tree="dtc -I fs -O dts /proc/device-tree"
# useful for simulating a serial port
alias socat-pty="socat -d -d pty,rawer pty,rawer"
alias t="trans -speak -d en:es"
alias tmp="pushd /run/user/$(id -u)"
alias r="ranger_cd"
alias p="python3"
alias ze="zellij"
alias zl="zellij --layout"
alias todrive='rclone sync "/home/user/drive" "google-drive:"'
alias fromdrive='rclone sync "google-drive:" "/home/user/drive"'
alias lg="lazygit"
alias v="$EDITOR"
