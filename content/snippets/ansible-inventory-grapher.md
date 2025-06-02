+++
date = 2020-05-24T20:25:29+02:00
title = "Ansible Inventory Grapher"
slug = "ansible-inventory-grapher"
+++

Ansible Inventory Grapher generates inventory graphs, so we can quickly see what groups are used for a particular host in Ansible inventory. The tool creates a [GraphViz](http://www.graphviz.org) DOT file format in quite an opinionated fashion (currently there is no way to choose fonts or shapes, the program decides for you!)

The tool can be found in [ansible-inventory-grapher](https://github.com/willthames/ansible-inventory-grapher) GitHub repo. As mentioned above, we need both Ansible and Graphviz installed to be able to use the tool.

## Getting started

```bash
$ pip install ansible-inventory-grapher

# DOT files are stored in ./graphs folder
$ ansible-inventory-grapher -i hosts.ini -d graphs -o loncar_net.dot --visible-vars=ansible_host --visible-vars=ansible_user loncar_net

# The resulting graphs can then be converted to pngs using this command. Assuming the DOT files are stored in graphs folder
$ for f in graphs/*.dot ; do dot -Tpng -o graphs/`basename $f .dot`.png $f; done
```

{{< figure src="https://cdn.loncar.net/loncar_net.png" alt="Ansible Inventory Grapher - Vagrant host" caption="Ansible Inventory Grapher - Vagrant host" >}}
