#!/usr/bin/env bash


echo Patching Nova

sudo cp /etc/nova/api-paste.ini /etc/nova/api-paste.ini.bak2
sudo sed "/^keystone = / s/keystonecontext/keystonecontext moon/" /etc/nova/api-paste.ini > /tmp/api-paste.ini
sudo cp /tmp/api-paste.ini /etc/nova/api-paste.ini

echo -e "\n[filter:moon]\npaste.filter_factory = keystonemiddleware.moon_agent:filter_factory\nauthz_login=admin\nauthz_password=password\nlogfile=/var/log/moon/keystonemiddleware.log\n" | sudo tee -a /etc/nova/api-paste.ini

