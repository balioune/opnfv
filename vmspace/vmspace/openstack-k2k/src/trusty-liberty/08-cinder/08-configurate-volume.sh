#!/bin/bash

sudo pvcreate /dev/sdb
sudo vgcreate cinder-volumes /dev/sdb
