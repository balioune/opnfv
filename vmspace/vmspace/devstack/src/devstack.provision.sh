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
# Ce présent script a été testé sur Ubuntu Trusty, avec une configuration dèrrière un serveur Proxy


############################ Configuration du script #############################################
## Proxy
	## Info : Diverses variables sur le proxy
http_proxy=
https_proxy=
ftp_proxy=
no_proxy=localhost,127.0.0.0/8,::1
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

echo
echo == Mise à jour de APT
echo 	\*  Mise à jour des dépots
apt-get update -y

echo 	\* Mise à jour du système
apt-get dist-upgrade -y

echo
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
echo
echo == Récupération de Devstack
echo 	\* Création répertoire : $REP_REPO_DEVSTACK
rm -rf $REP_REPO_DEVSTACK
mkdir $REP_REPO_DEVSTACK
cd $REPO_REPO_DEVSTACK
echo	\* Clonage dépot : $URL_DEVSTACK
git clone -b $BRANCH $URL_DEVSTACK $REP_REPO_DEVSTACK 

# configuration devstack
echo
echo == Configuration de l\'environement de Devstack - local.conf
echo 	\* Rentre dans $REP_REPO_DEVSTACK
cd $REP_REPO_DEVSTACK 
echo 	\* Copie du fichier de configuration original 
cp /vagrant/local.conf $CONF_FILE

# Path pour eviter l'usge de git
echo
echo == Patch de stackrc pour bannir l\'usage du protocol git
sed s/git:\\/\\/git.openstack.org/https:\\/\\/git.openstack.org/g stackrc > stackrc.new
mv stackrc stackrc.old
cp stackrc.new stackrc

### Fix 1-4-2016: see: https://ask.openstack.org/en/question/86725/got-an-error-during-installation-of-kilo-error-in-setup-command-error-parsing-optstackkeystonesetupcfg-importerror-no-module-named-testrepository/
echo
echo == Installation du paquetage PIP testrepository
echo    \* Installation de PIP
apt-get install -y python-pip
echo    \* Installation du paquetage testrepository
pip install testrepository

echo
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
