#!/bin/bash

HOSTNAME=$(hostname)

openstack user create  --password "password" neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking Service" network
openstack endpoint create --region Orange --publicurl http://$HOSTNAME:9696/ --adminurl http://$HOSTNAME:9696/ --internalurl http://$HOSTNAME:9696/ network
