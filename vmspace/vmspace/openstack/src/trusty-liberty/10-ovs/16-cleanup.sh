#!/bin/bash


for _vm in `nova list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    nova delete $_vm
done


for _port in `neutron port-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    neutron port-delete $_port
done


for _router in `neutron router-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    for _subnet in `neutron subnet-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
    do
        neutron router-interface-delete $_router $_subnet
    done
    neutron router-gateway-clear $_router ext-net
    neutron router-delete $_router
done


for _subnet in `neutron subnet-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    neutron subnet-delete $_subnet
done


for _net in `neutron net-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    neutron net-delete $_net
done


sudo ovs-vsctl del-br br-int
sudo ovs-vsctl del-br br-ex
sudo ovs-vsctl del-br br-tun