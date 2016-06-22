#!/bin/bash

tenant_net_name=tenantnettest
tenant_subnet_name=tenantsubnettest
vm_name=vmtest

tenant_id=$(openstack project list | grep 'admin' | awk '{print $2}')
sleep 3
neutron net-create $tenant_net_name --tenant-id=$tenant_id
sleep 5
neutron subnet-create --name $tenant_subnet_name --tenant-id=$tenant_id $tenant_net_name 88.88.88.0/24
sleep 5
tenant_net_id=$(neutron net-list | grep $tenant_net_name | awk '{print $2}')

nova boot --image cirros-0.3.3-x86_64 --flavor m1.tiny --nic net-id=$tenant_net_id $vm_name

sleep 5
nova list


