#!/usr/bin/env bash

for service in swift-account swift-account-replicator \
                swift-container-replicator  swift-object swift-object-updater \
                swift-account-auditor swift-container swift-container-sync \
                swift-object-auditor swift-proxy swift-account-reaper swift-container-auditor \
                swift-container-updater swift-object-replicator ; do
    sudo service ${service} status
done

#TODO: check out why we should restart the VM for swift restart
echo "-------to really restart swift services, we should vagrant reload VM-----------"