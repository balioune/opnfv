#!/bin/bash

BR_EX_FILE=/etc/network/interfaces.d/br-ex.cfg
ETH1_FILE=/etc/network/interfaces.d/eth1.cfg

# Configure br-ex interfaces config file:
rm -f $BR_EX_FILE 2> /dev/null
echo auto br-ex | sudo tee $BR_EX_FILE
echo iface br-ex inet static | sudo tee -a $BR_EX_FILE
echo -e "\t address 192.168.33.30" | sudo tee -a $BR_EX_FILE
echo -e "\t netmask 255.255.255.0" | sudo tee -a $BR_EX_FILE

# We act likewise for ETH1_FILE
rm -f $ETH1_FILE 2> /dev/null
echo auto eth1 | sudo tee $ETH1_FILE
echo iface eth1 inet static | sudo tee -a $ETH1_FILE
echo -e "\t address 0.0.0.0" | sudo tee -a $ETH1_FILE
