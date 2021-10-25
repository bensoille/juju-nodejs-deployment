# juju deployment tryout

This project creates a virtualbox VM, managed and provisioned by vagrant.

## Prerequisites

> This repository uses `virtualbox` and sets up juju in a `vagrant` controlled _VM_  
> Please note that juju can use other deployment types : k8s, openstack, local LXD, ...

- [Vagrant](https://www.vagrantup.com/downloads) from _hashicorp_
- [virtualbox](https://www.virtualbox.org/wiki/Downloads)

## Set up
```shell
vagrant up
```

Simply issue this single command to get everything setup :  

- a linux VM (8GB ram / 2CPUs), managed by vagrant
- everything provisioned in that VM : juju, ...
- deploys charms to juju : mongodb, a nodejs app, sets up relations, ...

> This may take some minutes to complete, as there is a lot of things to do :)

Once everything is up and running, you should be presented with such output, summarizing all what's been installed :
```
Model    Controller  Cloud/Region         Version  SLA          Timestamp
default  bliqtryout  localhost/localhost  2.9.16   unsupported  01:29:10Z

App       Version  Status  Scale  Charm     Store     Channel  Rev  OS      Message
mongodb   3.6.8    active      1  mongodb   charmhub  stable    64  ubuntu  Unit is ready
node-app           active      1  node-app  local                0  ubuntu  Nodejs service started

Unit         Workload  Agent  Machine  Public address  Ports                                    Message
mongodb/0*   active    idle   0        10.21.254.62    27017/tcp,27019/tcp,27021/tcp,28017/tcp  Unit is ready
node-app/0*  active    idle   1        10.21.254.80                                             Nodejs service started

Machine  State    DNS           Inst id        Series  AZ  Message
0        started  10.21.254.62  juju-434235-0  focal       Running
1        started  10.21.254.80  juju-434235-1  focal       Running

Relation provider    Requirer             Interface            Type     Message
mongodb:database     node-app:database    mongodb              regular  
mongodb:replica-set  mongodb:replica-set  mongodb-replica-set  peer   
```

Here is the IP address of our `node-app`, deployed from [this repository](https://github.com/bensoille/containers-lifecycle-simulate).  
In this example, my IP is *10.21.254.80*. Find yours, as every deployment is different.

## Use

Just log in to you VM
```shell
vagrant ssh
```

Then `curl` your service, using IP address found at the end of provisioning.  
See [this repository](https://github.com/bensoille/containers-lifecycle-simulate) to learn more about deployed REST service.  
```shell
# Eventually display services details and find IP address
juju status --relations

# Start a container with application app-one
curl --request POST http://10.21.254.80:4000/containers -H "Content-Type: application/json" -d '{"application":"app-one"}'

# Get list of running containers
curl 10.21.254.80:4000/containers

# Stop running containers wit application app-one
curl --request DELETE http://10.21.254.80:4000/containers -H "Content-Type: application/json" -d '{"application":"app-one"}'

```
