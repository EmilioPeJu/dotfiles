#!/usr/bin/env python


def get_stdin_from_file():
    import os
    import sys
    TEST_FILE = 'in1'
    if os.environ.get('DEBUG', '0') != '0' \
            and os.access(TEST_FILE, os.R_OK):
        sys.stdin = open(TEST_FILE, 'r')


def main():
    get_stdin_from_file()


if __name__ == "__main__":
    main()
