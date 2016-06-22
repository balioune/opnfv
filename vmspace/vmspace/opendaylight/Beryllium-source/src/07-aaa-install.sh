#!/usr/bin/env bash

cd /home/vagrant/
git clone https://github.com/opendaylight/aaa.git
cd aaa/
git checkout stable/beryllium
mvn clean install -DskipTests
cd /vagrant/

