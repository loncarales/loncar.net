+++ 
date = 2020-05-16T19:10:07+02:00
title = "How to create a Vagrant Red Hat Enterprise Linux box"
slug = "how-to-create-a-vagrant-red-hat-enterprise-linux-box"
tags = ["RHEL", "Red Hat Enterprise Linux", "VirtualBox", "Vagrant"]
categories = ["Development", "Work", "DevOps"]
+++

This guide will show you how to create a Vagrant Box based on RHEL 7.6, which I've used to simulate the production environment so I could quickly test Ansible playbooks while developing them.

## What we need

* [Red Hat Enterprise Linux](https://developers.redhat.com/products/rhel/download)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)


After we install Vagrant and Virtualbox, we can start with the creation of the new Virtual machine.

## Create a new Virtual machine with VirtualBox

> Start the VirtualBox

Click New → Name: "rhel 7.6" → Memory size: 2048 MB → Create new dynamic disk: 40 GB VMDK → System Processor: 2 CPU

During the installation, you will have the possibility to create a user account and set an admin password. For the admin password, you can place anything you want. For the user account set username and password to `vagrant`. Make the user also an administrator. Choose minimal install

After the installation, reboot the VM. Log in with `vagrant` user.

> Register and subscribe a VM to the Red Hat Customer Portal using Red Hat Subscription-Manager

```bash
$ sudo subscription-manager register --username <redhat_account_username> --password <redhat_account_password> --auto-attach
# or
$ sudo subscription-manager register --org=<organization_id> --activationkey=<activation_key_name>
```

> Install the needed dependencies

```bash
# Needed for Vagrant
$ sudo yum install openssh wget

# Needed for Virtualbox Guest Additions
$ sudo yum install gcc perl bzip2
$ sudo yum install "kernel-devel-uname-r == $(uname -r)"
 
# Verify the headers are now installed
$ ls /usr/src/kernels*
```

> Check the version of VirtualBox → 6.0.14

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/VirtualBox-version.png" alt="VirtualBox → 6.0.14" caption="VirtualBox → 6.0.14" >}}

> Download Guest Additions for VirtualBox for our version of VirtualBox and install it.

```bash
# Download
$ wget http://download.virtualbox.org/virtualbox/6.0.14/VBoxGuestAdditions_6.0.14.iso
 
# Install
$ sudo mkdir /media/VBoxGuestAdditions
$ sudo mount -o loop,ro VBoxGuestAdditions_6.0.14.iso /media/VBoxGuestAdditions/
$ sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
 
# Cleanup
$ rm VBoxGuestAdditions_6.0.14.iso
$ sudo umount /media/VBoxGuestAdditions
$ sudo rmdir /media/VBoxGuestAdditions
```

> Setup the Vagrant user with an insecure ssh keypair, so we can ssh into the VM via `vagrant ssh` command.

```bash
$ mkdir .ssh
$ chmod 0700 .ssh
$ cd .ssh/
$ wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O authorized_keys
$ chmod 0600 authorized_keys
```

> Allow users in the wheel group to run commands with sudo without the need to enter the password.

```bash
# Type `sudo visudo` and change the following line
%wheel ALL=(ALL) ALL 
# to
%wheel ALL=(ALL) NOPASSWD: ALL
```

The VM is now ready to be exported as a Vagrant box. First shutdown the VM and then on your computer (i.e. not in the VM) run the following commands.

> Package VM as a Vagrant box

```bash
$ vagrant package --base "rhel 7.6"
$ vagrant box add --name rhel76 package.box
```

After that, the new RedHat machine can be utilised with Vagrant. Let's try it out.

## Vagrant RHEL Box

```bash
$ vagrant init rhel76
$ vagrant up
$ vagrant ssh
[vagrant@localhost ~]$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
polkitd:x:999:998:User for polkitd:/:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
vboxadd:x:998:1::/var/run/vboxadd:/bin/false

[vagrant@localhost ~]$ cat /etc/*-release
NAME="Red Hat Enterprise Linux Server"
VERSION="7.6 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.6"
PRETTY_NAME="Red Hat Enterprise Linux"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.6:GA:server"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 7"
REDHAT_BUGZILLA_PRODUCT_VERSION=7.6
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="7.6"
Red Hat Enterprise Linux Server release 7.6 (Maipo)
Red Hat Enterprise Linux Server release 7.6 (Maipo)
```

If we make any changes inside the box and we would like to persist them, we need to repackage the VM into a new Vagrant box.

```bash
# Repackage the VM into a New Vagrant Box
$ vagrant package --output mynew.box
# Add the Box into Your Vagrant Install
$ vagrant box add mynewbox mynew.box # We may need to force it with --force
```

> And remember, contributions earn you karma. 😜
