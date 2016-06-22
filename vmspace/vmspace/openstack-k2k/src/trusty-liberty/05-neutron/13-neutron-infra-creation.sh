#!/bin/bash

echo \* Getting Admin tenant id:
ADMIN_ID=$(openstack project list | awk '/ admin / { print $2}')
echo ADMIN_ID=$ADMIN_ID

echo \* Configuring network ...
neutron net-create public --shared --provider:network-type flat --provider:physical_network public

echo \* Configuring subnetwork ...
neutron subnet-create public 192.168.33.0/24 --name public --allocation-pool start=192.168.33.100,end=192.168.33.200
