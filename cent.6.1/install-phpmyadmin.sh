#!/bin/bash

# depends on lamp.sh (php-pear)

echo 'Checking phpMyAdmin installed...'

# variables
phpMyAdminVersion='phpMyAdmin-3.4.9-all-languages'

mkdir -p /var/www/vendor

# if a file does not exist...
if [ ! -f /var/www/vendor/phpMyAdmin/config.inc.php ];
then

    echo 'phpMyAdmin not found, installing...'

    cd /var/www/vendor
    wget --quiet http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/3.4.9/$phpMyAdminVersion.tar.gz/download
    tar -xzf $phpMyAdminVersion.tar.gz
    rm $phpMyAdminVersion.tar.gz
    mv ./$phpMyAdminVersion ./phpMyAdmin
    cp -rfp ./phpMyAdmin/config.sample.inc.php ./phpMyAdmin/config.inc.php

	# DEVELOPMENT ENVIRONMENTS ONLY !!
	# setup to login with no user / pass
	sed -i "s/\$cfg\['Servers'\]\[\$i\]\['auth_type'\]\ =\ 'cookie';/\$cfg\['Servers'\]\[\$i\]\['auth_type'\]\ =\ 'config';\ \$cfg\['Servers'\]\[\$i\]\['user'\]\ =\ 'root';/" phpMyAdmin/config.inc.php
	sed -i "s/\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]\ =\ false;/\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]\ =\ true;/" phpMyAdmin/config.inc.php

    # add alias to the phpmyadmin directory under that path
    cd /etc/httpd/conf.d
    echo '' > phpMyAdmin.conf
    echo 'Alias /phpMyAdmin "/var/www/vendor/phpMyAdmin"' >> phpMyAdmin.conf
    echo '<Directory "/var/www/vendor/phpMyAdmin">' >> phpMyAdmin.conf
    echo '    AllowOverride All' >> phpMyAdmin.conf
    echo '    Options Indexes MultiViews' >> phpMyAdmin.conf
    echo '    Order allow,deny' >> phpMyAdmin.conf
    echo '    Allow from all' >> phpMyAdmin.conf
    echo '</Directory>' >> phpMyAdmin.conf

    # restart the server to kick in new settings
    /etc/init.d/httpd restart
fi