#!/bin/bash
set -e

echo "Deploying mongodb to juju cluster if needed"
if [[ `juju status mongodb | grep mongodb` == "" ]]; then
    juju deploy mongodb
    juju wait-for application mongodb --query='status=="active"'
else
    echo "mongodb service already deployed, skipping"    
fi

echo "Deploying nodejs-app to juju cluster if needed"
if [[ `juju status nodejs-app | grep nodejs-app` == "" ]]; then
    juju deploy ./nodejs-app
    juju wait-for application node-app --query='status=="active"'
    juju relate node-app mongodb
else
    echo "nodejs-app service already deployed, skipping"    
fi

juju status --relations
