+++
date = 2020-05-25T14:20:07+02:00
title = "How to build RHEL based docker images on Red Hat Enterprise Linux"
slug = "how-to-build-rhel-based-docker-images-on-redhat-enterprise-linux"
tags = ["RHEL", "Red Hat Enterprise Linux", "Docker", "Red Hat Subscription Management"]
categories = ["Professional Development", "Work", "DevOps", "Learn-by-Doing"]
series = ["Learn-by-Doing"]
+++

Let's see how [Red Hat Enterprise Linux](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) and [Docker](https://www.docker.com/) are playing well together.

The simple search on google "[install docker RHEL](https://is.gd/dSaOTl)" will lead you off the track as easy as it gets. Some of the top results include:

* [How to install and setup Docker on RHEL 7/CentOS 7](https://www.cyberciti.biz/faq/install-use-setup-docker-on-rhel7-centos7-linux/)
* [How to install Docker CE on RHEL 8 / CentOS 8 ](https://linuxconfig.org/how-to-install-docker-in-rhel-8)
* [How To Install Docker on CentOS 7 / RHEL 7](https://www.itzgeek.com/how-tos/linux/centos-how-tos/installing-docker-on-centos-7-rhel-7-fedora-21.html)
* [Install Docker CE on CentOS and RHEL 7](https://medium.com/better-programming/install-docker-ce-on-centos-or-rhel-7-48bb111cc635)

These tutorials have one thing in common. They are explaining how we can install Docker CE on RHEL.

**DON'T**

There are many reasons not to do this. First off all [Docker CE](https://docs.docker.com/engine/install/) is not even supported for Red Hat Enterprise Linux.

{{< figure src="https://cdn.loncar.net/Docker+Supported+platforms.png" alt="Docker CE Engine Supported Platforms" caption="Docker CE Engine Supported Platforms" >}}

## But we've managed to install Docker CE

Sure but we'll probably have issues when building RHEL based Docker images. RHEL requires a subscription to install/update packages with [yum](http://yum.baseurl.org/). So if we want to create RHEL based images, we must have an active subscription. Docker CE will not pass the [Red Hat Subscription Management](https://access.redhat.com/products/red-hat-subscription-management/) information from the host into containers, and we don't want to add an active subscription to every Docker image we build. 😉

Ok, now what?

Well for average user installing Docker from RPM will be enough. If we really would like to have the latest and greatest, then we must go for [Docker Engine - Enterprise for Red Hat Enterprise](https://docs.docker.com/ee/docker-ee/rhel/).

{{< figure src="https://cdn.loncar.net/Docker+Enterprise+-+RHEL.png" alt="Docker Enterprise (Red Hat Enterprise Linux)" caption="Docker Enterprise (Red Hat Enterprise Linux)" >}}

## Installing Docker from RPM

First, we must ensure we are using Red Hat's supported docker package on a registered RHEL or [Atomic Server](https://www.redhat.com/en/resources/enterprise-linux-atomic-host-datasheet).

> First register system to Red Hat account

```bash
$ subscription-manager register --username=<USERNAME> --password=<PASSWORD>
# or
$ subscription-manager register --org=<ORG> --activationkey=<KEY_NAME>
```

> Let's enable the following repositories after our system is registered

```bash
$ subscription-manager repos --enable rhel-7-server-optional-rpms --enable rhel-7-server-extras-rpms --enable rhel-server-rhscl-7-rpms
```

> Let's install the docker package from RPM as root user

```bash
$ yum install docker
$ systemctl enable docker
$ systemctl start docker
$ docker info
# Run Hello World
$ docker run hello-world
```

There is a patch in RHEL docker package which provides subscription management information from the host into containers for both `docker run` and `docker build`.  More about the [patch itself](https://github.com/projectatomic/docker/tree/docker-1.13.1-rhel#add-rhel-super-secrets-patchpatch).

## Red Hat Enterprise Linux Universal Base Images (UBI)

The second option is to use the [Universal Base Images (UBI)](https://developers.redhat.com/blog/2019/05/31/working-with-red-hat-enterprise-linux-universal-base-images-ubi/). With UBI images, we don't need an active RHEL subscription to build custom images. The UBI images can be used on any Linux distribution and also with Docker CE or [Podman](https://podman.io/).

> And remember, contributions earn you karma. 😜
