#!/bin/bash
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# exit on errors
set -euo pipefail


source common
check_root

# Opal install
echo opal opal-server/admin_password select $OPAL_PWD | debconf-set-selections
echo opal opal-server/admin_password_again select $OPAL_PWD | debconf-set-selections
if [[ -z "$1" ]]; then
    apt-get install -y opal
else
    #  The 'daemon' package is a dependency of Opal, however dpkg does not
    #  resolve dependcies.
    apt-get install -y daemon
    dpkg -i "$1"
fi
apt-get install -y opal-python-client

# R dependencies
apt-get install -y opal-rserver
service rserver restart

# Add databases in Opal so we are sure that Opal is running
echo "Create Opal databases"

for i in ${DATABASES[@]}; do

    opal rest \
        -o http://localhost:8080 \
        -u administrator \
        -p $OPAL_PWD \
        -m POST /system/databases \
        --content-type "application/json" \
        < "${DATABASES_DIR}/${i}.json"

done
