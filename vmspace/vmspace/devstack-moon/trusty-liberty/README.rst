
Installation
============

* configure the devstack.provision.sh with  proxy ...

* ``vagrant up``

* ``cd ~/devstack || source openrc admin``

* ``sudo keystone-manage db_sync --extension=moon``

Manipulation
============

Initialization
--------------

* check keystone is ok: ``keystone tenant-list``

* check moon is ok: ``moon tenant list``

Update keystone-moon Code
-------------------------

* ``sudo service apache2 restart``

Update moonclient code
----------------------

* ``sudo python setup.py install``

moonwebview
===========

