#!/bin/bash

sudo tee << EOF /etc/swift/swift.conf
[swift-hash]
swift_hash_path_prefix = password
swift_hash_path_suffix = password
EOF

sudo tee << EOF /etc/swift/proxy-server.conf
[DEFAULT]
bind = 8080
user= swift

[pipeline:main]
pipeline = healthcheck proxy-logging cache authtoken keystoneauth proxy-server

[app:proxy-server]
use = egg:swift#proxy
allow_account_management = true
account_autocreate = true

[filter:keystoneauth]
use = egg:swift#keystoneauth
operator_roles = admin,swiftoperator

[filter:authtoken]
paste.filter_factory = keystoneclient.middleware.auth_token:filter_factory
signing_dir = /etc/swift/keystone-signing

auth_protocol = http
auth_host = ops-mono-node
auth_port = 35357

service_port = 5000
service_host = ops-mono-node
service_protocol = http
admin_tenant_name = service
admin_user = swift
admin_password = password

[filter:cache]
use = egg:swift#memcache
memcache_servers = 127.0.0.1:11211

[filter:catch_errors]
use = egg:swift#catch_errors

[filter:healthcheck]
use = egg:swift#healthcheck

[filter:proxy-logging]
use = egg:swift#proxy_logging
EOF

sudo chown -R swift:swift /etc/swift
