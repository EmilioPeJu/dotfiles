TOP = ../../..
include $(TOP)/configure/CONFIG

# these are options to create_gui.py
allow_remove = no
log_level = WARNING

SCRIPTS += launch_gui
SCRIPTS += launch.nws

DATA += {{cookiecutter.domain}}-create-gui.xml
DB += {{cookiecutter.domain}}.db

include $(TOP)/configure/RULES

{{cookiecutter.domain}}-create-gui.xml: launch_gui

../O.Common/{{cookiecutter.domain}}.db: {{cookiecutter.domain}}.db
	cp $< $@

{{cookiecutter.domain}}.db: launch_gui
launch.nws: launch_gui

launch_gui: ../create_gui.py $(TOP)/configure/RELEASE $(TOP)/data/{{cookiecutter.domain}}-gui.xml $(wildcard ../*.opi)
	chmod +x $<
	$< --allow_remove=$(allow_remove) --log_level=$(log_level)
	chmod +x ../InsertNwsTop
	../InsertNwsTop

clean::
	rm -f $(shell grep -l 'Opening and saving this file in cs-studio will delete this comment and stop dls_xmlbuilder regenerating it' *.opi)

