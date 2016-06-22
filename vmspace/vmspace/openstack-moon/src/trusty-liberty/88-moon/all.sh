#!/usr/bin/env bash

./01-delete-keystone.sh
./02-apt.sh
./03-install-moon.sh
./04-install-moonclient.sh
. ./97-needed-credentials.source.sh
06-moon-test.sh
