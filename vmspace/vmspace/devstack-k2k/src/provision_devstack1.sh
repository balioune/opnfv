#!/bin/bash

# Copyright 2015 Open Platform for NFV Project, Inc. and its contributors
# This software is distributed under the terms and conditions of the 'Apache-2.0'
# license which can be found in the file 'LICENSE' in this package distribution
# or at 'http://www.apache.org/licenses/LICENSE-2.0'.

# Ce  script cherche à provisionner une machine Ubuntu Trusty avec une installation de Devstack.
# Les étapes réalisées par ce script sont les suivantes:
# 	* Configuration du support du proxy par la VM par APT et le script d'installation
#	* MAJ des index des dépots APT
#	* MAJ des paquets du système
#	* Installation du SCM GIT
#	* Configuration du support du proxy par ce dernier
#	* Récupération de DevStack
#	* Patch de ce dernier pour utiliser le protocole HTTPS et non GIT
#	* Configuration de DevStack
#	* Lancement de DevStack
# Ce présent script a été testé sur Ubuntu Trusty, avec une configuration derrière un serveur Proxy


############################ Configuration du script #############################################
## Proxy
	## Info : Diverses variables sur le proxy
export http_proxy=
export https_proxy=
export ftp_proxy=
export no_proxy=localhost,127.0.0.0/8,::1

MOONIP=192.168.22.20
	## Configuration du proxy dans APT
APT_CONF=/etc/apt/apt.conf.d/20-proxy.conf
	## Utilisateur allant executer Devstack
DEVSTACK_USER=vagrant
	## Branche de devstack à utiliser (master|stable/kilo|stable/juno etc.)
BRANCH=stable/liberty

## Devstack SRC
	# Url d'où GIT doit cloner le dépot devstack
URL_DEVSTACK=https://github.com/openstack-dev/devstack.git
	# Repertoire ou dépot devstack doit être cloné
REP_REPO_DEVSTACK=~vagrant/devstack/

## Configuration de Devstack
STACK_USER=vagrant
CONF_FILE=~vagrant/devstack/local.conf
################################ Fin de la configuration ########################################

echo ====================== Début du provisonnement de devstack ========================
echo 
echo == Application de la configuration du proxy

#Si on a déclarer un proxy qqpart, alors, on supprime le fichier de configuration du proxy
if [ "$http_proxy" != "" ] || [ "$https_proxy" != "" ] || [ "$ftp_proxy" != "" ] ; then
	echo 	\* Suppression de la configuration pré-existante
	rm -f APT_CONF
fi

# Application de la configuration du proxy à APT
if [ "$http_proxy" != "" ]; then
	echo 	\* Configuration APT - Proxy HTTP : $http_proxy 
	echo Acquire::http::proxy \"$http_proxy\"\; >> $APT_CONF
fi

if [ "$https_proxy" != "" ]; then
	echo 	\* Configuration APT - Proxy HTTPS : $https_proxy
	echo Acquire::https::proxy \"$https_proxy\"\; >> $APT_CONF
fi

if [ "$ftp_proxy" != "" ]; then
	echo 	\* Configuration APT - Proxy FTP : $ftp_proxy
	echo Acquire::ftp::proxy \"$ftp_proxy\"\; >> $APT_CONF
fi

echo == Mise à jour de APT
echo 	\*  Mise à jour des dépots
apt-get update -y

echo 	\* Mise à jour du système
apt-get dist-upgrade -y

echo == Installation de git
echo 	\* Installation du paquetage
apt-get install -y git

# Application de la configuration du proxy à GIT
if [ "$http_proxy" != "" ]; then
	echo 	\* Configuration GIT - Proxy HTTP : $http_proxy 
	git config --global http.proxy $http_proxy
fi

if [ "$https_proxy" != "" ]; then
	echo 	\* Configuration GIT - Proxy HTTPS : $https_proxy
	git config --global https.proxy $https_proxy
fi

if [ "$ftp_proxy" != "" ]; then
	echo 	\* Configuration GIT - Proxy FTP : $ftp_proxy
	git config --global ftp.proxy $ftp_proxy
