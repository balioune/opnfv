Cinder configuration
====================

* ``sudo apt-get -y install cinder-api=1:2014.1.5-0ubuntu1 cinder-scheduler=1:2014.1.5-0ubuntu1 cinder-volume=1:2014.1.5-0ubuntu1``

* ``sudo vim /etc/cinder/cinder.conf``

* ``mysql -u root -p`` ...

* ``sudo cinder-manage db sync``

* ``keystone user-create --name=cinder --pass="password"``

* ``keystone user-role-add --user cinder --role admin --tenant service``

* ``keystone service-create --name cinder --type volume --description 'OpenStack Volume Service'``

* ``keystone endpoint-create --region Orange --service-id $GLANCE_SERVICE_ID  --publicurl 'http://ops-mono-node:8776/v1/%(tenant_id)s' --adminurl 'http://ops-mono-node:8776/v1/%(tenant_id)s' --internalurl 'http://ops-mono-node:8776/v1/%(tenant_id)s'``

* ``for i in api scheduler; do sudo service cinder-$i restart; done``

* ``sudo pvcreate /dev/sdb``

* ``sudo vgcreate cinder-volumes /dev/sdb``

* ``sudo service cinder-volume restart``

* ``cinder list``
 
* ``nova volume-create 2``

* ``nova volume-attach inst1 $DISK_UUID auto``
