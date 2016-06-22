#!/usr/bin/env bash

echo -e "\033[31mConfiguration\033[m"

cd ./01-Prerequisite/00-configuration/
./01-set-proxy.sh
./02-apt-update.sh

echo -e "\033[31mMySQL\033[m"

cd -
cd ./01-Prerequisite/02-MySQL/
./01-apt.sh
./02-configure-config-file.sh

echo -e "\033[31mRabbitMQ\033[m"

cd -
cd ./01-Prerequisite/03-RabbitMQ
./01-apt.sh
./02-configure-guest.sh

echo -e "\033[31mApache\033[m"

cd -
cd ./01-Prerequisite/04-Apache2
./01-apt.sh

echo -e "\033[31mHostname\033[m"

cd -
cd ./01-Prerequisite/05-hostname
./modify-hostname.sh
./modify-hosts.sh

echo -e "\033[31mKeystone\033[m"

cd -
cd ./02-keystone
./01-apt.sh
sudo patch < ./02-keystone.conf.patch
mysql -uroot -ppassword < ./03-db-creation.sql
. ./97-needed-credentials.source.sh
./04-schema-creation.sh
./05-keystone-service-restart.sh
./06-keystone-tenant-list.sh
./07-tenant-creation.sh
./08-user-and-role-configuration.sh
./09-service-creation.sh
. ./98-unload-keystone-token.source.sh

echo -e "\033[31mGlance\033[m"

cd -
cd ./03-glance
./01-apt.sh
sudo patch < ./02-glance-api.conf.patch
sudo patch < ./03-glance-registry.conf.patch
mysql -uroot -ppassword < ./04-db-creation.sql
./05-db-schema-generation.sh
. ./06-switch-environement.source.sh
./07-configure-keystone-integration.sh
./08-services-restart.sh
./09-tests.sh

echo -e "\033[31mNova\033[m"

cd -
cd ./04-nova
./01-apt.sh
sudo patch < ./02-nova.conf.patch
mysql -uroot -ppassword < ./03-db-creation.sql
./04-db-schema-creation.sh
. ./98-needed-credentials.source.sh
./05-keystone-integration.sh
./06-services-restart.sh
./07-test.sh

echo -e "\033[31mNeutron\033[m"

cd -
cd ./05-neutron
./01-apt.sh
./02-neutron-conf-patchmaker.sh
echo File to patch: /etc/neutron/neutron.conf
sudo patch < ./03-neutron.conf.patch
sudo patch < ./04-ml2_conf.ini.patch
./05-sysctl-modification.sh
sudo patch < ./06-interfaces.patch
./07-interfaces-d-configuration.sh
./08-openvswitch-config.sh
./09-interface-nonpermanent-configuration.sh
sudo patch < ./10-l3agent.ini.patch
sudo patch < ./11-dhcp_agent.ini.patch
./12-dnsmasq-configuration.sh
sudo patch < ./13-metadata_agent.ini.patch
. ./98-needed-credentials.source.sh
./14-keystone-integration.sh
sudo patch < ./15-nova.conf.path
mysql -uroot -ppassword < ./16-db-creation.sql
./17-restart-neutron-and-nova.sh
./18-neutron-infra-creation.sh

echo -e "\033[31mFirst-VM-Instanciation\033[m"

cd -
cd ./06-First-VM-Instanciation
./01-ssh-and-icmp-enable.sh
sudo patch < ./02-nova-compute.conf.patch
./03-nova-service-restart.sh
. ./98-needed-credentials.source.sh
./04-instanciation-test.sh
./05-test-ping-and-ssh.sh

echo -e "\033[31mHorizon\033[m"

cd -
cd ./07-horizon
./01-apt.sh
sudo patch < ./02-nova.conf.patch
./03-nova-restart.sh

echo -e "\033[31mCinder\033[m"

cd -
cd ./08-cinder
./01-apt.sh
sudo patch < ./02-cinder.conf.patch
mysql -uroot -ppassword < ./03-db-creation.sql
. ./98-needed-credentials.source.sh
./04-trigger-db-schema-creation.sh
./05-keystone-integration.sh
./06-cinder-restart.sh
./07-configurate-volume.sh
./08-cinder-volume-restart.sh
./09-test-volume-list-and-create.sh
./10-attach-a-new-volume-to-inst1.sh

echo -e "\033[31mSwift\033[m"

cd -
cd ./09-swift
./01-apt.sh
. ./98-needed-credentials.source.sh
./02-keystone-integration.sh
./03-make-fake-block-devices-and-commit-fstab.sh
./04-apt.sh
./05-build-ring.sh
./06-configure-config-file.sh
./07-swift-restart.sh
sudo patch < ./08-glance-api.conf.patch
./09-glance-restart.sh
./10-swift-glance-test.sh
