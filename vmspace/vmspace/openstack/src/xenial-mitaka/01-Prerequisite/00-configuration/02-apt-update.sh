#!/usr/bin/env bash

sudo sed -i.bak "s/us/fr/" /etc/apt/sources.list

sudo apt-get update

