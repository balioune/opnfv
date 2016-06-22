#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}

keystone user-create --name=cinder --pass="password"
keystone user-role-add --user cinder --role admin --tenant service
GLANCE_SERVICE_ID=$(get_id keystone service-create --name cinder --type volume --description 'OpenStack Volume Service')
keystone endpoint-create --region Orange --service-id $GLANCE_SERVICE_ID  --publicurl 'http://ops-mono-node:8776/v1/%(tenant_id)s' --adminurl 'http://ops-mono-node:8776/v1/%(tenant_id)s' --internalurl 'http://ops-mono-node:8776/v1/%(tenant_id)s'
