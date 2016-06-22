#!/bin/bash

service_list="api scheduler conductor compute"
service_prefix=nova

for i in $service_list;
do
	sudo service $service_prefix-$i restart;
done
