# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.container import directory
from ranger.core.loader import CommandLoader
from ranger.ext.shell_escape import shell_quote

# A simple command for demonstration purposes follows.
#------------------------------------------------------------------------------

# You can import any python module as needed.
import os
import subprocess

from random import randint


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


class next_file(Command):
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


class command_filter(Command):
    def execute(self):
        if len(self.args) < 2:
            directory.command_filter = []
        else:
            directory.command_filter = self.args[1:]
        self.fm.thisdir.refilter()


class tag_filter(Command):
    def execute(self):
        if len(self.args) < 2:
            directory.tag_filter = False
        else:
            # argument is used for specifying tag, TODO: support tag selection
            directory.tag_filter = self.args[1:] 

        self.fm.thisdir.refilter()


class bulk_command(Command):
        def execute(self):
            import tempfile
            from ranger.container.file import File
            from ranger.ext.shell_escape import shell_escape as esc
            cmdfile = tempfile.NamedTemporaryFile()
            with open(cmdfile.name, 'w') as f:
                f.write('#!/usr/bin/env bash\n')
                for sel in self.fm.thistab.get_selection():
                    f.write(self.rest(1).format(esc(sel.relative_path)))
                    f.write('\n')

                f.write('echo FINISHED; read\n')

            self.fm.execute_file([File(cmdfile.name)], app='editor')
            self.fm.run(['/bin/sh', cmdfile.name], flags='w')


class pasta(Command):
    """
    :pasta <filename>
    Paste the X selection as a new file.
    """

    def execute(self):
        from os.path import join, expanduser

        filename = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        self.fm.execute_command('wl-paste > "' + filename + '"')


class diff(Command):
    def execute(self):
        self.fm.execute_console('shell nvim -d %s')
