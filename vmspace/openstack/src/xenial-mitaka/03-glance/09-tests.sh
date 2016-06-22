#!/bin/bash

# Configuration test:
glance image-list

# Add an image in Glance
glance image-create --name "cirros-0.3.3-x86_64"  --disk-format qcow2 --file /vagrant/99-Utils/cirros-0.3.3-x86_64-disk.img --container-format bare
# --is-public True

# Does the image is stored ?
glance image-list
