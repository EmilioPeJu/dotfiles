#!/bin/bash
# user functions

exe() { echo "\$ $@" ; "$@" ; }

function cht() {
    local language="$1"
    shift 1
    local question="$*"
    curl "cht.sh/${language}/${question}"
}

function nasmld32() {
    local NAME="${1%.*}"
    nasm -f elf32 -o ${NAME}.o $1
    ld -m elf_i386 -o $NAME ${NAME}.o
}

function yasmld64() {
    local NAME="${1%.*}"
    yasm -f elf64 -o ${NAME}.o $1 && \
        ld -m elf_x86_64 -o $NAME ${NAME}.o
}

function yasmld64debug() {
    local NAME="${1%.*}"
    yasm -g dwarf2 -f elf64 -o ${NAME}.o $1 && \
        ld -g -m elf_x86_64 -o $NAME ${NAME}.o
}

function yasm64() {
    local NAME="${1%.*}"
    # don't forget [BITS 64] inside
    yasm -m amd64 -o ${NAME} $1
}

function gpr() {
	git fetch gh pull/$1/head:pr$1
}

function cd-from-ranger()
{
    ranger_pid=$(cat /tmp/ranger.pid)
    echo "get %d" > "/tmp/ranger-ipc.in.${ranger_pid}"
    cd -- "$(cat /tmp/ranger-ipc.out.${ranger_pid})"
}

function cd-to-ranger()
{
    echo "cd $PWD" > "/tmp/ranger-ipc.in.${ranger_pid}"
}

function _rc() {
    if [[ "$1" != "" ]]; then
        [[ -f "${HOME}/.bash/${1}.sh" ]] && . "${HOME}/.bash/${1}.sh"
    else
        if [[ -n "$ZSH_VERSION" ]]; then
            source ~/.zshrc
        else
            source ~/.bashrc
        fi
    fi
}

# ssh-agent autostart
SSH_ENV="$HOME/.ssh/environment"

function start-agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
function start-agent-if-needed() {
	if [ -f "${SSH_ENV}" ]; then
	    . "${SSH_ENV}" > /dev/null
	    #ps ${SSH_AGENT_PID} doesn't work under cywgin
	    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
		start-agent;
	    }
	else
	    start_agent;
	fi
}

function incr() {
	mkdir -p "${HOME}/.counters"
	local topic="${1:-default}"
	local dst_path="${HOME}/.counters/${topic}"
	if [[ -f "${dst_path}" ]]; then
		let i=$(cat "${dst_path}")+1
		echo $i > "${dst_path}"
	else
		echo 1 > "${dst_path}"
	fi
}

function lo() {
	local PREFIX="${PREFIXPATH}"
	PREFIX="$PREFIX/$1"
	export PATH="$PREFIX/bin:$PATH"
	export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
}

function ve() {
    local NAME="$1"
    local PREFIX="${PREFIXPATH}"
    source "${PREFIX}/ve${NAME}/bin/activate"
}

function convert-script2bash() {
    local FILENAME="$1"
    cat $FILENAME | sed -n -E '/^.*$/!d; s/^[^\$]+\$ (.+)$/\1/p' | sed '1i #!/bin/bash'
}

function script2bash() {
    local FILENAME="$1"
    script "$FILENAME"
    convert-script2bash "$FILENAME" > "$FILENAME.sh"
    chmod +x "$FILENAME.sh"
}

function activate-null-sink-a() {
    PITCH="${1:-200}"
    pactl load-module module-null-sink sink_name=sink-a
    pactl load-module module-loopback sink=sink-a
    pactl load-module module-loopback sink=sink-a
    sox -t pulseaudio default -t pulseaudio sink-a pitch -${PITCH}
    pactl unload-module module-loopback
    pactl unload-module module-null-sink
}

function pacman-remove-all() {
    sudo pacman -dd -R $(pacman -Qq | grep -ve "$(pacman -Qqg base)")
}

function csc {
    find $PWD/ -name '*.c' -o -name '*.cpp' -o -name '*.h' > $PWD/cscope.files
    cscope -b
    export CSCOPE_DB="$PWD/cscope.files"
}

function cta {
    ctags --tag-relative=yes -R -f .git/tags .
}

function tags {
    cta
    csc
}

function ebpfprog() {
    bpftool prog show
    echo -n "Id: "
    read PROG_ID
    bpftool prog dump xlated id $PROG_ID
}

function ebpfcc() {
     clang -O2 -emit-llvm -c $1 -o - | \
        llc -march=bpf -filetype=obj -o "`basename $1 .c`.o"
}

function remote-dd() {
    local host="$1"
    local IF="$2"
    local OF="$3"
    ssh $host "dd if=$IF | gzip -1 -" | dd of=$OF
}

function tp {
    local TARGET="$1"
    local COMMAND="$2"
    tplink_smartplug.py -t $TARGET -c $COMMAND
}

function tp-wifi {
    local TARGET="192.168.0.1"
    local SSID="$1"
    local PASS="$2"
    # key_type 3 is WPA2
    tplink_smartplug.py -t $TARGET -j '{"netif":{"set_stainfo":{"ssid":"'"$SSID"'","password":"'"$PASS"'","key_type":3}}}'
}
