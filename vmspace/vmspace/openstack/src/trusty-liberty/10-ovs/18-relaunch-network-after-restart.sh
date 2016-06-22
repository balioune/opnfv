#!/bin/bash


public_interface=eth3

source ./98-needed-credentials.source.sh
sudo ifconfig $public_interface 0
sudo ovs-vsctl add-port br-ex $public_interface
sudo dhclient br-ex