+++ 
date = 2020-05-25T20:25:29+02:00
title = "Ansible Inventory Grapher"
slug = "ansible-inventory-grapher"
+++

Ansible Inventory Grapher generates inventory graphs, so we can quickly see what groups are used for a particular host in Ansible inventory. The tool creates a [GraphViz](http://www.graphviz.org) DOT file format in quite an opinionated fashion (currently there is no way to choose fonts or shapes, the program decides for you!)

The tool can be found in [ansible-inventory-grapher](https://github.com/willthames/ansible-inventory-grapher) GitHub repo. As mentioned above, we need both Ansible and Graphviz installed to be able to use the tool.

<script src="https://embed.cacher.io/d5516b810d61f912a8ac13960f2919ae230aaa41.js?a=6382b80c20f8e61a4382cb24d26aaa09"></script>

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/loncar_net.png" alt="Ansible Inventory Grapher - Vagrant host" caption="Ansible Inventory Grapher - Vagrant host" >}}
