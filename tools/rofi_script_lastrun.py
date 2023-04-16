#!/usr/bin/env python
import os
import subprocess
import sys
HISTORY_PATH = os.path.expanduser("~/.lastrun_history")
MAX_HISTORY = 14


def get_history():
    with open(HISTORY_PATH, 'r') as fhandle:
        content = fhandle.read()

    return list(content.split('\n'))


def list_options():
    for line in get_history():
        print(line)

    print(subprocess.check_output('dmenu_path').decode())


def save_command(line):
    history = get_history()[:MAX_HISTORY - 1]

    try:
        history.remove(line)
    except ValueError:
        pass

    with open(HISTORY_PATH, 'w') as fhandle:
        fhandle.write(line)
        fhandle.write('\n')
        fhandle.write('\n'.join(history))


def start_tmux_session():
    subprocess.run(['tmux', 'new-session', '-s', 'lastrun', '-d'])


def execute_command(line):
    subprocess.run(['tmux', 'send-keys', '-t', 'lastrun', line, 'ENTER'])


def main():
    if len(sys.argv) < 2:
        list_options()
    else:
        line = sys.argv[1]
        start_tmux_session()
        execute_command(line)
        save_command(line)


if __name__ == "__main__":
    main()
