#!/bin/bash

glance image-create --store swift --disk-format qcow2 --container-format bare --is-public True --name "CirrOS-Swift" < /vagrant/99-Utils/cirros-0.3.3-x86_64-disk.img
