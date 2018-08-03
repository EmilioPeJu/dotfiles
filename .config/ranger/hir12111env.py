import os
import re

# EPICS_BASE = os.environ["EPICS_BASE"]
# EPICS_VERSION = EPICS_BASE.split('/')[3]
# override for using the old one
EPICS_VERSION = "R3.14.12.3"

if os.access('/etc/redhat-release', os.R_OK):
    rhel_release_data = open("/etc/redhat-release", "r").read()
    RHEL_MAJOR = re.findall(r"\d", rhel_release_data)[0]
    RHEL = "RHEL{}-x86_64".format(RHEL_MAJOR)

