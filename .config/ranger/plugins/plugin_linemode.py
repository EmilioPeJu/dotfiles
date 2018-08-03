# Compatible since ranger 1.7.0
#
# This sample plugin adds a new linemode displaying the filename in rot13.
# Load this plugin by copying it to ~/.config/ranger/plugins/ and activate
# the linemode by typing ":linemode rot13" in ranger.  Type Mf to restore
# the default linemode.

import codecs
import hashlib

import ranger.api
from ranger.core.linemode import LinemodeBase

@ranger.api.register_linemode
class MyLinemode(LinemodeBase):
    name = "rot13"
    def filetitle(self, file, metadata):
        return codecs.encode(file.relative_path, "rot_13")

@ranger.api.register_linemode
class SHA1Linemode(LinemodeBase):
    name="sha1"

    def filetitle(self, file, metadata):
        return file.relative_path

    def infostring(self, file, metadata):
        if file.is_directory:
            return "DIR"
        else:
            with open(file.path, "rb") as hash_file:
                hash_object = hashlib.sha1()
                hash_object.update(hash_file.read())
                hash_data = hash_object.hexdigest()

            return hash_data

