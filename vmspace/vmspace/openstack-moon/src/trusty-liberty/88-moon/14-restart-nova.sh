#!/usr/bin/env bash

for service in nova-compute nova-api nova-cert nova-conductor nova-consoleauth nova-scheduler ; do
    sudo service ${service} restart
done
