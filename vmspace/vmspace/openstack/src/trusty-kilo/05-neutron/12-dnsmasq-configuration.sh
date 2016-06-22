#!/bin/bash

echo dhcp-option-force=26,1450 | sudo tee /etc/neutron/dnsmasq.conf
