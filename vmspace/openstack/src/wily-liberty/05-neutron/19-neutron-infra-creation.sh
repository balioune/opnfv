#!/bin/bash

echo \* Getting Admin tenant id:
ADMIN_ID=$(openstack project list | awk '/ admin / { print $2}')
echo ADMIN_ID=$ADMIN_ID

echo \* Configuring network ...
neutron net-create ext-net --provider:network-type flat --provider:physical_network physnet1 --router:external=True --tenant-id $ADMIN_ID

echo \* Configuring subnetwork ...
neutron subnet-create ext-net --name ext-subnet --allocation-pool start=192.168.33.100,end=192.168.33.200 --disable-dhcp 192.168.33.0/24 --tenant-id $ADMIN_ID

echo \* Creating demo-net1
neutron net-create demo-net1

echo \* Creating demo-subnet1
neutron subnet-create --ip-version 4 --name demo-subnet1 demo-net1 10.5.5.0/24

echo \* Configuration of a router
neutron router-create router1

echo \* Connecting it to demo-subnet1 
neutron router-interface-add router1 demo-subnet1

echo \* Connecting it to ext-net:
neutron router-gateway-set router1 ext-net
