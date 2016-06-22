#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}


MY_HOSTNAME=$(hostname)
SERV_IDENTITY=$(get_id openstack service create --name keystone --description 'OpenStack Keystone' identity)
echo $SERV_IDENTITY
openstack service list
openstack endpoint create --region Orange $SERV_IDENTITY --publicurl http://$MY_HOSTNAME:5000/v2.0 --internalurl http://$MY_HOSTNAME:5000/v2.0 --adminurl http://$MY_HOSTNAME:35357/v2.0
openstack endpoint list
