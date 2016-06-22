#!/bin/bash


ping -c 4  $(neutron floatingip-list |  egrep '[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}'  | awk '{print $6}')
