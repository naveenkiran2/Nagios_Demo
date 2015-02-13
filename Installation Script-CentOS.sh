#!/bin/bash
# Script Must Run as root

if [[ $EUID -ne 0 ]]; then

echo "This script must be run as root" 1>&2

exit 1

fi

cd /usr/local/src

yum install -y wget

wget http://sourceforge.net/projects/nagios/files/nagios-3.x/nagios-3.3.1/nagios-3.3.1.tar.gz

wget http://sourceforge.net/projects/nagiosplug/files/nagiosplug/1.4.15/nagios-plugins-1.4.15.tar.gz

yum install -y httpd php gcc glibc glibc-common gd gd-devel make mysql mysql-devel net-snmp

useradd nagios

groupadd nagcmd

usermod -a -G nagcmd nagios

tar zxvf nagios-3.3.1.tar.gz

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

chkconfig --add nagios

chkconfig --level 3 nagios on

chkconfig --level 3 httpd on

exit 0