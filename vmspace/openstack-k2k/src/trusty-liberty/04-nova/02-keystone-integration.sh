#!/bin/bash

HOSTNAME=$(hostname)

openstack user create --password="password" nova
openstack role add --user nova  --project service admin
openstack service create --name nova  --description 'OpenStack Compute Service' compute
openstack endpoint create --region Orange --publicurl http://$HOSTNAME:8774/v2/%\(tenant_id\)s --adminurl http://$HOSTNAME:8774/v2/%\(tenant_id\)s --internalurl http://$HOSTNAME:8774/v2/%\(tenant_id\)s compute
