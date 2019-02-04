# .bash_profile
# Diamond wide default setup, please do all modifications in ~/.bashrc_user
# $Id: skel_bash_profile 898 2007-05-10 09:56:05Z bnh65367 $
# $URL: https://trac.diamond.ac.uk/svn/sysadmin/cfengine/branches/testing/files/skel_bash_profile $

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
if [ -f /dls_sw/etc/profile ]; then
	. /dls_sw/etc/profile
fi

# User specific environment and startup programs
if [ -f ~/.bashrc_user ]; then
	. ~/.bashrc_user
fi

