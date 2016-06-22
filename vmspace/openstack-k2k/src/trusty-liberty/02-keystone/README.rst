Keystone installation
---------------------

* ``sudo apt-get install -y keystone=1:2014.1.5-0ubuntu1``

* ``sudo vim /etc/keystone/keystone.conf``

* ``mysql -u root -p`` ...

* ``sudo keystone-manage db_sync``

* ``sudo service keystone restart``

* ``source 97-needed-credentials.source.sh``

* ``keystone tenant-create --name admin && keystone tenant-create --name demo && keystone tenant-create --name service`

* ``keystone user-create --name admin --pass "password" && keystone user-create --name demo --pass "password" && keystone user-create --name keystone --pass "password"``
  
* ``keystone role-create --name admin``

* ``keystone user-role-add --user admin --role admin --tenant admin && keystone user-role-add --user demo --role admin --tenant demo && keystone user-role-add --user keystone --role admin --tenant service``

* ``keystone service-create --name keystone --type identity --description 'OpenStack Keystone``

* ``keystone endpoint-create --region Orange --service-id $SERVICE_ID --publicurl http://localhost:5000/v2.0 --internalurl http://localhost:5000/v2.0 --adminurl http://localhost:35357/v2.0``

* ``keystone endpoint-list``
