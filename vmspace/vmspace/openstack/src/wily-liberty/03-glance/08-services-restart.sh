#!/bin/bash

service_list="api registry"
service_prefix=glance

for i in $service_list;
do
	sudo systemctl restart $service_prefix-$i.service;
done

sleep 5
