set disassembly-flavor intel
# workarount tui problem
define hook-next
    refresh
end
# program output in another tty
# tty /dev/pts/1
# attach to child processes too
set detach-on-fork off
# Unrecognized breakpoint location should automatically result in a 
# pending breakpoint being created
set breakpoint pending on
# source ~/.gdbinit-gef.py
# source ~/.gdbinit-gef-user.py
# gef config mmregs.enable False
# gef config mmregs.n 3
set auto-load safe-path ~/src/linux
tui new-layout default regs 1 {-horizontal src 1 asm 1} 2 status 0 cmd 1
tui layout default
tui enable
