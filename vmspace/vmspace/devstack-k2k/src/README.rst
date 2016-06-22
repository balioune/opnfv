Keystone federation with Moon
=============================

The `Vagrantfile` file is configured to use 2 virtual machines, one master and one slave.
A second slave is also configured but the configuration lines a commented.

The VMs are on the same private network 192.168.22.0, named: "federation".
The master VM is a Devstack server with Moon configured, The slaves are just Devstack servers
which use the master server as an identity provider and an authorization provider with the help of keystonemiddleware-moon.

How-to use it
-------------

.. code-block:: bash

    vagrant up # to initiate/start 2 VM
    vagrant up master # to only initiate/start the master VM
    vagrant ssh master # to log into the master
    vagrant ssh devstack1 # to log into the slave
    vagrant suspend # suspend all VMs
    vagrant suspend master # suspend the master VM
    vagrant destroy # destroy all VMs
    vagrant destroy master # destroy the master VM

