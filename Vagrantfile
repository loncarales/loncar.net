# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
apt-get update
apt-get install -y python-pip python-apt rsync
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.boot_timeout = 900
  config.vm.graceful_halt_timeout=100

  # vagrant-vbguest
  # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  # Vagrant Host Manager
  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/debian-9.8"
  config.vm.box_version = "201906.17.0"
  # Don't check for box update
  config.vm.box_check_update = false

  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  config.ssh.insert_key = false

  # OpenShift client box
  config.vm.define "loncar-net", primary: true do |h|
    h.vm.hostname = 'loncar-net.site'
    h.vm.network "private_network", ip: "192.168.56.100"

    # Customize VirtualBox Provider
    h.vm.provider "virtualbox" do |vb|
      vb.name   = "loncar-net"
      vb.memory = 1024
    end

  end

  # Provision Box
  config.vm.provision "shell", inline: $script

end
