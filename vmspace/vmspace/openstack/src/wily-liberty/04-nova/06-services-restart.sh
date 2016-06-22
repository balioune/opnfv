#!/bin/bash

service_list="api scheduler conductor compute"
service_prefix=nova

for i in $service_list;
do
	echo \* restarting $service_prefix-$i ;
	sudo systemctl restart $service_prefix-$i ;
done
sleep 5
for i in $service_list;
do
	sudo systemctl status $service_prefix-$i ;
done
