#Overview

Builds a vagrant box based on CentOS 6.5 with Oracle 11.2.0.4.

##Usage

Does not include Oracle software - create cookbooks/oracle/files/default/oracle and place the Oracle 11.2.0.4 x64 linux distribution, p13390677_112040_Linux-x86-64_1of7.zip through p13390677_112040_Linux-x86-64_7of7.zip in it.

Run 'vagrant up' to create the box.  The final step will zero out free space so 'vagrant package' will make a minimal sized box.

##Test Kitchen

The cookbooks/oracle directory contains a .kitchen.yml file that can be used to run the recipes under test kitchen.


##Accounts

* vagrant passwd:vagrant
* oracle passwd:oracle
* root passwd:vagrant