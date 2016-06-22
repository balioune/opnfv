#!/bin/bash

odl_ip=192.168.33.20

sudo apt-get install -y openvswitch-switch
sudo ovs-vsctl add-br br-ex
#sudo ovs-vsctl set-manager tcp:$odl_ip:8140
sudo ovs-vsctl set-manager tcp:$odl_ip:6640

