#!/bin/bash

echo \* Creating  /etc/sysctl.d/20-neutron.conf
cat << EOF > /etc/sysctl.d/20-neutron.conf
net.ipv4.ip_forward=1
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
EOF

echo \* Applying live modification in sysctl configuration ...
sysctl net.ipv4.ip_forward=1
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.default.rp_filter=0
echo Done !
