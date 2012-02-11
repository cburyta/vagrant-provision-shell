#!/bin/bash

# depends on lamp.sh (php-pear)

# if a file does not exist...
if [ ! -f /usr/bin/drush ];
then

	# drush dependencies
	pear install --soft Console_Table
	pear install --soft Console_Getopt

	# install drush
	pear channel-discover pear.drush.org
	pear install drush/drush
	drush

fi