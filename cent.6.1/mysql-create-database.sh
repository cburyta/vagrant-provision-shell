#!/usr/bin/env bash

# variables
DBNAME='db_devel'

# jump into the drupal root
cd /var/www/html

# look to see if the database is installed yet
RESULT="mysqlshow --user=root $DBNAME | grep -v Wildcard | grep -o $DBNAME"

if [ "$RESULT" == "$DBNAME" ]
  # if it's already installed, just indicate such
  then
    echo 'Database already installed.'

  # if it's not installed, install it using the daptive_dma profile
  else
    echo "Database $DBNAME not yet installed... installing using mysql"

    # create database
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DBNAME;"

    # not using drush anymore for this
    echo "Database $DBNAME should be installed, drop then run this script again to reinstall."
fi