OpenStack dependancies installation
===================================

APT Conf
--------

* ``sudo cat << EOF > /etc/apt/apt.conf.d/20-proxy.conf
Acquire::http::Proxy "http://proxy.rd.francetelecom.fr:8080";
Acquire::https::Proxy "https://proxy.rd.francetelecom.fr:8080";
Acquire::ftp::Proxy "ftp://proxy.rd.francetelecom.fr:8080";
EOF``

* ``sudo apt-get update``


MySQL
-----

* ``sudo apt-get install -y mysql-server=5.5.44-0ubuntu0.14.04.1 python-mysqldb=1.2.3-2ubuntu1``

* ``sudo -s``

* ``cp /etc/mysql/my.cnf /etc/mysql/my.cnf.old``

* ``sed "s/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g" /etc/mysql/my.cnf.old > /etc/mysql.cnf``

* ``cat << EOF > /etc/mysql/conf.d/encode.cnf
# File edited for fullfilling UTF-8 compatibility between MySQL & OpenStack.
  
[mysqld]
collation-server= utf8_general_ci
character-set-server = utf8
EOF ``
  
* ``service mysql restart``

* ``exit``
 
Rabbitmq
--------

* ``sudo apt-get install -y rabbitmq-server=3.2.4-1``

* ``sudo rabbitmqctl change_password guest password``

Apache2 Web Server
------------------

* ``sudo apt-get install -y apache2=2.4.7-1ubuntu4.5``

Hostname
--------

* ``sudo hostnamectl set-hostname ops-mono-node``

* ``vim /etc/hosts``
