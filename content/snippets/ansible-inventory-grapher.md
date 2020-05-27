+++ 
date = 2020-05-24T20:25:29+02:00
title = "Ansible Inventory Grapher"
slug = "ansible-inventory-grapher"
+++

Ansible Inventory Grapher generates inventory graphs, so we can quickly see what groups are used for a particular host in Ansible inventory. The tool creates a [GraphViz](http://www.graphviz.org) DOT file format in quite an opinionated fashion (currently there is no way to choose fonts or shapes, the program decides for you!)

The tool can be found in [ansible-inventory-grapher](https://github.com/willthames/ansible-inventory-grapher) GitHub repo. As mentioned above, we need both Ansible and Graphviz installed to be able to use the tool.

{{< gist loncarales 00202a81f2edd631c1f9ccef578ddcaf >}}

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/loncar_net.png" alt="Ansible Inventory Grapher - Vagrant host" caption="Ansible Inventory Grapher - Vagrant host" >}}
