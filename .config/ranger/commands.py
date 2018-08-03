# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *
from ranger.container import directory
from ranger.core.loader import CommandLoader
# A simple command for demonstration purposes follows.
#------------------------------------------------------------------------------

# You can import any python module as needed.
import os
import re
import subprocess

from random import randint

from hir12111env import *


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.  
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    def tab(self):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


class select_random(Command):
    """:rand_select
    
    Select a random file from current dir
    """
    def execute(self):
        files_number = len(self.fm.thisdir.files)
        to_select = randint(0,files_number - 1)
        self.fm.move(to=to_select)
    def tab(self):
        return None


class goto_file(Command):
    def execute(self):
        for index,thefile in enumerate(self.fm.thisdir.files):
            if thefile.is_file:
                self.fm.move(to=index)
                return
    
    def tab(self):
        self.execute()

class sed(Command):
    """:sed <EXPRESION>
    
    Apply sed to each file selected, making it in-place 
    """
    BACKUP = False

    def execute(self):
        from subprocess import call,PIPE
        selection = self.fm.thistab.get_selection()
        if not selection:
            return
        for s_file in selection:
            path = s_file.path
            if sed.BACKUP:
                iarg = "-i.bak"
            else:
                iarg = "-i"
            exit_code = call(["/usr/bin/sed", iarg,"-e",self.rest(1), path],
                             stdin=PIPE, stderr=PIPE) 
            if exit_code:
                self.fm.notify("Error applying to " + path, bad=True)
                return
        self.fm.notify("sed finished")

    def tab(self):
        return None


class z(Command):
    def execute(self):
        dir_obtained = self.get_dirs()
        if dir_obtained:
            dir_obtained = dir_obtained[0]
            self.fm.thistab.enter_dir(dir_obtained)

    def tab(self, arg):
        for dir_item in self.get_dirs():
            self.fm.thistab.enter_dir(dir_item)
            yield "z " + dir_item

    def get_dirs(self):
        dir_list = subprocess.check_output(["/usr/bin/fasd", "-l -d", self.rest(1)]).decode("utf-8")
        if not dir_list:
            return []
        return dir_list.split("\n")


class command_filter(Command):
    def execute(self):
        if len(self.args) < 2:
            directory.command_filter = []
        else:
            directory.command_filter = self.args[1:]
        self.fm.thisdir.refilter()


class dls_go(Command):
        ROOT = "/dls_sw/prod"
        ROOT2 = "/dls"

        def get_dir(self, arg):
            # one letter match
            match = re.findall(r"^(.)$", arg)
            if match:
                section = match[0]
                selected_folder = {
                    "s": os.path.join(self.ROOT, EPICS_VERSION, "support"),
                    "i": os.path.join(self.ROOT, "etc", "init"),
                    "t": os.path.join(self.ROOT, "tools", RHEL),
                    "p": os.path.join(self.ROOT, "common", "python", RHEL)
                }.get(section, self.ROOT)
                return selected_folder
            # try beamline module match
            match = re.findall(r"^(.)(\d+)(..?)$", arg)
            if match:
                branch, bl_number, section = match[0]
                bl = "BL{}{}".format(bl_number, branch.upper())
                bl_dash = "{}{}".format(branch, bl_number)
                if branch == "j":
                    bl_dash = "i{}-1".format(bl_number)
                selected_folder = {
                    "b": os.path.join(self.ROOT, EPICS_VERSION, "support", "{}-BUILDER".format(bl)),
                    "bl": os.path.join(self.ROOT, EPICS_VERSION, "ioc", bl, "BL"),
                    "s": os.path.join(self.ROOT, EPICS_VERSION, "support", bl),
                    "ui": os.path.join(self.ROOT, EPICS_VERSION, "ioc", bl, "{}-UI-IOC-01".format(bl)),
                    "m": os.path.join(self.ROOT, "motion", bl),
                    "a": os.path.join(self.ROOT, "..", bl_dash, "epics", "autosave"),
                    "l": os.path.join(self.ROOT2, bl_dash, "epics", "logs")
                }.get(section, self.ROOT)
                return selected_folder

        def execute(self):
            if self.arg(1):
                selected_folder = self.get_dir(self.arg(1))
                self.fm.notify("Entering {}".format(selected_folder))
                self.fm.thistab.enter_dir(selected_folder)
            else:
                self.fm.thistab.enter_dir(self.ROOT)


class p(dls_go):
        ROOT = "/dls_sw/prod"


class w(dls_go):
        ROOT = "/dls_sw/work"
