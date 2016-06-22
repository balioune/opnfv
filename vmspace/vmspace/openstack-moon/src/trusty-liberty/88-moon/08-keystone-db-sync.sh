#!/usr/bin/env bash

sudo /usr/local/bin/keystone-manage db_sync
sudo /usr/local/bin/keystone-manage db_sync --extension moon