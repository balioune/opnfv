===========================
Standard OpenStack Platform
===========================

*hostname: ops-mono-node*

This repo contains all installation instruction for OpenStack kilo in a mono-node environement.


How to use the files in this repository ?
=========================================

Each repository contains the necessary files to configure one OpenStack component.

**Warning:** Each file must be considered according to the increasing prefix number (typically, *01*-apt.sh must be executed before *09*-test.sh) 

**Notice:** Configuration file folder contains only examples of built configuration files. Considering the other files must have enable you to have build your own config files.

Shell files (*.sh)
------------------

They must be given the execution right (or transmitted to the bash interpreter as argument), and be execute as normal user.

Root shell files (*.root.sh)
----------------------------

They must be use as regular shell script, except that they need superuser's rights.

Source shell scripts (*.source.sh)
----------------------------------

These scripts has to be sourced in a regular user environement with the ``source`` (``source myfile.source.sh``).

SQL Script files (*.sql)
------------------------

These scripts contain instructions to be transmitted to a MySQL database administrator shell (``mysql -u root -p < myscript.sql``).

Patch files (*.patch)
---------------------

Instanciated at the top of the filesystem, the *patch* utils will patch the right file according to the fullfilled patch.
``cd / && sudo patch < myfile.patch``

Installation instructions
=========================

Dependancies
------------

All installation instructions are located `here <01-Prerequisite/>`_.

Keystone
--------

Please be sure to have loaded keystone token environement before proceeding.

Further instructions are available  `here <02-keystone/>`_.


Glance
------

You must use regular credential from here.

Please visit `this page <03-glance/>`_ to get started.

Nova
----

First part of the Nova configuration process is located  `here <04-nova/>`_.


Neutron
-------

This is the most complex installation process.

You can get started `here <05-neutron/>`_.

First VM Instanciation and Configuration
----------------------------------------

The last part of Nova configuration is located `here <06-First-VM-Instanciation/>`_.

Horizon WebUI
-------------

Web UI configuration is located `here <07-horizon/>`_.

Cinder
------

The block storage utility is configurable with `these instructions <08-cinder/>`_.

Swift
-----

The object storage utility set up steps are indicated `here <09-swift/>`_.

Info & passwords
================

This table references all password used for the plateform:

========        ======================================= =========
module          user                                    password
========        ======================================= =========
mysql           root                                    password
mysql           keystone/keystonedb                     password
mysql           glance/glancedb                         password
mysql           nova/novadb                             password
mysql           neutron/neutrondb                       password
mysql           cinder/cinderdb                         password
rabbitmq        guest                                   password
keystone        admin_token                             password
keystone        admin                                   password
keystone        demo                                    password
keystone        keystone                                password
keystone        glance                                  password
keystone        nova                                    password
keystone        neutron                                 password
keystone        cinder                                  password
keystone        swift                                   password
neutron         neutron_metadata_proxy_shared_secret    password
swift           swift_hash_path_prefix                  password
swift           swift_hash_path_suffix                  password
========        ======================================= =========

ERROR
=====

nova server building
--------------------

Error building server: ``sudo reboot``

vagrant
-------
mount shared folder: ``sudo mount -t vboxsf vagrant /vagrant``

rabbitmq
--------
ERROR AMQP server on ops-mono-node:5672 is unreachable: Socket closed. Trying again in 30 seconds.

* ``sudo rabbitmqctl change_password guest password``

* ``sudo service rabbitmq-server restart``

