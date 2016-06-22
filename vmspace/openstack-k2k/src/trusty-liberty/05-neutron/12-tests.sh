#!/bin/bash

echo -e "\n * Verifying extension:"
neutron ext-list

echo -e "\n * Verifying agents:"
neutron agent-list
