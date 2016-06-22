#!/bin/bash

service_list="api registry"
service_prefix=glance

for i in $service_list;
do
	sudo service $service_prefix-$i restart;
done

sleep 5
