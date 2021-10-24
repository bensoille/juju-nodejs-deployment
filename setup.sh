#!/bin/bash
set -e

echo "Init LXD, IPv4 only"
lxd init --auto

echo "Init LXD, IPv4 only (setting up)"
lxc network set lxdbr0 ipv6.address none

echo "Bootstrap juju cluster if needed"
if [[ `sudo -u vagrant juju controllers | grep bliqtryout` == "" ]]; then
    sudo -u vagrant juju bootstrap localhost bliqtryout
else 
    echo "Controller already up, skipping creation"    
fi    