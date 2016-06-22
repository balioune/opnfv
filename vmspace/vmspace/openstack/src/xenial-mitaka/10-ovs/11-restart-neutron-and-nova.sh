#!/bin/bash
for i in api compute;
do
	echo \* restarting nova-$i;
	sudo service nova-$i restart;
done;

for i in server openvswitch-agent dhcp-agent metadata-agent l3-agent;
do
	echo \* restarting neutron-$i;
	sudo service neutron-$i restart;
done;

sleep 5;

for i in api compute;
do
	sudo service nova-$i status;
done;

for i in server openvswitch-agent dhcp-agent metadata-agent l3-agent;
do
	sudo service neutron-$i status;
done;
