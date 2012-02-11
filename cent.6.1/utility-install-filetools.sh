#!/usr/bin/env bash

echo "Installing File Tools (wget, unzip, zip...)"

# if a file does not exist...
if [ ! -f /usr/bin/wget ];
then
    echo "Installing wget"
    yum -y install wget
fi

if [ ! -f /usr/bin/unzip ];
then
    echo "Installing unzip"
    yum -y install unzip
fi

if [ ! -f /usr/bin/zip ];
then
    echo "Installing zip"
    yum -y install zip
fi

yum clean all