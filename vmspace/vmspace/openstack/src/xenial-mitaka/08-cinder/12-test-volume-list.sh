#!/bin/bash

echo \* Auditing service ...
cinder service-list

echo \* Testing volume listing ...
cinder list
