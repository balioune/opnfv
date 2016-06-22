#!/bin/bash
# Be sure to have loaded every keystone credential nd get_id function before running this script

echo -e "\n Project list:"
openstack project list

echo -e "\n Users list:"
openstack user list

echo -e "\n Roles list:" 
openstack role list

echo -e "\n Service list:"
openstack service list

echo -e "\n Endpoint list:"
openstack endpoint list --long
