#!/bin/bash

FSTAB=/etc/fstab

echo \* Creating block images in /srv/block
mkdir /srv/block
cd /srv/block
for i in 6 7 8; do
     echo Creating image d$i ...
     dd if=/dev/zero of=./d$i bs=1MB count=2048;
     mkdir -p /srv/node/d$i;
     echo d$i Formating in xfs ...
     mkfs.xfs -f -L d$i ./d$i;
     echo d$i  Mounting ...
     mount -t xfs ./d$i /srv/node/d$i; done
echo \* Rectifying file rights ... 
chown -R swift:swift /srv/node
cd - > /dev/null
echo  Done !

echo \* Backuping $FSTAB
cp $FSTAB $FSTAB.old
echo \* Writing $FSTAB ...
echo /srv/block/d6          /srv/node/d6 xfs defaults       0 0 >> $FSTAB
echo /srv/block/d7          /srv/node/d7 xfs defaults       0 0 >> $FSTAB
echo /srv/block/d8          /srv/node/d8 xfs defaults       0 0 >> $FSTAB
echo \* All Done !
