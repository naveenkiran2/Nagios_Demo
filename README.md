# Nagios_Demo
Getting started with Nagios infrastructure monitoring tool repository!
This repository contains a step by step guide for Nagios tool installation including the source files.
The scripts folder contains everything you need for the installation both for Ubuntu and CentOS.
You can find my presentation slides [here](http://www.slideshare.net/PanagiotisGarefalaki/storage-managment-using-nagios).


## Installation instructions (Tested on Ubuntu -- Copied from the instructions file)
###-----------Nagios Core-------------
###### A)Dependencies:
  * sudo apt-get install build-essential
  * sudo apt-get install apache2 php5-gd
  * sudo apt-get install libgd2-xpm libgd2-xpm-dev libapache2-mod-php5

###### B)Locate The Zipped files given:
  * Nagios Plugins
  * Nagios Core

###### C)Extract:
  * tar zxvf nagios-3.4.4.tar.gz
  * tar zxvf nagios-plugins-1.4.16.tar.gz

###### D)Nagios User and Group:
  * useradd nagios
  * groupadd nagcmd
  * usermod -a -G nagcmd nagios

###### E)Configure
  * cd nagios
  * ./configure --with-nagios-group=nagios --with-command-group=nagcmd 
  * ./configure --with-mail=/usr/bin/sendmail

###### F)Install 
  * make all
  * make install
  * make install-init
  * make install-config
  * make install-commandmode
  * make install-webconf

###### Starting the service:
  * cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
  * chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers
  * /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

  Now you can start up Nagios:
  * /etc/init.d/nagios start

  Change password:
  * htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
  **OR
  **Alternate instructions
  * cd /usr/local/nagios/etc 
  * htpasswd -c htpasswd.users nagiosadmin

###-----------Nagios Plugins-------------
  * cd /tmp/nagios-plugins-1.4.16
  * ./configure --with-nagios-user=nagios --with-nagios-group=nagios
  * make
  * make install

  * ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios

**At this point you should be done and should be able to use your browser using [http://<your nagios ip>/nagios ] and everything should be running well. **
If not try rebooting!

**if you try these commands to check if Nagios is running you may get a positive on the first and a definite "Config error" on the service nagios start
* ps aux | grep bin/nagios (to check if it's running)
* service nagios start (will start nagios)
