#!/bin/bash

echo \* Testing volume creation with Nova ...
DISK_UUID=$(nova volume-create 2 | awk '/ id / { print $4 }')
echo Got $DISK_UUID !
echo \* Attach it to inst1 ...
nova volume-attach inst1 $DISK_UUID auto
echo Done
