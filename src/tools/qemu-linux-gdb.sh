#!/usr/bin/env bash
cd $SRCPATH/linux
export PYTHONPATH="$(pwd)/scripts/gdb"

# don't forget to enable CONFIG_GDB_SCRIPTS
ESCRIPT="$(mktemp)"
cat > "$ESCRIPT" <<EOF
spawn gdb "vmlinux"
send "target remote localhost:1234\n"
interact
EOF

expect -f "$ESCRIPT"
