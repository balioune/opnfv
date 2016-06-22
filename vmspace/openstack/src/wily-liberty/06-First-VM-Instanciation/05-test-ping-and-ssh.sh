#!/bin/bash

echo \* Getting an public IP for Inst1 ...
IP=$(nova floating-ip-create ext-net | grep ext-net | awk '{print $2}')
echo Got $IP
echo \* Associating with inst1 ...
nova floating-ip-associate inst1 $IP
echo \* Let\'s ping 4 times ...
ping -c 4 $IP
echo \* Attempting SSH \(Password is \'cubswin:\)\'\)
ssh cirros@$IP 
echo Done
