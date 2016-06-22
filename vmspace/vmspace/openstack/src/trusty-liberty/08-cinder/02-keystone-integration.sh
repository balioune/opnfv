#!/bin/bash

HOSTNAME=$(hostname)

openstack user create --password "password" cinder
openstack role add --project service --user cinder admin

openstack service create --name cinderv1 --description 'OpenStack Volume Service'  volume
openstack endpoint create --region Orange --publicurl http://$HOSTNAME:8776/v1/%\(tenant_id\)s --adminurl http://$HOSTNAME:8776/v1/%\(tenant_id\)s --internalurl http://$HOSTNAME:8776/v1/%\(tenant_id\)s cinderv1

openstack service create --name cinderv2 --description 'OpenStack Volume Service'  volumev2
openstack endpoint create --region Orange --publicurl http://$HOSTNAME:8776/v2/%\(tenant_id\)s --adminurl http://$HOSTNAME:8776/v2/%\(tenant_id\)s --internalurl http://$HOSTNAME:8776/v2/%\(tenant_id\)s volumev2
