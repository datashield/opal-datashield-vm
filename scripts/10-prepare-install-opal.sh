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

# Add a more up-to-date R package repository
if [ $(grep -c '^deb http://www.stats.bris.ac.uk/R/bin/linux/ubuntu trusty/' /etc/apt/sources.list) -eq 0 ];
then
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
	sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
fi

# Add a more up-to-date mongoDB package repository
if [ $(grep -c '^deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' /etc/apt/sources.list) -eq 0 ];
then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
fi

# refresh package repos
apt-get update

# MongoDB install
apt-get install mongodb-10gen

# MySQL install
if [ ! -d /etc/mysql ];
then
  echo mysql-server mysql-server/root_password select $MYSQL_ROOT_PWD | debconf-set-selections
  echo mysql-server mysql-server/root_password_again select $MYSQL_ROOT_PWD | debconf-set-selections
	apt-get -y install mysql-server
fi
cp ../data/mysql/my.cnf /etc/mysql
service mysql restart

# Java7 install
apt-get -y install openjdk-7-jre
update-alternatives --set java /usr/lib/jvm/java-7-openjdk-i386/jre/bin/java

# execute this after Java installation so we are sure MySQL is running
echo "CREATE DATABASE opal_data CHARACTER SET utf8 COLLATE utf8_bin" | mysql -uroot -p$MYSQL_ROOT_PWD
echo "CREATE DATABASE opal_ids CHARACTER SET utf8 COLLATE utf8_bin" | mysql -uroot -p$MYSQL_ROOT_PWD
echo "CREATE USER '$MYSQL_OPAL_USER'@'localhost' IDENTIFIED BY '$MYSQL_OPAL_PWD'" | mysql -uroot -p$MYSQL_ROOT_PWD
echo "GRANT ALL ON opal_data.* TO '$MYSQL_OPAL_USER'@'localhost'" | mysql -uroot -p$MYSQL_ROOT_PWD
echo "GRANT ALL ON opal_ids.* TO '$MYSQL_OPAL_USER'@'localhost'" | mysql -uroot -p$MYSQL_ROOT_PWD
echo "FLUSH PRIVILEGES" | mysql -uroot -p$MYSQL_ROOT_PWD
