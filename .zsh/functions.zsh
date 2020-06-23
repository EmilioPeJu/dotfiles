function cd-ranger()
{
    pid=$(cat /tmp/ranger.pid)
    echo "get %d" > /tmp/ranger-ipc.in.${pid}
    cd $(cat /tmp/ranger-ipc.out.${pid})
    zle reset-prompt
}

zle -N cd-ranger

function comment()
{
    if [ "${BUFFER:0:2}" = "# " ] ;
    then
        BUFFER="${BUFFER:2}"
    else
        LBUFFER="# ${LBUFFER}"
    fi
}

zle -N comment

# delete autosource file associated to
# current directory
function da()
{
    local sourcefile="${HOME}/.zsh/autosource${PWD}.sh"
    rm -rf "$sourcefile"
    # trigger chpwd hook
    cd "$PWD"
}

# edit autosource file associated to
# current directory
function ea()
{
    local sourcefile="${HOME}/.zsh/autosource${PWD}.sh"
    mkdir -p "${sourcefile%/*}"
    $EDITOR "$sourcefile"
    # trigger chpwd hook
    cd "$PWD"
}

function dont-show()
{
    BUFFER+=" &> /dev/null &"
    zle accept-line
}

zle -N dont-show

function rc()
{
    source ~/.zshrc
}
