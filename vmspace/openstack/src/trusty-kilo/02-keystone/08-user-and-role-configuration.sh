#!/bin/bash
keystone user-create --name admin --pass "password"
keystone user-create --name demo --pass "password"
keystone user-create --name keystone --pass "password"

keystone role-create --name admin

keystone user-role-add --user admin --role admin --tenant admin
keystone user-role-add --user demo --role admin --tenant demo
keystone user-role-add --user keystone --role admin --tenant service
