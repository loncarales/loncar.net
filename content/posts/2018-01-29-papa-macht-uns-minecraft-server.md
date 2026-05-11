+++
date = "2018-01-29"
title = "Papa, kannst du uns einen Minecraft-Server machen?"
slug = "papa-macht-uns-minecraft-server"
tags = ["Ansible", "Minecraft", "Debian", "Linux Server", "Automation", "CI/CD", "DevOps"]
categories = ["Professional Development"]
+++

Sure, no problem, just for you two to play and explore and for me to hack the stuff :) But wait, these days almost anyone can follow the steps online and do this. Let's make it my way :)
I've written a set of [Ansible](https://www.ansible.com) playbooks enabling me to create [Minecraft](https://minecraft.net/) Java Edition Server on [Debian](https://www.debian.org/) 9 (Stretch).

The playbooks will:

* add limited user account
* install all required packages
* secure the server
    * automatic security updates
    * hardening SSH access
    * using Fail2Ban for SSH login protection (TODO)
    * configure a Firewall with UFW
* install and configure Minecraft Server
* install and configure McMyAdmin for Minecraft

With the help of Ansible, you'll get your server up and be running in a matter of minutes.

You can find the source code on [GitHub](https://github.com/loncarales/minecraft-server-ansible)
