#!/bin/bash

HOSTNAME=$(hostname)

openstack user create --password "password" glance
openstack role add --project service --user glance admin

openstack service create --name glance --description 'OpenStack Image Service'  image
openstack endpoint create --region Orange --publicurl http://$HOSTNAME:9292 --adminurl http://$HOSTNAME:9292 --internalurl http://$HOSTNAME:9292 image
