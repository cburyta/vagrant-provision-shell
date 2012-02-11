#!/usr/bin/env bash

# variables
DBNAME=db_devel

# jump into the drupal root
cd /var/www/html

# look to see if the database is installed yet
RESULT=`mysqlshow --user=root $DBNAME | grep -v Wildcard | grep -o $DBNAME`

if [ "$RESULT" == "$DBNAME" ]
  # if it's already installed, just indicate such
  then
    echo 'Database already installed.'

  # if it's not installed, install it using the daptive_dma profile
  else
    echo 'Database $DBNAME not yet installed... installing using mysql'

    mysql -u root -e 'CREATE DATABASE IF NOT EXISTS $DBNAME;'
    # mysql $DBNAME -u root < /vagrant/data/db/backup_migrate/backup.mysql

    # not using drush anymore for this
    # drush site-install daptive_dma --root=/var/www/html --uri=http://33.33.33.11 --sites-subdir=33.33.33.11 --db-url=mysql://root@localhost/daptive_dma_devel --db-su=root --yes
    echo 'Database $DBNAME should be installed, drop then run this script again to reinstall.'
fi