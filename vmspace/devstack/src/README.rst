Devstack-stand environement
===========================

Presentation
------------

This program will attempt to automatically get, install and configure a working developpment with DevStack in a Virtualbox's VM.

More preciseley, this script will perform the following tasks:

- Get a Ubuntu Trusty Tahr Server image from Hashicorp repository ("Hashicorp Cloud")

- Set up proxy for the the OS, Apt, Git and DevStack;

- Update Apt packages index,

- Upgrade Apt packageskages

- install the GIT VCS,

- set up it proxy support,

- Download devstack

- Patch it to use HTTPS protocole for cloning instead of the Git one (blocked by many company firewall)

- Set up devstack

- Run Devstack

There are three files which must be in the same directory:

- The ``VagrantFile`` describing:

  + The VM template to be used,

  + the custom settings to be applied,

  + The provisionning script to be launched;

- the ``devstack.provision.sh`` script aiming at installing DevStack dependancies, installing it, configure it and launching it.

- the ``local.conf`` configuration file, wich contains all parameters for DevStack.

Prerequisite
------------
- A working network connction which access Ubuntu APT repository and Hashicorp's cloud,
- Oracle Virtualbox,
- Vagrant (>=1.7.2),
- A ssh client.

Configuration
-------------

Before launching Vagrant, it is nacessary to configure some of the variable inside ``devstack.provision.sh``:

=================== =================================
Parameters          Descriptions
=================== =================================
http_proxy          Proxy server URL for HTTP connections
https_proxy         Proxy server URL for HTTPS connections
ftp_proxy           Proxy server URL for FTP connections
no_proxy            Hosts to connect without using proxy server (ex: localhost)
APT_CONF            Apt Proxy configuration file
BRANCH              Branch of Openstack's project's Git repository to be cloned. 
URL_DEVSTACK        GIT Repository of Devstack to be used.
REP_REPO_DEVSTACK   Folder in whick Devstack Git repository has to be cloned.
DEVSTACK_USER       System user that will run Stack.sh. Must not be a super user.
=================== =================================

Directly related to devstack installation variables are located in ``local.conf`` file:

=================== =================================
Parameters          Descriptions
=================== =================================
FIXED_RANGE         IP range for Nova's instances' viertual network
NETWORK_GATEWAY     Gateway adress between Openstack virtual network & the real network
LOGDAY              Log retention delay
LOGDIR              Openstack's logs dir
LOGFILE             Openstack's main log path
ADMIN_PASSWORD      Pasword for admin and demon account in Openstack set up.
DATABASE_PASSWORD   MySQL root user password to be set
RABBIT_PASSWORD     Rabbit guest user password to be set
SERVICE_PASSWORD    OpenStack's service users passwords, to be used with Keystone
SERVICE_TOKEN       Keystone's Administration token.
CONF_FILE           Location where ``local.conf`` file has to be installed.
=================== =================================

Frequently Asked Question
-------------------------

Can i use this script to set up another version of OpenStack's component ?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yes : simply re-define the ``BRANCH`` variable in ``devstack.provision.sh``  script file. The value must be a valid branch name of the OpenStacknStack's components' GitHub's repository.

Example: master, stable/kilo, stable/juno.
