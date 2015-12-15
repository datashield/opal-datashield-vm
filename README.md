# opal-datashield-vm

Scripts for installing Opal and DataSHIELD on an Ubuntu 14.04 i386 server.

For use when creating new versions of the DataSHIELD test environment.

These scripts borrow from the
[vagrant-obiba](https://github.com/obiba/vagrant-obiba) repo. If you only require
a temporary Opal and DataSHIELD VM, you might like to consider using vagrant
instead of these scripts.

## What do the scripts do?

* Installs Opal (The most recently released version from ObiBa, or
  optionally you can supply a .deb file for a development version.)
* Creates three projects in Opal: CNSIM, DASIM, SURVIVAL.
* Adds three sets of simulated data with data dictionaries for each project.
* Installs DataSHIELD.
* Installs RStudio web interface (for using the server as a client).
* TODO: write script that uses the Opal API to upload data dictionaries.


## Usage

While logged into a new install of 14.04:

1. Download and extract the latest version from the DataSHIELD
GitHub

```
$ wget -qO - https://github.com/datashield/opal-datashield-vm/archive/$VERSION.tar.gz | tar -xvz
```

2. Switch to root and run the install script

```
$ sudo su
# cd opal-datashield-vm-*
# ./install.sh
```

#### Notes:

* You may want to review `install.sh` and alter which components are installed.
  For example, deleting the line that runs the script to install RStudio.

* If you wish to install a specific version of Opal by supplying a .deb file,
  first copy the .deb file onto the VM, then the path to this file can be passed
  as an argument to the `-o` option of `install.sh`:

```
# ./install.sh -o /path/to/opal.deb
```
