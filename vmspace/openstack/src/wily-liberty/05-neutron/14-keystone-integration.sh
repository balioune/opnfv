#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}

openstack user create  --password "password" neutron
openstack role add --project service --user neutron admin
NEUTRON_ID=$(get_id openstack service create --name neutron --description "OpenStack Networking Service" network)
openstack endpoint create --region Orange --publicurl 'http://ops-mono-node:9696/' --adminurl 'http://ops-mono-node:9696/' --internalurl 'http://ops-mono-node:9696/' $NEUTRON_ID
