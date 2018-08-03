function cd-ranger()
{
    pid=$(cat /tmp/ranger.pid)
    echo "get %d" > /tmp/ranger-ipc.in.${pid}
    cd $(cat /tmp/ranger-ipc.out.${pid})
    zle reset-prompt
}

zle -N cd-ranger

function ranger-cd()
{
    pid=$(cat /tmp/ranger.pid)
    echo "cd $PWD" > "/tmp/ranger-ipc.in.${pid}"
}

zle -N ranger-cd

function ranger-getsel()
{
    pid=$(cat /tmp/ranger.pid)
    echo "get %s" > /tmp/ranger-ipc.in.${pid}
    LBUFFER+=$(cat /tmp/ranger-ipc.out.${pid})
}

zle -N ranger-getsel

function comment()
{
    if [ "${BUFFER:0:2}" = "# " ] ;
    then
        BUFFER="${BUFFER:2}"
    else
        BUFFER="# ${BUFFER}"
    fi
}

zle -N comment

function dont-show()
{
    BUFFER+=" &> /dev/null &"
    zle accept-line
}

zle -N dont-show

function make-target() 
{
    BUFFER="make $BUFFER"
    zle accept-line
}

zle -N make-target

function rc()
{
    source ~/.zshrc
}
