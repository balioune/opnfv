#!/bin/bash

HOSTNAME=$(hostname)

openstack user create --password "password" swift
openstack role add --project service --user swift admin

openstack service create --name swift --description 'Openstack Object Storage'  object-store
openstack endpoint create --region Orange --publicurl http://$HOSTNAME:8080/v1/AUTH_%\(tenant_id\)s --adminurl http://$HOSTNAME:8080/v1/AUTH_%\(tenant_id\)s --internalurl http://$HOSTNAME:8080/v1/AUTH_%\(tenant_id\)s object-store
