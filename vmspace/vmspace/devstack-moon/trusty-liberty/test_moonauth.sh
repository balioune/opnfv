#!/usr/bin/env bash

curl -i \
  -H "Content-Type: application/json" \
  -d '
{
  "username": "admin",
  "password": "nomoresecrete",
  "project": "sdn"
}' \
  http://localhost:5000/moon/auth/tokens; echo

#openstack project create sdn --description "Mapping between ODL domain and OS project"
#openstack role add --project sdn --user admin admin
#role add --project sdn --user demo _member_