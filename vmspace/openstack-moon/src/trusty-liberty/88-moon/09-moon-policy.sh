#!/usr/bin/env bash

echo Copying policies to etc
tar tvfz /vagrant/99-Utils/keystone-8.1.0.tar.gz | grep policies | grep json | awk '/policies/ {print $6}' > /tmp/FILES
cd /tmp
tar xvfz /vagrant/99-Utils/keystone-8.1.0.tar.gz -T /tmp/FILES
sudo mv keystone-8.1.0/etc/policies /etc/keystone
sudo chown -R keystone:keystone /etc/keystone/policies
