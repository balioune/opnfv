#!/bin/bash

echo \* Entering /etc/swift/ ...
cd /etc/swift/

echo \* Ring component creation with \*.builder file ...
swift-ring-builder account.builder create 14 3 1
swift-ring-builder container.builder create 14 3 1
swift-ring-builder object.builder create 14 3 1

echo \* Adding block storage to the ring ...
swift-ring-builder object.builder add z1-127.0.0.1:6000/d6 100
swift-ring-builder object.builder add z1-127.0.0.1:6000/d7 100
swift-ring-builder object.builder add z1-127.0.0.1:6000/d8 100
swift-ring-builder container.builder add z1-127.0.0.1:6001/d6 100
swift-ring-builder container.builder add z1-127.0.0.1:6001/d7 100
swift-ring-builder container.builder add z1-127.0.0.1:6001/d8 100
swift-ring-builder account.builder add z1-127.0.0.1:6002/d6 100
swift-ring-builder account.builder add z1-127.0.0.1:6002/d7 100
swift-ring-builder account.builder add z1-127.0.0.1:6002/d8 100

echo \* Completing ring ...
swift-ring-builder account.builder
swift-ring-builder container.builder
swift-ring-builder object.builder

echo \* rebalancing ring ...
swift-ring-builder account.builder rebalance
swift-ring-builder container.builder rebalance
swift-ring-builder object.builder rebalance

echo \* All done, reverting to the old PWD
cd - > /dev/null
