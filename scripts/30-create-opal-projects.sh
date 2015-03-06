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

for i in ${PROJECTS[@]}; do

    opal rest \
        -o https://localhost:8443 \
        -u administrator \
        -p password \
        -m POST /projects \
        --content-type "application/json" \
        < "${PROJECT_DIR}/${i}.json"

done
