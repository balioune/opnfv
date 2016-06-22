#!/bin/bash

function get_id() {
        echo `"$@" | awk '/ id / { print $4 }'`
	}

openstack user create --password="password" nova
openstack role add --user nova  --project service admin
NOVA_ID=$(get_id openstack service create --name nova  --description 'OpenStack Compute Service' compute)
openstack endpoint create --region Orange --publicurl 'http://ops-mono-node:8774/v2/%(tenant_id)s' --adminurl 'http://ops-mono-node:8774/v2/%(tenant_id)s' --internalurl 'http://ops-mono-node:8774/v2/%(tenant_id)s' $NOVA_ID
