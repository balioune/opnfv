#!/usr/bin/env bash

sudo mkdir /var/log/moon/
sudo chown keystone /var/log/moon/

sudo addgroup moonlog

sudo chgrp moonlog /var/log/moon/

sudo touch /var/log/moon//keystonemiddleware.log

sudo chgrp moonlog /var/log/moon/keystonemiddleware.log
sudo chmod g+rw /var/log/moon
sudo chmod g+rw /var/log/moon/keystonemiddleware.log

sudo adduser keystone moonlog
sudo adduser swift moonlog
sudo adduser nova moonlog

