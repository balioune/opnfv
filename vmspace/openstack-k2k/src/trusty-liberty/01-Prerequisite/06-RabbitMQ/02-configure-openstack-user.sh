#!/bin/bash
sudo rabbitmqctl add_user openstack password
sudo rabbitmqctl set_permissions openstack ".*" ".*" ".*"
