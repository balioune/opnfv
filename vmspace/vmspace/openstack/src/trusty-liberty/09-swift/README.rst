Swift configuration steps
=========================

* ``sudo apt-get install swift-account=1.13.1-0ubuntu1.2 swift-container=1.13.1-0ubuntu1.2 swift-object=1.13.1-0ubuntu1.2 xfsprogs=3.1.9ubuntu2``

* ``keystone user-create --name=swift --pass="password"``

* ``keystone user-role-add --user swift --role admin --tenant service``

* ``keystone service-create  --type object-store --name swift --description "Swift storage service"``

* ``keystone endpoint-create --region Orange --service-id $SERV_ID --publicurl 'http://ops-mono-node:8080/v1/AUTH_$(tenant_id)s' --adminurl 'http://ops-mono-node:8080/v1/AUTH_$(tenant_id)s' --internalurl 'http://ops-mono-node:8080/v1/AUTH_$(tenant_id)s'``

* ``mkdir /srv/block``

* ``cd /srv/block``

* ``for i in 6 7 8; do dd if=/dev/zero of=./d$i bs=1MB count=2048; mkdir -p /srv/node/d$i; mkfs.xfs -f -L d$i ./d$i; mount -t xfs ./d$i /srv/node/d$i; done``

* ``chown -R swift:swift /srv/node``

* ``cd -``

* ``export FSTAB=/etc/fstab``

* ``echo /srv/block/d6          /srv/node/d6 xfs defaults       0 0 >> $FSTAB; echo /srv/block/d7          /srv/node/d7 xfs defaults       0 0 >> $FSTAB; echo /srv/block/d8          /srv/node/d8 xfs defaults       0 0 >> $FSTAB``

* ``sudo apt-get -y install swift=1.13.1-0ubuntu1.2 swift-proxy=1.13.1-0ubuntu1.2 memcached=1.4.14-0ubuntu9``

* ``cd /etc/swift/``

* ``swift-ring-builder account.builder create 14 3 1; swift-ring-builder container.builder create 14 3 1; swift-ring-builder object.builder create 14 3 1``

* ``swift-ring-builder object.builder add z1-127.0.0.1:6000/d6 100; swift-ring-builder object.builder add z1-127.0.0.1:6000/d7 100; swift-ring-builder object.builder add z1-127.0.0.1:6000/d8 100``

* ``swift-ring-builder container.builder add z1-127.0.0.1:6001/d6 100; swift-ring-builder container.builder add z1-127.0.0.1:6001/d7 100; swift-ring-builder container.builder add z1-127.0.0.1:6001/d8 100``

* ``swift-ring-builder account.builder add z1-127.0.0.1:6002/d6 100; swift-ring-builder account.builder add z1-127.0.0.1:6002/d7 100; swift-ring-builder account.builder add z1-127.0.0.1:6002/d8 100``

* ``swift-ring-builder account.builder; swift-ring-builder container.builder; swift-ring-builder object.builder``

* ``swift-ring-builder account.builder rebalance; swift-ring-builder container.builder rebalance; swift-ring-builder object.builder rebalance``

* ``cd -``

* ``sudo vim /etc/swift/swift.conf``

* ``sudo vim/etc/swift/proxy-server.conf``

* ``sudo swift-init all restart``

* ``sudo vim /etc/glance/glance.conf``

* ``sudo service glance-api restart;``

* ``sudo service glance-registry restart;``

* ``glance image-create --store swift --disk-format qcow2 --container-format bare --is-public True --name "CirrOS-Swift" < /vagrant/99-Utils/cirros-0.3.3-x86_64-disk.img``
