#!/bin/bash

sudo apt-get update
sudo apt-get -y install neutron-plugin-openvswitch-agent
sudo ovs-vsctl show