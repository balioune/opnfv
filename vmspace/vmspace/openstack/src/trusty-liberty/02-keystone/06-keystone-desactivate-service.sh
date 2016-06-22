#!/bin/bash

sudo service keystone stop
echo "manual" | sudo tee /etc/init/keystone.override
