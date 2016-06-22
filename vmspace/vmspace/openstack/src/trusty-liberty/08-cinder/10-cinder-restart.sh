#!/bin/bash

for i in api scheduler volume; do sudo service cinder-$i restart; done
