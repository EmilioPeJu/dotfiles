set disassembly-flavor intel
# Workaround tui problem
# define hook-next
# 	refresh
# end
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

define make
    shell make
    python gdb.execute("file " + gdb.current_progspace().filename)
    # clear cache
    directory
    refresh
end
