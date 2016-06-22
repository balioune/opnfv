#!/usr/bin/env bash

# set up the proxy if necessary
mkdir ~/.m2
cd ~/.m2
wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > settings.xml
cd /vagrant/