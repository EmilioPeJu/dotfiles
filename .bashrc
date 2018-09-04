# .bashrc
# Diamond wide default file, please do local modifiactions in ~/.bashrc_local
# $Id: skel_bashrc 898 2007-05-10 09:56:05Z bnh65367 $
# $URL: https://trac.diamond.ac.uk/svn/sysadmin/cfengine/branches/testing/files/skel_bashrc $
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# source user defined stuff
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
