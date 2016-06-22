Horizon Web UI
==============

* ``sudo apt-get -y install openstack-dashboard=1:2014.1.5-0ubuntu2 nova-novncproxy=1:2014.1.5-0ubuntu1.2 novnc=1:0.4+dfsg+1+20131010+gitf68af8af3d-2 nova-ajax-console-proxy=1:2014.1.5-0ubuntu1.2 nova-cert=1:2014.1.5-0ubuntu1.2 nova-consoleauth=1:2014.1.5-0ubuntu1.2``

* ``vim /etc/nova/nova.conf``

* ``for i in api scheduler conductor consoleauth novncproxy compute ; do sudo service nova-$i restart; done;``
