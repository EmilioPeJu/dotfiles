# Tested with ranger 1.7.0 through ranger 1.7.*
#
# This plugin creates a FIFO in /tmp/ranger-ipc.<PID> to which any
# other program may write. Lines written to this file are evaluated by
# ranger as the ranger :commands.
#
# Example:
#   $ echo tab_new ~/images > /tmp/ranger-ipc.1234

import ranger.api

old_hook_init = ranger.api.hook_init


def hook_init(fm):
    try:
        # Create a FIFO.
        import os
        ranger_pid=os.getpid()
        IPC_FIFO_IN = "/tmp/ranger-ipc.in." + str(ranger_pid)
        IPC_FIFO_OUT = "/tmp/ranger-ipc.out." + str(ranger_pid)
        PID_FILE = "/tmp/ranger.pid"
        with open(PID_FILE, "w") as pid_file:
            pid_file.write(str(ranger_pid))
        os.mkfifo(IPC_FIFO_IN)
        os.mkfifo(IPC_FIFO_OUT)

        # Start the reader thread.
        try:
            import thread
        except ImportError:
            import _thread as thread
        def ipc_reader(in_filepath,out_filepath):
            while True:
                with open(in_filepath, 'r') as in_fifo:
                    line = in_fifo.read()
                    if len(line)>4 and line[0:4]=="get ":
                        result = fm.substitute_macros(line[4:])
                        with open(out_filepath,"w") as out_fifo:
                            out_fifo.write(result)
                    else:
                        fm.execute_console(line.strip())
        thread.start_new_thread(ipc_reader, (IPC_FIFO_IN, IPC_FIFO_OUT))

        # Remove the FIFO on ranger exit.
        def ipc_cleanup(filepath):
            try:
                os.unlink(filepath)
            except IOError:
                pass
        import atexit
        atexit.register(ipc_cleanup, IPC_FIFO_IN)
    except IOError:
        # IPC support disabled
        pass
    finally:
        old_hook_init(fm)


ranger.api.hook_init = hook_init
