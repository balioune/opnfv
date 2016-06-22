#!/bin/bash

sudo ovs-vsctl add-br br-ex
sudo ovs-vsctl add-port br-ex eth1
