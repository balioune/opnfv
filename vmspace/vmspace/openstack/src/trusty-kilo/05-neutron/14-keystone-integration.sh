#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}

keystone user-create --name=neutron --pass="password"
keystone user-role-add --user neutron --role admin --tenant service
NEUTRON_ID=$(get_id keystone service-create --name neutron --type network --description "OpenStack Networking Service")
keystone endpoint-create --region Orange --service-id $NEUTRON_ID --publicurl 'http://ops-mono-node:9696/' --adminurl 'http://ops-mono-node:9696/' --internalurl 'http://ops-mono-node:9696/'
