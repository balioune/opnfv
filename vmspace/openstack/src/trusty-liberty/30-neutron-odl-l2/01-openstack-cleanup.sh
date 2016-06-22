#!/bin/bash

for _vm in `nova list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    nova delete $_vm
done


for _port in `neutron port-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    neutron port-delete $_port
done


for _subnet in `neutron subnet-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    neutron subnet-delete $_subnet
done


for _net in `neutron net-list | egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'| awk '{print $2}'`
do
    neutron net-delete $_net
done

