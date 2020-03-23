#!/bin/bash
mkdir -p /etc/sysctl.d
cat <<EOF > /etc/sysctl.d/999-coredump.conf
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

# See sysctl.d(5) for the description of the files in this directory,
# and systemd-coredump(8) and core(5) for the explanation of the
# setting below.

kernel.core_pattern=|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
EOF

cat <<EOF >> /etc/security/limits.conf

*   soft    core    unlimited
*   hard    core    unlimited

EOF

cat <<EOF > /etc/systemd/coredump.conf
[Coredump]
Storage=journal
EOF
