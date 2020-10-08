# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

autoload -U add-zsh-hook
local hassource=''

# function to autoload source file based on current directory
# if we change to /home/user the loaded script will be
# ~/.zsh/autosource/home/user.sh
# note: it is not possible to use it for the root directory
function autosource_chpwd {
    local sourcefile="${HOME}/autosource${PWD}.sh"
    if [ -f "$sourcefile" ]; then
        . "$sourcefile"
        hassource="(${PWD##*/}) "
    else
        hassource=''
    fi
}

add-zsh-hook chpwd autosource_chpwd
local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"
PROMPT='${hassource}%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} %B»%b '
RPS1="${return_code}"
