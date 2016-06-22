First-VM-Instanciation
======================

* ``nova secgroup-add-rule default tcp 22 22 0.0.0.0/0``

* ``nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0``

* ``vim /etc/nova/nova-compute.conf``

* ``for i in api scheduler conductor; do sudo service nova-$i restart; done``

* ``nova boot --flavor m1.tiny --image cirros-0.3.3-x86_64 --security-groups default --nic net-id=$NET_ID --poll inst1``

* ``nova list``

* ``nova floating-ip-associate inst1 $IP ``

* ``ping -c 4 $IP``

* ``ssh cirros@$IP``
