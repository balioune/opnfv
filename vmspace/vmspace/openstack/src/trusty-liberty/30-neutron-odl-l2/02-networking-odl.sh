#!/bin/bash

sudo apt-get install -y git
cd ~/
git clone https://github.com/openstack/networking-odl
cd networking-odl
git checkout stable/liberty
sudo python setup.py install
cd /vagrant/
