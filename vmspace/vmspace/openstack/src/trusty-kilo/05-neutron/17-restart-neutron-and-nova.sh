#!/bin/bash
for i in server plugin-openvswitch-agent l3-agent dhcp-agent metadata-agent; do sudo service neutron-$i restart; done;
for i in api scheduler conductor; do sudo service nova-$i restart; done;
