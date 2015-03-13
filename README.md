# opal-datashield-vm

Scripts for installing Opal and DataSHIELD on an Ubuntu 14.04 i386 server.

For use when creating new versions of the DataSHIELD test environment.

These scripts borrow from the
[vagrant-obiba](https://github.com/obiba/vagrant-obiba) repo. If you only require
a temporary Opal and DataSHIELD VM, you might like to consider using vagrant
instead of these scripts.

## Contents

* Installs Opal
* Creates three projects for the test data in Opal
* Adds files for three sets of test data to Opal
* Installs DataSHIELD server and client packages
* Installs RStudio web interface (for using this server as a client)
* TODO: There is no way to automatically upload a data dictionary into an Opal
  Project. Data dictionaries and test data will available on Opal's file system
  and the relevant projects will be created, but you must add the dictionaries
  to those projects and import the data manually through the Opal web interface.


## Usage

While logged into a new install of 14.04:

1. Download and extract the lastest release from the DataSHIELD
github

```
$ wget -qO - https://github.com/datashield/opal-datashield-vm/archive/$VERSION.tar.gz | tar -xvz
```
2. Switch to root and run the install script

```
$ sudo su
# cd opal-datashield-vm-*
# ./install.sh
```
