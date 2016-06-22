#!/bin/bash

source 98-needed-credentials.source.sh
/bin/sh 01-openstack-cleanup.sh
/bin/sh 02-neutron-ovs-agent.sh
sudo patch < 03-neutron.conf.patch -p0  /etc/neutron/neutron.conf
echo "Configuring ML2 plugin"
sudo patch < 04-ml2-conf.ini.patch -p0  /etc/neutron/plugins/ml2/ml2_conf.ini
echo "Configuring OVS agent"
sudo patch < 04-ovs_agent.ini.patch -p0 /etc/neutron/plugins/ml2/openvswitch_agent.ini
echo "Configuring DHCP agent"
sudo patch < 05-dhcp-agent.ini.patch -p0 /etc/neutron/dhcp_agent.ini 
echo "Configuring metadata agent"
sudo patch < 06-metadata-agent.ini.patch -p0 /etc/neutron/metadata_agent.ini

/bin/sh 07-add-br.sh
/bin/sh 08-neutron-l3-agent.sh
echo "Configuring l3 agent"
sudo patch < 09-l3_agent.ini.patch -p0 /etc/neutron/l3_agent.ini

/bin/sh 11-restart-neutron-and-nova.sh
