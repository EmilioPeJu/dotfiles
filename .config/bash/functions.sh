#!/usr/bin/env bash
# user functions

function c {
    local query=$(find .  -maxdepth 1 -type d | fzf -1 --query "$1")
    cd "$query"
}

function man2 {
    curl cht.sh/${1} 2>/dev/null | less -r
}

function ranger_cd {
    local tmp=$(mktemp)
    ranger --choosedir="$tmp"
    local dir=$(cat "$tmp")
    rm -f "$tmp"
    cd "$dir"
}

function file_by_content {
    # $1 initial query
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    INITIAL_QUERY="$1"
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --phony --query "$INITIAL_QUERY"
}

function search_edit_content() {
    local query=$(file_by_content | cut -d ":" -f 1-2 | sed "s/:/ +/")
    if [[ -n "$query" ]]; then
        $EDITOR $query
    fi
}

function exe() {
    echo "\$ $@"
    "$@"
}

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

function cd_from_ranger()
{
    local ranger_pid=$(pgrep ranger | sed 1q)
    [[ -z "$ranger_pid" ]] && return
    local ranger_dir=$(readlink -f /proc/$ranger_pid/cwd)
    cd -- "$ranger_dir"
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

function start_agent {
    echo "Initialising new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    ssh-add;
}

# Source SSH settings, if applicable
function start_agent_if_needed() {
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        #ps ${SSH_AGENT_PID} doesn't work under cywgin
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
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
    local NAME="${1:-default}"
    local PREFIX="${PREFIXPATH}"
    source "${PREFIX}/ve-${NAME}/bin/activate"
}

function create_ve() {
    local NAME="${1:-default}"
    local PREFIX="${PREFIXPATH}"
    virtualenv "${PREFIX}/ve-${NAME}"
}

function ns() {
    local NAME="${1:-default}"
    nix-shell "$HOME/nix/shell/${NAME}"
}

function create_ns() {
    local NAME="${1:-default}"
    mkdir -p "$HOME/nix/shell/${NAME}"
    $EDITOR "$HOME/nix/shell/${NAME}/default.nix"
}

function activate_null_sink_a() {
    PITCH="${1:-200}"
    pactl load-module module-null-sink sink_name=sink-a
    pactl load-module module-loopback sink=sink-a
    pactl load-module module-loopback sink=sink-a
    sox -t pulseaudio default -t pulseaudio sink-a pitch -${PITCH}
    pactl unload-module module-loopback
    pactl unload-module module-null-sink
}

function csctags {
    find $PWD/ -name '*.c' -o -name '*.cpp' -o -name '*.h' > $PWD/cscope.files
    cscope -b
    export CSCOPE_DB="$PWD/cscope.files"
}

function tags {
    ctags -R -f ./.git/tags .
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

function remote_dd_gzip() {
    local host="$1"
    local IF="$2"
    local OF="$3"
    ssh $host "dd if=$IF | gzip -1 -" | dd of=$OF
}

function tp_wifi {
    local SSID="$1"
    local PASS="$2"
    local TARGET="${3-192.168.0.1}"
    # key_type 3 is WPA2
    tplink_smartplug.py -t $TARGET -j \
        '{"netif":{"set_stainfo":{"ssid":"'"$SSID"'","password":"'"$PASS"'","key_type":3}}}'
}

function tar_cwd {
    local dirname=$(basename $PWD)
    tar cvfz /tmp/${dirname}-$(date +%y-%m-%d-%H-%M-%S).tar.gz .
}

function entr-meson-test {
    while true; do
        find . -type f -not -path ./_build |  entr -d -c -s -p meson-test
    done
}

function entr-nix-build {
    while true; do
        find . -type f -not -path ./result |  entr -d -c -s -p 'nix-build || notify-send "build failed"; notify-send "nix-build: finished"'
    done
}

function entr-make {
    while true; do
        find . -type f |  entr -d -c -s -p 'make '$*' || notify-send "build failed"; make test || notify-send "tests failed"; notify-send "make: finished"'
    done
}

function cdt {
    while [[ ! -d .git ]]; do
        cd ..
    done
}

function wal1 {
    random_choice="$(find ~/wallpapers | sort -R | head -n1)"
    f="${1:-random_choice}"
    wal -i "$f" && walogram && pywalfox update
}

# qemu helpers
function qemu-initrd {
    qemu-system-x86_64 \
        -kernel $SRCPATH/linux/arch/x86_64/boot/bzImage \
        -initrd $SRCPATH/busybox/initramfs.img \
        -s -nographic \
        "$@"
}

function gdb-qemu {
    pushd $SRCPATH/linux || return 1
    expect -f <(cat <<'EOF'
        spawn gdb "vmlinux"
        send "target remote localhost:1234\n"
        interact
EOF
    )
    popd
}

function prepare-initrd {
    pushd $SRCPATH/busybox/_install/ || return 1
    mkdir -p {proc,sys,etc,etc/init.d}
    ln -sf sbin/init
    if [[ ! -e "etc/init.d/rcS" ]]; then
        cat > etc/init.d/rcS <<'EOF'
            echo "Init started"
            mount -t proc none /proc
            mount -t sysfs none /sys
            mount -t debugfs none /sys/kernel/debug
            mount -t devtmpfs dev /dev
            # default inittab try to use the following non-existant devices
            ln -s /dev/null /dev/tty2
            ln -s /dev/null /dev/tty3
            ln -s /dev/null /dev/tty4
            ln -s /dev/null /dev/tty5
            mdev -s
            /bin/sh
EOF
        chmod +x etc/init.d/rcS
    fi
    fakeroot chown root bin/busybox
    fakeroot chmod +s bin/busybox
    find . | fakeroot cpio -o --format=newc > ../initramfs.img
    popd
}

function test-nvme-read {
    path="${1:-/dev/nvme0n1}"
    sudo fio --readonly --name=onessd --filename="$path" --filesize=100g \
        --rw=randread --bs=1m  --direct=1 --overwrite=0 --numjobs=8 \
        --iodepth=32 --time_based=1 --runtime=60 --ioengine=io_uring \
        --registerfiles --fixedbufs    --gtod_reduce=1 --group_reporting
}
