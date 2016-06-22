#!/usr/bin/env bash

cd /home/vagrant/
git clone https://github.com/opendaylight/controller.git
cd controller/
git checkout stable/beryllium
mvn clean install -DskipTest
cd /vagrant/

