Nova installation instruction
=============================

* ``sudo apt-get install nova-api=1:2014.1.5-0ubuntu1.2 nova-scheduler=1:2014.1.5-0ubuntu1.2 nova-conductor=1:2014.1.5-0ubuntu1.2 nova-compute=1:2014.1.5-0ubuntu1.2 python-novaclient=1:2.17.0-0ubuntu1.2``

* ``sudo vim /etc/nova/nova.conf``

* ``mysql -u root -p`` ...

* ``sudo -u nova nova-manage db sync``

* ``keystone user-create --name=nova --pass="password"``

* ``keystone user-role-add --user nova --role admin --tenant service``

* ``keystone service-create --name nova --type compute --description "OpenStack Compute Service"``

* ``keystone endpoint-create --region Orange --service-id e526d26fdcb34a57afd604e2f391f5e8 --publicurl 'http://localhost:8774/v2/%(tenant_id)s' --adminurl 'http://localhost:8774/v2/%(tenant_id)s' --internalurl 'http://localhost:8774/v2/%(tenant_id)s'``

* ``sudo service nova-api restart``

* ``sudo service nova-scheduler restart``

* ``sudo service nova-conductor restart``
