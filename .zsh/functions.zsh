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

function dont-show()
{
    BUFFER+=" &> /dev/null &"
    zle accept-line
}

zle -N dont-show

function _rc()
{
    source ~/.zshrc
}
