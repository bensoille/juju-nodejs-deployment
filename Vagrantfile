# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/focal64"
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 2
  end  
  
  # Provision tools and setup permissions
  config.vm.provision "shell",
    path: "provision.sh"

  # Setup and bootstrap juju cluster
  config.vm.provision "shell",
    path: "setup.sh"    

  # Deploy services
  config.vm.provision "shell", privileged: false,
    path: "deploy.sh"       
end
