#!/bin/bash
set -e

echo "Deploying mongodb to juju cluster if needed"
if [[ `juju status mongodb | grep mongodb` == "" ]]; then
    juju deploy mongodb
else
    echo "mongodb service already deployed, skipping"    
fi