#!/bin/bash

tenant_net_name=tenantnettest
router_name=routertest
public_interface=eth2
# admin_tenant_id=$(openstack project list | grep 'admin' | awk '{print $2}')
public_net=publicnettest
public_subnet=publicsubnettest


neutron router-create $router_name
sleep 3
tenant_subnet_id=$(neutron net-list | grep $tenant_net_name | head -1|awk ' {print $6} ')
neutron router-interface-add  $router_name $tenant_subnet_id
sudo ifconfig $public_interface 0
sudo ovs-vsctl add-port br-ex $public_interface
sudo dhclient br-ex
sleep 5
neutron net-create $public_net --router:external --provider:physical_network public --provider:network_type flat
neutron subnet-create $public_net 192.168.105.0/24 --name $public_subnet  --disable-dhcp
neutron router-gateway-set  $router_name $public_net

neutron floatingip-create $public_net
floating_ip_id=$(neutron floatingip-list |  egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'  | awk '{print $2}')
port_id=$(neutron port-list |grep "88.88.88.3" |awk '{print $2}')
neutron floatingip-associate $floating_ip_id $port_id
