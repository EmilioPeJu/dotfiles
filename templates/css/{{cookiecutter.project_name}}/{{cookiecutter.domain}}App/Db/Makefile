TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
# In a Diamond IOC Application, build db files from
# template files like this
#
DB += {{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01.db

#----------------------------------------------------
# In a Diamond IOC Application, build xml files from
# database files like this
#

# List database files required.
USES_DB += ../O.Common/{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01.db
# USES_DB += $(VA02)/db/BL21I-VA-IOC-02_expanded.db

DATA += {{cookiecutter.domain}}-gui.xml
DATA += {{cookiecutter.domain}}.grp

include $(TOP)/configure/RULES

#----------------------------------------
#  ADD RULES AFTER THIS LINE

{{cookiecutter.domain}}.grp: parser-output-{{cookiecutter.domain}}

{{cookiecutter.domain}}-gui.xml: parser-output-{{cookiecutter.domain}}

parser-output-{{cookiecutter.domain}} : $(USES_DB)
	PYTHONPATH=/dls_sw/work/common/python/dls_epicsparser/prefix/lib/python2.7/site-packages /dls_sw/work/common/python/dls_epicsparser/prefix/bin/epicsparser.py $^ -r {{cookiecutter.domain}} -s 'ar,gui'> $@
