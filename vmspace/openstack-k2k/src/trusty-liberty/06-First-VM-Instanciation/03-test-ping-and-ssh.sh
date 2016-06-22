#!/bin/bash

echo \* Getting an public IP for Inst1 ...
IP=$(nova show inst1 | grep public | awk '{print $5}')
echo Got $IP
echo \* Let\'s ping 4 times ...
ping -c 4 $IP
echo \* Attempting SSH \(Password is \'cubswin:\)\'\)
ssh cirros@$IP 
echo Done
