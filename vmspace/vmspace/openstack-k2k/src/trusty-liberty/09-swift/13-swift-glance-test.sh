#!/bin/bash

openstack image create --store swift --disk-format qcow2 --container-format bare --public --file /vagrant/99-Utils/cirros-0.3.3-x86_64-disk.img CirrOS-Swift
