#!/bin/bash

# if a file does not exist...
if [ ! -f /etc/httpd/conf/httpd.conf ];
then

	# install lamp stack, and also dev code tools and time sync, then clean the yum cache
	yum -y install mysql mysql-devel mysql-server php php-devel httpd httpd-devel
	yum -y install php-pdo php-pear php-pecl php-mbstring php-mysql php-xml php-xmlrpc php-tidy php-gd
	yum -y install subversion git
	yum -y install ntp
	yum clean all


	# ensure (for dev) firewalls are off
	service iptables save
	service iptables stop
	chkconfig iptables off


	# ensure time, database and web servers run on boot
	chkconfig ntpd on
	chkconfig --levels 235 mysqld on
	chkconfig --levels 235 httpd on


	# ensure date.timezone is set in the /etc/php.ini
	# this replaces the line ";date.timezone =" with "date.timezone = GMT" in thephp.ini,
	# and also backs up the original to php.ini.bax
	sed -i.bak 's/\;date\.timezone\ \=/date\.timezone\ \=\ GMT/' /etc/php.ini

	# make php display errors for dev
	# note: "-i" flag not "-i.bak" since this is not the first time we've updated the file
	sed -i 's/\display_errors\ =\ Off/display_errors\ =\ On/' /etc/php.ini

	# update /var/www/html to allow .htaccess overrides
	# http://www.linuxquestions.org/questions/programming-9/replace-2nd-occurrence-of-a-string-in-a-file-sed-or-awk-800171/
	sudo sed -i.bak '0,/\ \ \ \ AllowOverride\ None/! {0,/\ \ \ \ AllowOverride\ None/ s/\ \ \ \ AllowOverride\ None/\ \ \ \ AllowOverride\ All/}' /etc/httpd/conf/httpd.conf

	# add vagrant to the apache group to aid in permissions
	usermod -a -G apache vagrant

	# disable welcome page
	rm /etc/httpd/conf.d/welcome.conf

	# change owner of the html directory to the vagrant user for dev
	chown vagrant /var/www/html
	chgrp vagrant /var/www/html

	#
	# install php pecl uploadprogress lib
	#
	pecl install uploadprogress

	# ensure the contents of the upload progress config file
	echo "; Enable upload progress" > /etc/php.d/uploadprogress.ini
	echo "extension=uploadprogress.so" >> /etc/php.d/uploadprogress.ini

fi

# restart to turn stuff on
# reboot
