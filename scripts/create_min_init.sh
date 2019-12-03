#!/bin/bash
# From: https://superuser.com/questions/320529/how-to-create-a-linux-system-that-runs-a-single-application/991733#991733
cat <<EOF > init.S
.global _start
_start:
    mov \$1, %rax
    mov \$1, %rdi
    mov \$message, %rsi
    mov \$message_len, %rdx
    syscall
    jmp .
    message: .ascii "FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR\\n"
    .equ message_len, . - message
EOF

mkdir -p d &&
as --64 -o init.o init.S &&
ld -o d/init init.o &&
cd d &&
chmod +x init &&
find . | cpio -o -H newc | gzip > $SRCPATH/minrootfs.cpio.gz
