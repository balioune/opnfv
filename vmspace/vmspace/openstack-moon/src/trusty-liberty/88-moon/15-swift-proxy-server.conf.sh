#!/usr/bin/env bash

sudo cp /etc/swift/proxy-server.conf /etc/swift/proxy-server.conf.bak2
sudo sed "/^pipeline = / s/proxy-server/moon proxy-server/" /etc/swift/proxy-server.conf > /tmp/proxy-server.conf
sudo cp /tmp/proxy-server.conf /etc/swift/proxy-server.conf

echo -e "\n[filter:moon]\npaste.filter_factory = keystonemiddleware.moon_agent:filter_factory\nauthz_login=admin\nauthz_password=password\nlogfile=/var/log/moon/keystonemiddleware.log\n" | sudo tee -a /etc/swift/proxy-server.conf
