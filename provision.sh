#!/bin/bash
set -e

# Udpating OS first
echo "Updating OS"
apt-get update
apt-get -y upgrade

echo "Installing juju"
snap install juju --classic

echo "Setting up groups and permissions"
newgrp lxd
adduser vagrant lxd

echo "Installing charms toolset"
snap install charmcraft --classic