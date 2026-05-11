+++
date = 2020-07-07T13:19:39+02:00
title = "Ansible is now default test verifier in Molecule"
slug = "ansible-is-now-default-test-verifier-in-molecule"
tags = ["Ansible", "Molecule", "Python", "pip", "Testing", "Automation", "DevOps", "Kubernetes"]
categories = ["Professional Development", "DevOps"]
+++

## Stumbled upon

As I am currently looking for a new gig, I have some extra time. I never took the time to look into the [Kelsey Hightower's](https://twitter.com/kelseyhightower) [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way). There are many different ways to [bootstrap](https://kubernetes.io/docs/setup/) a Kubernetes cluster. Kelsey's open-source guide goes through how to bootstrap cluster without the use of installers or scripts. This approach gives us a deeper understanding of the details of Kubernetes.
I am always eager and curious about how moving parts are working together, and "lazy" as good developers are I did automate some of the steps with [Ansible](https://docs.ansible.com/ansible/latest/index.html). While I was re-using previously written roles, I've found out that [Molecule](https://molecule.readthedocs.io/en/latest/index.html) test verify sequence is not working.

The Molecule is a project that is designed to aid in the development and testing of Ansible roles. Molecule supports only the latest two major versions on Ansible, and most of the roles I've written were in the time Ansible version 2.6.x was the latest. When using Ansible with Molecule, you'll be encouraged to write roles that are well-written, easily understood and maintained.

## So what changed?

Since Molecule v3 [Testinfra](https://testinfra.readthedocs.io/en/latest/) is no longer default test verifier, if you still would like to use it, you must add it as a [pip](https://pip.pypa.io/en/stable/) dependency as is no longer installed by default. [Goss](https://github.com/aelsabbahy/goss) verifier was also removed, and Ansible is now the default test verifier.

## Why the change?

The current user experience (writing tests in [Python](https://www.python.org/) with powerful [pytest](https://docs.pytest.org/en/latest/) test engine) is inconsistent with the [Ansible Engine](https://www.ansible.com/products/engine) and [Ansible Galaxy](https://galaxy.ansible.com/). They both promise the ability to keep using YAML. "native" way of doing testing, so this should come first as this will also improve the experience for new Ansible users.

## What about us who were used to write tests in Python. Should we switch to writing tests in Ansible?

Absolutely. On first glance, writing tests in Ansible seems a little odd. But you probably already had some tasks in your playbooks which did some validation—for example, confirming that the service is responding with status code 200.

```yaml
# Simple example
- name: Check healt of service
  uri:
    url: "http://localhost/health"
    status_code: 200
  register: register_health
  until: register_health.status == 200
  retries: 10
  delay: 10
```

[Registering variables](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#registering-variables) and using [set_facts](https://docs.ansible.com/ansible/latest/modules/set_fact_module.html) and [assert](https://docs.ansible.com/ansible/latest/modules/assert_module.html) modules will prove useful for testing.

For further ideas on how to test with Ansible reference the [documentation](https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html) and Ansible [source code](https://github.com/ansible/ansible/tree/devel/test/integration/targets) of test verifying:

* <https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html>
* <https://github.com/ansible/ansible/tree/devel/test/integration/targets>

## Example

Let's look at a simple example. Let's say we would like to use Molecule to test if some set of packages were installed within the role.

## Ansible way

```yaml
---

- name: Verify
  hosts: all

  tasks:
    - name: Gather the package manager facts
      package_facts:
        manager: auto

    - name: Assert that following packages are installed
      assert:
        that:
          - "'docker-ce' in ansible_facts.packages"
          - "'kubelet' in ansible_facts.packages"
          - "'kubectl' in ansible_facts.packages"
          - "'kubeadm' in ansible_facts.packages"
```

## Testinfra way

```python
import os
import pytest

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.mark.parametrize('pkg', [
  'docker-ce',
  'kubelet',
  'kubectl',
  'kubeadm'
])
def test_pkg(host, pkg):
    package = host.package(pkg)

    assert package.is_installed
```

What do you think?

> And remember, contributions earn you karma. 😜
