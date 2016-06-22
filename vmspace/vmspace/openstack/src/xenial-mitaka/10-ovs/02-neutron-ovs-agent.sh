#!/bin/bash

# sudo service neutron-linuxbridge-agent stop
sudo apt-get -y remove neutron-linuxbridge-agent
sudo apt-get update
sudo apt-get -y install neutron-plugin-openvswitch-agent
sudo ovs-vsctl show