fi

# Clonage du dépot devstack
echo == Récupération de Devstack
echo 	\* Création répertoire : $REP_REPO_DEVSTACK
rm -rf $REP_REPO_DEVSTACK
mkdir $REP_REPO_DEVSTACK
cd $REPO_REPO_DEVSTACK
echo	\* Clonage dépot : $URL_DEVSTACK
git clone -b $BRANCH $URL_DEVSTACK $REP_REPO_DEVSTACK 

# configuration devstack
echo == Configuration de l\'environement de Devstack - local.conf
echo 	\* Rentre dans $REP_REPO_DEVSTACK
cd $REP_REPO_DEVSTACK 
echo 	\* Copie du fichier de configuration original 
cp /vagrant/local1.conf $CONF_FILE

# Path pour eviter l'usge de git
echo == Patch de stackrc pour bannir l\'usage du protocol git
sed s/git:\\/\\/git.openstack.org/https:\\/\\/git.openstack.org/g stackrc > stackrc.new
mv stackrc stackrc.old
cp stackrc.new stackrc

echo == Lancement de devstack
#Rectification des droits pour laisser Devstack accessible à l'utilisateur Vagrant
echo 	\* Rectification des droits du depot cloné de devstack ...
chown -R  $DEVSTACK_USER:$DEVSTACK_USER $REP_REPO_DEVSTACK

#Launching devstack...
echo 	\* Lancement de devstack en tant que Vagrant

# Some explications:
# - We use sudo tu impersonate the executaion of stack.sh
# - "-n" force sudo not to be interactive
# - sudo has one major drawback: it won't transfer the current execution environment to the launched program. That's why we call bash, set up environment variable and, then, execute .stack.sh
# - export no_proxy=\$(hostname -I | sed \"s/ /,/g\")$no_proxy is a trick to define $no_proxy in the new execution context, and add all IP Adress of all interface in the $no_proxy variable, to prevent bugs with the keystone's configuration of each OpenStack module.
sudo -n -u $DEVSTACK_USER bash -c "eval \"export USER=$DEVSTACK_USER && export HOME=~$DEVSTACK_USER && export http_proxy=$http_proxy && export https_proxy=$https_proxy && export ftp_proxy=$ftp_proxy && export no_proxy=\$(hostname -I | sed \"s/ /,/g\")$no_proxy && cd $REP_REPO_DEVSTACK && ./stack.sh \""

# Start of Moon installation process

# Backup original keystone directory
mv /opt/stack/keystone /opt/stack/keystone-orig
ln -s /opt/stack/keystone-moon /opt/stack/keystone

# Update Python packages for tests
if [ x$http_proxy != x ]; then
	pip_proxy_string="--proxy $http_proxy"
fi
pip install -r /opt/stack/keystone/test-requirements.txt --upgrade $pip_proxy_string
pip install nose $pip_proxy_string

# Delete package python-six from Ubuntu repositories because there is a conflict with
# the pyton package installed from PyPi
apt-get remove -y python-six

# Build log directory
mkdir /var/log/moon/
chown vagrant /var/log/moon/

# Modify /etc/keystone/keystone-paste.ini
mv /etc/keystone/keystone-paste.ini /etc/keystone/keystone-paste.ini.bak
cp /etc/keystone/keystone-paste.ini.bak /tmp/_k0
sed '/\/v2.0 = admin_api/ s/^/\/moon = moon_pipeline\n/' /tmp/_k0 > /tmp/_k1
sed '/\/v2.0 = public_api/ s/^/\/moon = moon_pipeline\n/' /tmp/_k1 > /tmp/_k2
sed '2 s/$/\n[app:moon_service]\nuse = egg:keystone#moon_service\n\n/' /tmp/_k2 > /tmp/_k3
sed '2 s/$/\n[pipeline:moon_pipeline]\npipeline = sizelimit url_normalize request_id build_auth_context token_auth admin_token_auth json_body ec2_extension_v3 s3_extension simple_cert_extension revoke_extension federation_extension oauth1_extension endpoint_filter_extension moon_service\n\n/' /tmp/_k3 > /tmp/_k4
cp /tmp/_k4 /etc/keystone/keystone-paste.ini

