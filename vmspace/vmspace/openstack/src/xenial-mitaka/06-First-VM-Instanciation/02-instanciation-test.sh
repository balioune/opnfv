#!/bin/bash

echo \* Getting public ID ...
NET_ID=$(nova net-list | grep public | awk '{print $2}')
echo Got $NET_ID !
echo \* Creating and booting a sample VM ...
nova boot --flavor m1.tiny --image cirros-0.3.3-x86_64 --security-groups default --nic net-id=$NET_ID --poll inst1
echo \* Waiting 5 sec before check VMs status ...
nova list
