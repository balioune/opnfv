#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}

keystone user-create --name=nova --pass="password"
keystone user-role-add --user nova --role admin --tenant service
NOVA_ID=$(get_id keystone service-create --name nova --type compute --description 'OpenStack Compute Service')
keystone endpoint-create --region Orange --service-id $NOVA_ID --publicurl 'http://ops-mono-node:8774/v2/%(tenant_id)s' --adminurl 'http://ops-mono-node:8774/v2/%(tenant_id)s' --internalurl 'http://ops-mono-node:8774/v2/%(tenant_id)s'
