#!/bin/bash
openstack user create --password "password" admin
openstack user create --password "password" demo
openstack user create --password "password" keystone

openstack role create admin
openstack role add --project admin --user admin admin
openstack role add --project service --user keystone admin

openstack role create user
openstack role add --project demo --user demo user
