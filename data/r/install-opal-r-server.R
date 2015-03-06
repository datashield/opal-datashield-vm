#! /usr/bin/Rscript --vanilla

# Install datashield server R packages via opal
library(opaladmin)
o<-opal.login('administrator', 'password', url='http://localhost:8080')
print("Installing dsBase")
dsadmin.install_package(o, 'dsBase')
print("Installing dsStats")
dsadmin.install_package(o, 'dsStats')
print("Installing dsGraphics")
dsadmin.install_package(o, 'dsGraphics')
print("Installing dsModelling")
dsadmin.install_package(o, 'dsModelling')
print("Publishing methods")
dsadmin.set_package_methods(o, pkg='dsBase')
dsadmin.set_package_methods(o, pkg='dsStats')
dsadmin.set_package_methods(o, pkg='dsGraphics')
dsadmin.set_package_methods(o, pkg='dsModelling')
opal.logout(o)
