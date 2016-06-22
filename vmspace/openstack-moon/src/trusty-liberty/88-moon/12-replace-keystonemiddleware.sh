#!/usr/bin/env bash

sudo dpkg --force-all -r python-keystonemiddleware
sudo pip install /vagrant/99-Utils/keystonemiddleware-2.3.3.tar.gz

