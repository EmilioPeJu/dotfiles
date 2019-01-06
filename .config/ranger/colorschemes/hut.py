# This file is part of ranger, the console file manager.
# License: GNU GPL version 3, see the file "AUTHORS" for details.

from ranger.gui.color import *
from ranger.colorschemes.snow import Snow

class Scheme(Snow):
    def use(self, context):
        fg, bg, attr = Snow.use(self, context)

        if context.in_browser:
            if context.executable and not any((context.directory,
                                               context.media,
                                               context.document)):
                fg = green
                fg += BRIGHT
            elif not context.selected and context.link:
                fg = cyan
            elif context.device:
                fg = yellow + BRIGHT
            elif context.image:
                fg = yellow
            elif context.audio:
                fg = 13
            elif context.document:
                fg = 106
            elif context.media:
                fg = magenta
            if not context.selected and (context.cut or context.copied):
                fg = 9

        if getattr(context, 'scaffold', False):
            fg = 208

        return fg, bg, attr
