Neutron installation Instruction
================================

* ``sudo apt-get install neutron-server=1:2014.1.5-0ubuntu1 neutron-plugin-ml2=1:2014.1.5-0ubuntu1 neutron-plugin-openvswitch-agent=1:2014.1.5-0ubuntu1 neutron-l3-agent=1:2014.1.5-0ubuntu1 neutron-dhcp-agent=1:2014.1.5-0ubuntu1``

* ``sudo vim /etc/neutron/neutron.conf``

* ``sudo vim /etc/neutron/plugins/ml2/ml2_conf.ini``

* ``sudo vim /etc/sysctl.d/20-neutron.conf``

* ``sudo sysctl -p /etc/sysctl.d/20-neutron.conf``

* ``sudo vim /etc/network/interfaces``

* ``sudo vim /etc/network/interface.d/br-ex.cfg``  

* ``sudo vim /etc/network/interface.d/eth1.cfg``  
 
* ``sudo ovs-vsctl add-br br-ex``

* ``sudo ovs-vsctl add-port br-ex eth1``

* ``sudo ifconfig eth1 0.0.0.0``

* ``sudo ifconfig br-ex 192.168.33.30``

* ``sudo vim /etc/neutron/l3-agent.ini``
  
* ``sudo vim /etc/neutron/dhcp_agent.ini``

* ``sudo vim /etc/neutron/dnsmasq.conf``

* ``sudo vim /etc/neutron/metadata_agent.ini``

* ``keystone user-create --name=neutron --pass="password"``

* ``keystone user-role-add --user neutron --role admin --tenant service``

* ``keystone service-create --name neutron --type network --description "OpenStack Networking Service"``

* ``keystone endpoint-create --region Orange --service-id $NEUTRON_ID --publicurl 'http://ops-mono-node:9696/' --adminurl 'http://ops-mono-node:9696/' --internalurl 'http://ops-mono-node:9696/'``

* ``vim /etc/nova/nova.conf``

* ``mysql -u root -p``

* ``for i in server plugin-openvswitch-agent l3-agent dhcp-agent metadata-agent; do sudo service neutron-$i restart; done;``

* ``for i in api scheduler conductor; do sudo service nova-$i restart; done;``

* ``neutron net-create ext-net --provider:network-type flat --provider:physical_network physnet1 --router:external=True --tenant-id $ADMIN_ID``

* ``neutron subnet-create ext-net --name ext-subnet --allocation-pool start=192.168.33.100,end=192.168.33.200 --disable-dhcp 192.168.33.0/24 --tenant-id $ADMIN_ID``

* ``neutron net-create demo-net1``

* ``neutron subnet-create --ip-version 4 --name demo-subnet1 demo-net1 10.5.5.0/24``

* ``neutron router-create router1``
  
* ``neutron router-interface-add router1 demo-subnet``
  
* ``neutron router-gateway-set router1 ext-net``

* error: unsupported locale setting: ``sudo locale-gen "en_US.UTF-8"`` ``sudo locale-gen "fr_FR.UTF-8"`` and ``sudo dpkg-reconfigure locales``