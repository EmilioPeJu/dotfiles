# Compatible since ranger 1.7.0 (git commit c82a8a76989c)
#
# This plugin filters files based on a command return code

# Save the original filter function

from __future__ import (absolute_import, division, print_function)

import os
import subprocess

import ranger.container.directory

ACCEPT_FILE_OLD = ranger.container.directory.accept_file

ranger.container.directory.tag_filter = False


# Define a new one
def custom_accept_file(fobj, filters):
    if not ACCEPT_FILE_OLD(fobj, filters):
        return False

    tag_enable = ranger.container.directory.tag_filter

    if tag_enable and fobj.realpath not in fobj.fm.tags:
            return False

    return True


# Overwrite the old function
ranger.container.directory.accept_file = custom_accept_file
