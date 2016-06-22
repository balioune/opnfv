#!/bin/bash

echo ==========================
echo I\'ll generate for you a custom patch you\'ll have to apply on /etc/neutron/neutron.conf .
echo Nb: This patch will be ignored by Git.
echo ==========================
echo

echo \* Removing former patch ...
rm 03-neutron.conf.patch

echo \* Getting service tenant id ...
SERV_TENANT_ID=$(openstack project list | awk '/ service / {print $2}')

echo   Got $SERV_TENANT_ID !
echo \* I generate the '03-neutron.conf.patch' patch ...

cat << EOF > 03-neutron.conf.patch
--- /etc/neutron/neutron.conf.old	2016-02-22 19:36:41.000000000 +0000
+++ /etc/neutron/neutron.conf	2016-03-23 15:48:47.769145407 +0000
@@ -1,6 +1,6 @@
 [DEFAULT]
 # Print more verbose output (set logging level to INFO instead of default WARNING level).
-# verbose = False
+verbose = True
 
 # =========Start Global Config Option for Distributed L3 Router===============
 # Setting the "router_distributed" flag to "True" will default to the creation
@@ -74,7 +74,7 @@
 # with previous versions, the class name of a plugin can be specified instead
 # of its entrypoint name.
 #
-# service_plugins =
+service_plugins = router
 # Example: service_plugins = router,firewall,lbaas,vpnaas,metering,qos
 
 # Paste configuration file
@@ -89,7 +89,7 @@
 
 # The strategy to be used for auth.
 # Supported values are 'keystone'(default), 'noauth'.
-# auth_strategy = keystone
+auth_strategy = keystone
 
 # Base MAC address. The first 3 octets will remain unchanged. If the
 # 4h octet is not 00, it will also be used. The others will be
@@ -129,7 +129,7 @@
 # Enable or disable overlapping IPs for subnets
 # Attention: the following parameter MUST be set to False if Neutron is
 # being used in conjunction with nova security groups
-# allow_overlapping_ips = False
+allow_overlapping_ips = True
 # Ensure that configured gateway is on subnet. For IPv6, validate only if
 # gateway is not a link local address. Deprecated, to be removed during the
 # K release, at which point the check will be mandatory.
@@ -357,23 +357,23 @@
 
 # ======== neutron nova interactions ==========
 # Send notification to nova when port status is active.
-# notify_nova_on_port_status_changes = True
+notify_nova_on_port_status_changes = True
 
 # Send notifications to nova when port data (fixed_ips/floatingips) change
 # so nova can update it's cache.
 # notify_nova_on_port_data_changes = True
 
 # URL for connection to nova (Only supports one nova region currently).
-# nova_url = http://127.0.0.1:8774/v2
+nova_url = http://ops-mono-node:8774/v2
 
 # Name of nova region to use. Useful if keystone manages more than one region
-# nova_region_name =
+nova_region_name = Orange
 
 # Username for connection to nova in admin context
-# nova_admin_username =
+nova_admin_username = nova
 
 # The uuid of the admin nova tenant
-# nova_admin_tenant_id =
+nova_admin_tenant_id = $SERV_TENANT_ID
 
 # The name of the admin nova tenant. If the uuid of the admin nova tenant
 # is set, this is optional.  Useful for cases where the uuid of the admin
@@ -381,10 +381,10 @@
 # nova_admin_tenant_name =
 
 # Password for connection to nova in admin context.
-# nova_admin_password =
+nova_admin_password = password
 
 # Authorization URL for connection to nova in admin context.
-# nova_admin_auth_url =
+nova_admin_auth_url = http://ops-mono-node:35357/v2.0
 
 # CA file for novaclient to verify server certificates
 # nova_ca_certificates_file =
@@ -469,11 +469,11 @@
 
 # The RabbitMQ broker address where a single node is used.
 # (string value)
-# rabbit_host=localhost
+rabbit_host=ops-mono-node
 
 # The RabbitMQ broker port where a single node is used.
 # (integer value)
-# rabbit_port=5672
+rabbit_port=5672
 
 # RabbitMQ HA cluster host:port pairs. (list value)
 # rabbit_hosts=$rabbit_host:$rabbit_port
@@ -485,7 +485,7 @@
 # rabbit_userid=guest
 
 # The RabbitMQ password. (string value)
-# rabbit_password=guest
+rabbit_password=password
 
 # the RabbitMQ login method (string value)
 # rabbit_login_method=AMQPLAIN
@@ -718,11 +718,12 @@
 # ===========  end of items for agent management extension =====
 
 [keystone_authtoken]
-auth_uri = http://127.0.0.1:35357/v2.0/
+auth_uri = http://127.0.0.1:5000/v2.0/
+auth_url = http://127.0.0.1:35357/v2.0/
 identity_uri = http://127.0.0.1:5000
-admin_tenant_name = %SERVICE_TENANT_NAME%
-admin_user = %SERVICE_USER%
-admin_password = %SERVICE_PASSWORD%
+admin_tenant_name = service
+admin_user = neutron
+admin_password = password
 
 [database]
 # This line MUST be changed to actually run the plugin.
@@ -735,7 +736,7 @@
 # be set in the corresponding core plugin '.ini' file. However, it is suggested
 # to put the [database] section and its connection attribute in this
 # configuration file.
-connection = sqlite:////var/lib/neutron/neutron.sqlite
+connection = mysql://neutron:password@localhost/neutrondb
 
 # Database engine for which script will be generated when using offline
 # migration
EOF

echo   Finished :\) . Happy Patching !

