#!/bin/bash
# Script Must Run as root

if [[ $EUID -ne 0 ]]; then

echo "This script must be run as root" 1>&2

exit 1

fi

apt-get update

apt-get install -y gcc

apt-get install -y wget

wget http://sourceforge.net/projects/nagios/files/nagios-3.x/nagios-3.4.4/nagios-3.4.4.tar.gz

wget http://sourceforge.net/projects/nagiosplug/files/nagiosplug/1.4.15/nagios-plugins-1.4.15.tar.gz

apt-get install -y build-essential apache2 php5-gd libgd2-xpm libgd2-xpm-dev libapache2-mod-php5

useradd nagios

groupadd nagcmd

usermod -a -G nagcmd nagios

tar zxvf nagios-3.4.4.tar.gz

tar zxvf nagios-plugins-1.4.15.tar.gz

cd nagios

./configure --with-command-group=nagcmd

make all

make install; make install-init; make install-config; make install-commandmode; make install-webconf

cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/

chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers

cd ..

cd nagios-plugins-1.4.15

./configure --with-nagios-user=nagios --with-nagios-group=nagios

make

make install

ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios

/etc/init.d/nagios start

exit 0