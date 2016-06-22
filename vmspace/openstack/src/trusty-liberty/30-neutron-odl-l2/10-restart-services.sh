#!/bin/bash

sudo service neutron-server restart
sudo service neutron-l3-agent restart
sudo service neutron-dhcp-agent restart
sudo service nova-api restart

