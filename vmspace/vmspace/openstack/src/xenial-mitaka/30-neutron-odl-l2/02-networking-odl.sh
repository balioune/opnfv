#!/bin/bash

sudo apt-get install -y git
cd ~/
git clone https://github.com/openstack/networking-odl
cd networking-odl
git checkout stable/mitaka
sudo python setup.py install
cd /vagrant/
