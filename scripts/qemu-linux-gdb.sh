#!/bin/bash
cd /code/src/linux
export PYTHONPATH="$(pwd)/scripts/gdb"

ESCRIPT="$(mktemp)"
cat > "$ESCRIPT" <<EOF
spawn gdb "vmlinux"
send "target remote localhost:1234\n"
interact
EOF

expect -f "$ESCRIPT"
