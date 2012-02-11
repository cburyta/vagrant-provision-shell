#!/bin/bash


# add includes call to httpd conf
echo "" >> /etc/httpd/conf/httpd.conf
echo "NameVirtualHost *:80" >> /etc/httpd/conf/httpd.conf
echo "" >> /etc/httpd/conf/httpd.conf
echo "Include sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
echo "" >> /etc/httpd/conf/httpd.conf

# create sites-enabled dir for the configs
mkdir /etc/httpd/sites-enabled

# @todo finish this script

# create a site in the vhost sites enabled
# echo ""
# 
# <VirtualHost *:80>
#   DocumentRoot "/var/www/vhosts/"
#   <Directory "/Users/chris/Sites/drupal">
#     Options +FollowSymLinks
#     AllowOverride All
#     Order allow,deny
#     Allow from all
#     # 
#     # <IfModule mod_rewrite.c>
#     #   RewriteEngine on
#     #   RewriteCond %{REQUEST_FILENAME} !-f
#     #   RewriteCond %{REQUEST_FILENAME} !-d
#     #   RewriteCond %{REQUEST_URI} !=/favicon.ico
#     #   RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]
#     # </IfModule>
# 
#   </Directory>
# </VirtualHost>