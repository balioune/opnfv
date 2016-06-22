#!/usr/bin/env bash

cd /home/vagrant/
wget http://www-eu.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
tar -xzf apache-maven-3.3.3-bin.tar.gz
sudo mv apache-maven-3.3.3 /opt/
sudo ln -s /opt/apache-maven-3.3.3/bin/mvn /usr/local/bin/mvn
cd /vagrant/