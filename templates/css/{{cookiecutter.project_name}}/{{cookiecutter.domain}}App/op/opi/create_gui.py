#!/bin/env dls-python
import sys, os
import subprocess # For calling Xvfb
import atexit

# add the following for debugging
# --log_level=DEBUG

# run from gui_builder/dls_epicsparser source
# ===========================================
#sys.path.append("/dls_sw/work/common/python/dls_guibuilder")
#sys.path.append("/dls_sw/work/common/python/dls_epicsparser")

# run from COMPILED gui_builder/dls_epicsparser
# =============================================
# sys.path.append("/dls_sw/work/common/python/dls_guibuilder/prefix/lib/python2.7/site-packages")
# sys.path.append("/dls_sw/work/common/python/dls_epicsparser/prefix/lib/python2.7/site-packages")

# dls_epicsparser should be pulled in automatically from dls_guibuilder now
# so no need to import it separately.
from pkg_resources import require
require("dls_guibuilder")

# If we are running on a headless machine DISPLAY will be unset. So start Xvfb
# (a virtual X window server) and point DISPLAY to it. This is required for
# tkinter (which is used by dls_guibuilder for font rendering) to initialise
# successfully.
xvfbProcess = subprocess.Popen(["Xvfb", ":10"])

try:
    os.environ["DISPLAY"]
except KeyError:
    os.environ["DISPLAY"] = ":10"

@atexit.register
def killXvfb():
    xvfbProcess.kill()

from dls_guibuilder import GuiBuilder, Pv, BoyScreen

gb = GuiBuilder()
gb.parse_release('configure/RELEASE')
gb.add_defs_from_xml('data/{{cookiecutter.domain}}-gui.xml')

def add_rga(name, device):
    s2 = BoyScreen("boyembed", "rgamv2App_opi/rga_embed.opi",
                   macros="device=" + device)
    s1 = BoyScreen("boycomponent", "rgamv2App_opi/rga.opi",
                   macros="device=" + device)
    sevr = Pv("sevr", device + ':STA')
    gb.add_def(name, s1, s2, sevr)


def add_fast_valve_gauge_interlock(name, device):
    mlist = "device={},name={}".format(device, name)
    s1 = BoyScreen("boyembed", "mks937bApp_opi/fvg_embed.opi", macros=mlist)
    s2 = BoyScreen("boydetail", "mks937bApp_opi/fvg_detail.opi", macros=mlist)
    sevr = Pv("sevr", device)
    gb.add_def(name, s1, s2, sevr)


# Add front end defs (we have to  manually describe the Gui elements since we have no IOC to refer to)
def add_external_valve(name, device, macros):
    macros = "device=%s,%s" % (device, macros)
    s1 = BoyScreen("boyembed", "dlsPLCApp_opi/vacValve_embed_box.opi",
                   macros=macros)
    s2 = BoyScreen("boyembed", "dlsPLCApp_opi/vacValve_embed.opi",
                   macros=macros)
    s3 = BoyScreen("boydetail", "dlsPLCApp_opi/vacValve_detail.opi",
                   macros=macros)
    sevr = Pv("sevr", device + ':STA')
    gb.add_def(name, s1, s2, s3, sevr)


# Add definitions matching extra_def_format to the screen. This allows us to take widgets from separate component screen.
def create_component_with_defs(name, P, extra_def_format, description,
                               regex=False):
    extra_defs = gb.find(name=extra_def_format, regex=regex)
    component_defs = gb.create_dotted(name, P)
    gb.create_component(name, P, defs=component_defs + extra_defs,
                        description=description)

add_external_valve('FE.V2', 'FE{{cookiecutter.domain[2:]}}-VA-VALVE-02',
                   'DESC=FE Valve 2,valvetype=valve,name=FV2')
add_external_valve('FE.Absorber', 'FE{{cookiecutter.domain[2:]}}-RS-ABSB-01',
                   'DESC=FE Absorber,valvetype=absorber,name=FABS')
add_external_valve('FE.Shutter', 'FE{{cookiecutter.domain[2:]}}-PS-SHTR-02',
                   'DESC=FE Shutter,valvetype=shutter,name=FSHTR')
add_external_valve('FE.PortShutter', 'FE{{cookiecutter.domain[2:]}}-PS-SHTR-01',
                   'DESC=Port Shutter,valvetype=shutter,name=FPORT')

# Create component screens
gb.create_component('FE', '{{cookiecutter.domain}}-CS-FEND-01', description='Front End')

# Make the synoptic
definitions = gb.find_from_screen('synoptic.opi')
synoptic = gb.create_screen(definitions, 'synoptic.opi')
# REVIEW - the below is not working - to be investigated
gb.add_def("Synoptic", synoptic)

