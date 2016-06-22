#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}


MY_HOSTNAME=$(hostname)
SERV_IDENTITY=$(get_id keystone service-create --name keystone --type identity --description 'OpenStack Keystone')
echo $SERV_IDENTITY
keystone service-list
keystone endpoint-create --region Orange --service-id $SERV_IDENTITY --publicurl http://$MY_HOSTNAME:5000/v2.0 --internalurl http://$MY_HOSTNAME:5000/v2.0 --adminurl http://$MY_HOSTNAME:35357/v2.0
keystone endpoint-list
