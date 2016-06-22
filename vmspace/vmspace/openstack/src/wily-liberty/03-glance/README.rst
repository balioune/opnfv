Glance installation instruction
===============================

* ``sudo apt-get install glance=1:2014.1.5-0ubuntu1``

* ``sudo vim /etc/glance/glance-api.conf``

* ``sudo vim /etc/glance/glance-registry.conf``

* ``mysql -u root -p`` ...

* ``sudo glance-manage db_sync``

* ``source /vagrant/01-Prerequisite/01-credentials/unset-keystone-env.source.sh``

* ``source /vagrant/01-Prerequisite/01-credentials/set-ops-env.source.sh``

* ``keystone user-create --name=glance --pass="password"``

* ``keystone user-role-add --user glance --role admin --tenant service``

* ``keystone service-create --name glance --type image --description "OpenStack Image Service"``

* ``keystone endpoint-create --region Orange --service-id $SERV_ID --publicurl 'http://localhost:9292' --adminurl 'http://localhost:9292' --internalurl 'http://localhost:9292'``

* ``sudo service glance-api restart``

* ``sudo service glance-registry restart``

* ``wget http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img``

* ``glance image-create --name "cirros-0.3.3-x86_64" --disk-format qcow2 --file ./cirros-0.3.3-x86_64-disk.img --container-format bare --is-public True``