# create Vacuum Screens
tees = [
    ("SP1", "GAUGE1", "IMG1", "PIRG1", "IONP1", "RGA1"),
    ("SP2", "GAUGE2", "IMG2", "PIRG2", "IONP2"),
    ("SP3", "GAUGE3", "IMG3", "PIRG3", "IONP3", "RGA2"),
    ("SP4", "GAUGE4", "IMG4", "PIRG4", "IONP4", "RGA3"),
]
vacDefs = gb.find(
    screen_file=["*vacValve_embed.opi", '*ionp_embed.opi', "*space_embed.opi", "*gauge_embed.opi", "*img_embed.opi",
                 "*pirg_embed.opi"])
vacuumSummary = gb.create_screen(vacDefs, '{{cookiecutter.domain}}-vacuum.opi', style='vacuum', synoptic=synoptic, pump_tees=tees)

# Make Hardware Status Screen 
iocs = [
    ("{{cookiecutter.domain}}-VA-IOC-01", "Vacuum"),
    ("{{cookiecutter.domain}}-MO-IOC-01", "Motion"),
]

# some flags to control hardware status screen creation
doHardwareStatus = True
autoProcServControl = True

# Create hardware status screens
if doHardwareStatus:
    ioc_defs = []
    for ioc_name, ioc_desc in iocs:
        procServs = gb.find(name="%s.*" % ioc_name, screen_file="*procServ*")
        crateMons = gb.find(name="%s.*" % ioc_name, screen_file="*crateMon*")
        if not autoProcServControl:
            assert procServs + crateMons, "No procServ or crateMon element found for %s" % ioc_name
        devIocStats = gb.find(name="%s.*" % ioc_name, screen_file="devIocStats*")
        assert len(devIocStats) < 2, "More than 1 devIocStats element found for %s" % ioc_name
        autoSaves = gb.find(name="%s.*" % ioc_name, screen_file="*autosave*")
        assert len(autoSaves) < 2, "More than 1 autoSave element found for %s" % ioc_name
        # These are the macros to pass to BLGuiApp_opi/*_ioc_status_embed.opi
        macros = dict(
            IOC=ioc_name,
            desc=ioc_desc,
            iocstats=len(devIocStats),
            autosave=len(autoSaves)
        )
        if autoProcServControl:
            # this must be a soft IOC
            filename = "BLGuiApp_opi/soft_ioc_status_embed.opi"
            # need to supply pv prefix for procServ
            macros["PROCSERV"] = ioc_name
        elif len(procServs) == 1:
            # this must be a soft IOC
            filename = "BLGuiApp_opi/soft_ioc_status_embed.opi"
            # need to supply pv prefix for procServ
            macros["PROCSERV"] = procServs[0].screens[0].macro_dict["P"]
        elif len(crateMons) == 1:
            # this must be a real IOC
            filename = "BLGuiApp_opi/real_ioc_status_embed.opi"
            # need to supply pv prefix for crateMon
            macros["CMON"] = crateMons[0].screens[0].macro_dict["device"]
        else:
            raise AssertionError("Can't create IOC embedded object from %d procServer and %d crateMon objects" % (
                len(procServs), len(crateMons)))

        if len(autoSaves) == 1:
            macros["AUTOSAVE"] = autoSaves[0].screens[0].macro_dict["device"]
        # now create the embedded screen
        synoptic = BoyScreen("boyembed", filename, macros)
        # and add it to a Def representing the ioc
        ioc_defs.append(gb.add_def(ioc_name, synoptic))

    # we can now make our hardware status screen
    synoptic = gb.create_screen(ioc_defs, "{{cookiecutter.domain}}-hardware")
    gb.add_def("Hardware", synoptic)


# Write the output
gb.write_screens()
gb.write_database('{{cookiecutter.domain}}.db')
gb.write_xml('{{cookiecutter.domain}}-create-gui.xml')
gb.write_launch_gui('{{cookiecutter.domain}}', 'synoptic.opi')

# The CSS oriented BL IOC does not provide NTEMP, NFLOW etc for the modules.
# These are required by various parts of the EDM GUI, so for compatibility
# until the EDM GUI is retired, we generate the required PVs here and tag
# them on the end of the database.

def createN(t, p, n):
    return "\nrecord(ao, \"%s:INFO:N%s\") {\n  field(VAL, \"%s\")\n  field(PINI, \"YES\")\n}" % (p, t, n)

db_filename = "{{cookiecutter.domain}}.db"
dbFile = open(db_filename, 'r')
db = dbFile.read()
dbFile.close()
db += createN("FLOW", "{{cookiecutter.domain}}-AL-SLITS-01", 1)
dbFile = open(db_filename, 'w')
dbFile.write(db)
dbFile.close()




