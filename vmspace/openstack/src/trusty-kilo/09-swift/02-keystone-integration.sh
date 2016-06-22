#!/bin/bash

keystone user-create --name=swift --pass="password"
keystone user-role-add --user swift --role admin --tenant service

SERV_ID=$(keystone service-create  --type object-store --name swift --description "Swift storage service" | awk ' / id / { print $4 }' )
keystone endpoint-create --region Orange --service-id $SERV_ID --publicurl 'http://ops-mono-node:8080/v1/AUTH_$(tenant_id)s' --adminurl 'http://ops-mono-node:8080/v1/AUTH_$(tenant_id)s' --internalurl 'http://ops-mono-node:8080/v1/AUTH_$(tenant_id)s'
