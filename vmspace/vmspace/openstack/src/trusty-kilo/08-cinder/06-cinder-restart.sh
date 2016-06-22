#!/bin/bash

for i in api scheduler; do sudo service cinder-$i restart; done