rm -f /tmp/_k*

# Modify /etc/keystone/keystone.conf
cat <<EOF >> /etc/keystone/keystone.conf

[moon]

# Authorisation backend driver. (string value)
authz_driver = keystone.contrib.moon.backends.flat.SuperExtensionConnector

# Moon Log driver. (string value)
log_driver = flat

# IntraExtension backend driver. (string value)
intraextension_driver = sql

# Tenant backend driver. (string value)
tenant_driver = sql

# Local directory where all policies are stored. (string value)
policy_directory = /etc/keystone/policies

# Local directory where SuperExtension configuration is stored. (string value)
root_policy_directory = policy_root

# Address and account of the Moon master (if needed)
master = http://192.168.22.10:35357
master_login = admin
master_password = nomoresecrete

EOF

# Link Moon configuration in etc to the directory in /opt/stack/keystone-moon
ln -s /opt/stack/keystone-moon/examples/moon/policies /etc/keystone/policies

# db_sync
cd /opt/stack/keystone-moon/
./bin/keystone-manage db_sync --extension moon

cd -

# rebuild keystone package
ln -s /opt/stack/keystone-orig/.git /opt/stack/keystone/.git
cd /opt/stack/keystone-moon/
python setup.py build
#rm -rf /opt/stack/keystone/.git/

cd -

# install keystonemiddleware
cd /opt/stack
git clone https://github.com/openstack/keystonemiddleware.git
ln -s /opt/stack/keystonemiddleware/.git /opt/stack/keystonemiddleware-moon/
cd /opt/stack/keystonemiddleware-moon/
python setup.py develop

# configure keystonemiddleware / nova / swift
cat <<EOF >> /etc/nova/api-paste.ini

[filter:moon]
paste.filter_factory = keystonemiddleware.moon_agent:filter_factory
auth_uri = http://${MOONIP}:35357/v3
authz_login = admin
authz_password = nomoresecrete

EOF
cp /etc/nova/api-paste.ini /etc/nova/api-paste.ini.bak
cp /etc/nova/api-paste.ini /tmp/_n0
sed '/keystone = / s/keystonecontext /keystonecontext moon /' /tmp/_n0 > /etc/nova/api-paste.ini
rm /tmp/_n0

cat <<EOF >> /etc/swift/proxy-server.conf

[filter:moon]
paste.filter_factory = keystonemiddleware.moon_agent:filter_factory
auth_uri = http://${MOONIP}:35357/v3
authz_login = admin
authz_password = nomoresecrete

EOF
cp /etc/swift/proxy-server.conf /etc/swift/proxy-server.conf.bak
cp /etc/swift/proxy-server.conf /tmp/_s0
sed '/pipeline = / s/ proxy-server/ moon proxy-server/' /tmp/_s0 > /etc/swift/proxy-server.conf
rm /tmp/_s0

# TODO: find how to restart nova-api and swift-proxy
echo "You have to restart nova-api and swift-proxy:"
echo "    screen -x stack"
echo "    [Go to screen 11]"
echo "    Crtl+C"
echo "    /usr/local/bin/nova-api & echo $! >/opt/stack/status/stack/n-api.pid; fg || echo \"n-api failed to start\" | tee \"/opt/stack/status/stack/n-api.failure\""
echo "    [Go to screen 5]"
echo "    Crtl+C"
echo "    /opt/stack/swift/bin/swift-proxy-server /etc/swift/proxy-server.conf -v & echo $! >/opt/stack/status/stack/s-proxy.pid; fg || echo \"s-proxy failed to start\" | tee \"/opt/stack/status/stack/s-proxy.failure\""

# install moonclient
cd /opt/stack/moonclient
python setup.py install

# TODO: configure moonclient
# TODO: install moonwebview
# TODO: configure moonwebview

# Restart Apache
service apache2 restart

