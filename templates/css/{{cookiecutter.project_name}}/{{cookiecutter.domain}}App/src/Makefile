TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
# In a Diamond IOC Application, build xml files from
# database files like this
#

# The device status IOC
PROD_IOC += {{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01
DBD += {{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01.dbd

{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_DBD += base.dbd
{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_DBD += iocAdmin.dbd
{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_DBD += calcSupport.dbd

{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_SRCS_Linux += {{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_registerRecordDeviceDriver.cpp
{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_SRCS_Linux += {{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01Main.cpp

{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_LIBS += devIocStats
{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_LIBS += calc
{{cookiecutter.domain}}-{{cookiecutter.technical_area}}-IOC-01_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
