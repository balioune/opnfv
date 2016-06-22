#!/bin/bash

BR_EX_FILE=/etc/network/interfaces.d/br-ex.cfg
ETH1_FILE=/etc/network/interfaces.d/eth1.cfg

# Configure br-ex interfaces config file:
rm $BR_EX_FILE
echo auto br-ex > $BR_EX_FILE
echo iface br-ex inet static >> $BR_EX_FILE
echo       address 192.168.33.30 >> $BR_EX_FILE
echo       netmask 255.255.255.0 >> $BR_EX_FILE

# We act likewise for ETH1_FILE
rm $ETH1_FILE > /dev/null
echo auto eth1 > $ETH1_FILE
echo iface eth1 inet static >> $ETH1_FILE
echo address 0.0.0.0 >> $ETH1_FILE
