#!/usr/bin/env bash

# variables
dbName='db_devel'

# jump into the drupal root
cd /var/www/html

# look to see if the database is installed yet
result=`mysqlshow --user=root $dbName | grep -v Wildcard | grep -o $dbName`

if [ "$result" == $dbName ]
  # if it's already installed, just indicate such
  then
    echo 'Database already installed.'

  # if it's not installed, install it using the daptive_dma profile
  else
    echo "$result - $dbName"
    echo "Database $dbName not yet installed... installing using mysql"

    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $dbName;"
    # mysql $dbName -u root < /vagrant/data/db/backup_migrate/backup.mysql

    # not using drush anymore for this
    echo "Database $dbName should be installed, drop then run this script again to reinstall."
fi