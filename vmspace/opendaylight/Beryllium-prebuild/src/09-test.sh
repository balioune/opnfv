#!/usr/bin/env bash

curl http://admin:admin@127.0.0.1:8188/controller/nb/v2/neutron/networks
#curl -u admin:admin --url http://127.0.0.1:8189/controller/nb/v2/neutron/networks

# features to install
# odl-l2switch-switch-ui,odl-dlux-all,