bindkey -e # emacs gagnang style
bindkey '\e[B'      history-search-forward    # down arrow
bindkey '\e[A' history-search-backward        # up arrow
bindkey '^Za'   cd-ranger
bindkey '^Zs'   ranger-cd
bindkey '^Zd'   ranger-getsel
bindkey '\e#' comment

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

bindkey '^[j' dont-show
