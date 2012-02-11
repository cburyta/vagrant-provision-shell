#!/bin/bash

# when a box is packaged, some stuff happens that affects the network
# ports on centos and other systems that use 'udev' the following
# needs to be done to the virtual box to refresh the network interfaces
# http://www.cyberciti.biz/tips/vmware-linux-lost-eth0-after-cloning-image.html

# clear the rules that need to be recreated when the mac address may change
sudo rm /etc/udev/rules.d/70-persistent-net.rules