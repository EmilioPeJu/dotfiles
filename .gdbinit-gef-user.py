
class MMRegisters(GenericCommand):
    """ Show AVX registers """
    _cmdline_ = "mmregs"
    _syntax_  = "{:s}".format(_cmdline_)

    def __init__(self):
        super(MMRegisters, self).__init__()
        set_gef_setting("mmregs.type", "float", str, "Type of elements in registers")
        set_gef_setting("mmregs.enable", 0, bool, "Show on stop")
        set_gef_setting("mmregs.n", 16, int, "Number of registers to show")

    @only_if_gdb_running         # not required, ensures that the debug session is started
    def do_invoke(self, argv):
        arg_to_type = ["name", "float", "double", "int8", "int16", "int32",
                       "int64", "int128"]
        if argv and argv[0] in arg_to_type:
            selection = arg_to_type.index(argv[0])
        else:
            selection = arg_to_type.index(get_gef_setting("mmregs.type"))

        for index in range(get_gef_setting("mmregs.n")):
            mm_val = gdb.execute("info registers ymm{}".format(index), to_string=True)
            mm_format_val = mm_val.strip().split('\n')[selection]
            print("ymm{}: {}".format(index, mm_format_val))
        return

register_external_command(MMRegisters())

def do_mmregs(event):
    if get_gef_setting("mmregs.enable"):
        gdb.execute("mmregs")
    return

gef_on_stop_hook(do_mmregs)

