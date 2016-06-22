#!/bin/bash

service_list="api cert consoleauth scheduler conductor compute novncproxy"
service_prefix=nova

for i in $service_list;
do
	echo \* restarting $service_prefix-$i ;
	sudo service $service_prefix-$i restart;
done
sleep 5
for i in $service_list;
do
	sudo service $service_prefix-$i status;
done
