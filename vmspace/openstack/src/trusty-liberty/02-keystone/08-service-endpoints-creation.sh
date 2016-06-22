#!/bin/bash

#Getting hostname for the URLs.
MY_HOSTNAME=$(hostname)

# Adding service to keystone
openstack service create --name keystone --description 'OpenStack Keystone' identity

# Addinf endpoint to keystone
openstack endpoint create --region Orange identity --publicurl http://$MY_HOSTNAME:5000/v2.0 --internalurl http://$MY_HOSTNAME:5000/v2.0 --adminurl http://$MY_HOSTNAME:35357/v2.0
