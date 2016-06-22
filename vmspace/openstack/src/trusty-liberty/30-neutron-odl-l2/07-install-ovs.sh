#!/bin/bash

odl_ip=127.0.0.1

sudo apt-get install -y openvswitch-switch
sudo ovs-vsctl add-br br-ex
sudo ovs-vsctl set-manager tcp:$odl_ip:8140

