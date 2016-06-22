#!/bin/bash
for i in server plugin-openvswitch-agent l3-agent dhcp-agent metadata-agent;
do
	echo \* restarting neutron-$i;
	sudo systemctl restart neutron-$i ;
done;

for i in api scheduler conductor;
do
	echo \* restarting nova-$i;
	sudo systemctl restart nova-$i;
done;

sleep 5;

for i in server plugin-openvswitch-agent l3-agent dhcp-agent metadata-agent;
do
	sudo systemctl status neutron-$i;
done;

for i in api scheduler conductor;
do
	sudo systemctl status nova-$i;
done;
