#!/bin/bash

echo ==========================
echo I\'ll generate for you a custom patch you\'ll have to apply on /etc/neutron/neutron.conf .
echo Nb: This patch will be ignored by Git.
echo ==========================
echo

echo \* Removing former patch ...
rm 03-neutron.conf.patch

echo \* Getting service tenant id ...
SERV_TENANT_ID=$(keystone tenant-list | awk '/ service / {print $2}')

echo   Got $SERV_TENANT_ID !
echo \* I generate the '03-neutron.conf.patch' patch ...

cat << EOF > 03-neutron.conf.patch
--- /etc/neutron/neutron.conf.orig	2016-02-25 14:44:27.254359985 +0000
+++ /etc/neutron/neutron.conf	2016-02-25 14:50:42.078375726 +0000
@@ -1,6 +1,6 @@
 [DEFAULT]
 # Print more verbose output (set logging level to INFO instead of default WARNING level).
-# verbose = False
+verbose = True

 # Print debugging output (set logging level to DEBUG instead of default WARNING level).
 # debug = False
@@ -50,7 +50,7 @@
 # previous versions, the class name of a plugin can be specified instead of its
 # entrypoint name.
 #
-core_plugin = neutron.plugins.ml2.plugin.Ml2Plugin
+core_plugin = ml2
 # Example: core_plugin = ml2

 # (ListOpt) List of service plugin entrypoints to be loaded from the
@@ -59,7 +59,7 @@
 # with previous versions, the class name of a plugin can be specified instead
 # of its entrypoint name.
 #
-# service_plugins =
+service_plugins = router
 # Example: service_plugins = router,firewall,lbaas,vpnaas,metering

 # Paste configuration file
@@ -67,7 +67,7 @@

 # The strategy to be used for auth.
 # Supported values are 'keystone'(default), 'noauth'.
-# auth_strategy = keystone
+auth_strategy = keystone

 # Base MAC address. The first 3 octets will remain unchanged. If the
 # 4h octet is not 00, it will also be used. The others will be
@@ -95,7 +95,7 @@
 # Enable or disable overlapping IPs for subnets
 # Attention: the following parameter MUST be set to False if Neutron is
 # being used in conjunction with nova security groups
-# allow_overlapping_ips = False
+allow_overlapping_ips = True
 # Ensure that configured gateway is on subnet
 # force_gateway_on_subnet = False

@@ -131,11 +131,11 @@
 # SSL certification authority file (valid only if SSL enabled)
 # kombu_ssl_ca_certs =
 # IP address of the RabbitMQ installation
-# rabbit_host = localhost
+rabbit_host = ops-mono-node
 # Password of the RabbitMQ server
-# rabbit_password = guest
+rabbit_password = password
 # Port where RabbitMQ server is running/listening
-# rabbit_port = 5672
+#rabbit_port = 5672
 # RabbitMQ single or HA cluster (host:port pairs i.e: host1:5672, host2:5672)
 # rabbit_hosts is defaulted to '\$rabbit_host:\$rabbit_port'
 # rabbit_hosts = localhost:5672
@@ -270,6 +270,12 @@
 # sent to the client.
 # wsgi_keep_alive = True

+# wsgi keepalive option. Determines if connections are allowed to be held open
+# by clients after a request is fulfilled. A value of False will ensure that
+# the socket connection will be explicitly closed once a response has been
+# sent to the client.
+# wsgi_keep_alive = True
+
 # Sets the value of TCP_KEEPIDLE in seconds to use for each server socket when
 # starting API server. Not supported on OS X.
 # tcp_keepidle = 600
@@ -302,29 +308,29 @@

 # ======== neutron nova interactions ==========
 # Send notification to nova when port status is active.
-# notify_nova_on_port_status_changes = True
+notify_nova_on_port_status_changes = True

 # Send notifications to nova when port data (fixed_ips/floatingips) change
 # so nova can update it's cache.
-# notify_nova_on_port_data_changes = True
+notify_nova_on_port_data_changes = True

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

 # Password for connection to nova in admin context.
-# nova_admin_password =
+nova_admin_password = password

 # Authorization URL for connection to nova in admin context.
-# nova_admin_auth_url =
+nova_admin_auth_url = http://ops-mono-node:35357/v2.0

 # Number of seconds between sending events to nova if there are any events to send
 # send_events_interval = 2
@@ -401,9 +407,9 @@
 auth_host = 127.0.0.1
 auth_port = 35357
 auth_protocol = http
-admin_tenant_name = %SERVICE_TENANT_NAME%
-admin_user = %SERVICE_USER%
-admin_password = %SERVICE_PASSWORD%
+admin_tenant_name = service
+admin_user = neutron
+admin_password = password
 signing_dir = \$state_path/keystone-signing

 [database]
@@ -412,7 +418,7 @@
 # connection = mysql://root:pass@127.0.0.1:3306/neutron
 # Replace 127.0.0.1 above with the IP address of the database used by the
 # main neutron server. (Leave it as is if the database runs on this host.)
-connection = sqlite:////var/lib/neutron/neutron.sqlite
+connection = mysql://neutron:password@localhost/neutrondb

 # The SQLAlchemy connection string used to connect to the slave database
 # slave_connection =

EOF

echo   Finished :\) . Happy Patching !

