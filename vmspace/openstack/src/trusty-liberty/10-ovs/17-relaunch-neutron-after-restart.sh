#!/bin/bash


source ./98-needed-credentials.source.sh
./16-cleanup.sh
./07-add-br.sh
./10-nova-ovs-restart.sh
./11-neutron-restart.sh