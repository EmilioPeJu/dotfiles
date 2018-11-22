import os
import re

# EPICS_BASE = os.environ["EPICS_BASE"]
# EPICS_VERSION = EPICS_BASE.split('/')[3]
# override for using the old one
EPICS_VERSION = "R3.14.12.3"

if os.access('/etc/redhat-release', os.R_OK):
    rhel_release_data = open("/etc/redhat-release", "r").read()
    RHEL_MAJOR = re.findall(r"\d", rhel_release_data)[0]
    RHEL = "RHEL{0}-x86_64".format(RHEL_MAJOR)

class dls_tree_helper(object):
    ROOT = "/dls_sw/prod"
    ROOT2 = "/dls"

    def get_dir(self, arg):
        # one letter match
        match = re.findall(r"^(.)$", arg)
        if match:
            section = match[0]
            selected_folder = {
                "s": os.path.join(self.ROOT, EPICS_VERSION, "support"),
                "i": os.path.join(self.ROOT, EPICS_VERSION, "ioc"),
                "e": os.path.join(self.ROOT, "etc", "init"),
                "t": os.path.join(self.ROOT, "tools", RHEL),
                "p": os.path.join(self.ROOT, "common", "python", RHEL)
            }.get(section, self.ROOT)
            return selected_folder
        # try beamline module match
        match = re.findall(r"^(.)(\d+)(..?)$", arg)
        if match:
            branch, bl_number, section = match[0]
            bl = "BL{0}{1}".format(bl_number, branch.upper())
            bl_dash = "{0}{1}".format(branch, bl_number)
            if branch == "j":
                bl_dash = "i{0}-1".format(bl_number)
            selected_folder = {
                "b": os.path.join(self.ROOT, EPICS_VERSION, "support",
                                  "{0}-BUILDER".format(bl)),
                "bl": os.path.join(self.ROOT, EPICS_VERSION, "ioc", bl, "BL"),
                "i": os.path.join(self.ROOT, EPICS_VERSION, "ioc", bl),
                "s": os.path.join(self.ROOT, EPICS_VERSION, "support", bl),
                "ui": os.path.join(self.ROOT, EPICS_VERSION, "ioc", bl,
                                   "{0}-UI-IOC-01".format(bl)),
                "m": os.path.join(self.ROOT, "motion", bl),
                "a": os.path.join(self.ROOT, "..", bl_dash, "epics",
                                  "autosave"),
                "l": os.path.join(self.ROOT2, bl_dash, "epics", "logs")
            }.get(section, self.ROOT)
            return selected_folder


class dls_work_tree_helper(dls_tree_helper):
        ROOT = "/dls_sw/work"


class dls_prod_tree_helper(dls_tree_helper):
        ROOT = "/dls_sw/prod"
