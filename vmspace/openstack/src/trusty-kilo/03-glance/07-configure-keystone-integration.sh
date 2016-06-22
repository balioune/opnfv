#!/bin/bash

function get_id () {
        echo `"$@" | awk '/ id / { print $4 }'`
}

keystone user-create --name=glance --pass="password"
keystone user-role-add --user glance --role admin --tenant service

GLANCE_ID=$(get_id keystone service-create --name glance --type image --description 'OpenStack Image Service')
keystone endpoint-create --region Orange --service-id $GLANCE_ID --publicurl 'http://ops-mono-node:9292' --adminurl 'http://ops-mono-node:9292' --internalurl 'http://ops-mono-node:9292'
