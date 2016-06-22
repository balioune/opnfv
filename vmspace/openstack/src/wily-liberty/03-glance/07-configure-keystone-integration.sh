#!/bin/bash

function get_id () {
        echo `"$@" | awk '/ id / { print $4 }'`
}

openstack user create --password "password" glance
openstack role add --project service --user glance admin

GLANCE_ID=$(get_id openstack service create --name glance --description 'OpenStack Image Service'  image)
openstack endpoint create --region Orange --publicurl 'http://ops-mono-node:9292' --adminurl 'http://ops-mono-node:9292' --internalurl 'http://ops-mono-node:9292' $GLANCE_ID
