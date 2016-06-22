#!/usr/bin/env bash


echo PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-7-openjdk-amd64/bin/ | sudo tee -a /etc/environment
echo JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ | sudo tee -a /etc/environment
echo _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true | sudo tee -a /etc/environment
export MAVEN_OPTS='-Xmx1024m -XX:MaxPermSize=512m'

source /etc/environment

