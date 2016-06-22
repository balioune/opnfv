#!/bin/bash

FSTAB=/etc/fstab

echo \* Creating block images in /srv/block
sudo mkdir /srv/block
cd /srv/block
for i in 6 7 8; do
     echo Creating image d$i ...
     sudo dd if=/dev/zero of=./d$i bs=1MB count=2048;
     sudo mkdir -p /srv/node/d$i;
     echo d$i Formating in xfs ...
     sudo mkfs.xfs -f -L d$i ./d$i;
     echo d$i  Mounting ...
     sudo mount -t xfs ./d$i /srv/node/d$i; done
echo \* Rectifying file rights ... 
sudo chown -R swift:swift /srv/node
cd - > /dev/null
echo  Done !

echo \* Backuping $FSTAB
sudo cp $FSTAB $FSTAB.old
echo \* Writing $FSTAB ...
echo /srv/block/d6          /srv/node/d6 xfs defaults       0 0 | sudo tee -a $FSTAB
echo /srv/block/d7          /srv/node/d7 xfs defaults       0 0 | sudo tee -a $FSTAB
echo /srv/block/d8          /srv/node/d8 xfs defaults       0 0 | sudo tee -a $FSTAB
echo \* All Done !
