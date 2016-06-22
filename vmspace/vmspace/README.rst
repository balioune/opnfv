Moon's VM repository
====================
This git repository lists all the VM's specifications that are used during Moon's developpement.
vmspace is the directory to host all the VM instances and their configuration.


VM Type
-------

Four types of VM are used in this project:

* devstack: standard devstack deployement in a VM without Moon

* devstack-moon: standard devstack deployement in a VM with Moon

* devstack-k2k: multiple devstack VMs to build a Keystone-to-Keystone platform

* openstack: standard OpenStack deployement in a VM without Moon

* openstack-moon: standard OpenStack deployement in a VM with Moon

Requierements
-------------

The VM specifications rely on ``Vagrant`` (https://www.vagrantup.com/) and ``Oracle Virtualbox`` (https://www.virtualbox.org/).

Please be sure to use a Vagrant version above **1.7.4** .


