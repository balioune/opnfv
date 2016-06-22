#!/bin/bash

sudo swift-init all restart
sudo service memcached restart
sudo service swift-proxy restart
sudo service apache2 restart
