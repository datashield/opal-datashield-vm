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

# R studio
apt-get -y install libapparmor1
apt-get -y install gdebi-core
wget -q "http://download2.rstudio.org/${RSTUDIO}"
gdebi -n "${RSTUDIO}"
rm "${RSTUDIO}"
cp /usr/lib/rstudio-server/extras/init.d/debian/rstudio-server /etc/init.d
update-rc.d rstudio-server defaults

# Add default datashield user
adduser --disabled-password --gecos "" ${DATASHIELD_USER}
echo "${DATASHIELD_USER}:${DATASHIELD_PASS}" | chpasswd
