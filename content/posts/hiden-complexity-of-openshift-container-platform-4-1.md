+++ 
date = 2019-08-09T22:34:47+02:00
title = "Hiden complexity of OpenShift Container Platform 4.1 scrutinised from the side of the 'Application Developer'"
slug = "hiden-complexity-of-openshift-container-platform-4-1" 
tags = ["DIY", "OpenShift", "RedHat", "AWS", "Kubernetes", "Operators", "PaaS", "RedHatOPEN"]
categories = ["Development", "Product", "Learn-by-Doing"]
series = ["Learn-by-Doing"]
+++

{{< figure src="https://cdn.loncar.net/oc-nginx-demo.png" alt="Deployment Config Pods Overview" caption="Deployment Config Pods Overview" >}}

## TL;DR

Did you know that there are over **130 running pods** needed to keep the [OpenShift Platform 4.1](https://docs.openshift.com/container-platform/4.1/welcome/index.html) up and running? No. Neither did I.

### OpenShift Container Platform from Dev Corner

I've been working with OpenShift Container Platform for a while now. I've seen all the bright side of the 3.x version from the "application developer" side. As a DevOps guy, I never gave much thought about the complexity of the Platform. I am aware of the internals (Docker, Kubernetes, Registry, Router ...) and have far understanding of API Objects like BuildConfig, Pod, Service, Route, ImageStream, PersistentVolumeClaim ... For my daily work that's all nice abstracted in YAML Object Definitions. A little more structured YAML template with all the objects and parameters and that's it. As a template guru, with one blick I already see all the resources which will be created once the template will be processed. Even a few containers in [DeploymentConfig](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/deployments.html) specs didn't give me shivers. I did it all, maintain code and configuration, improve CI/CD pipeline, migrate data in a persistent volume from one cluster to another or do any other related work implementing this new technology. I've never had a chance to see the Platform from the operations side, not until recently.

### OpenShift Container Platform from Ops Corner

I've stumbled upon information that version 4.1 can be installed on [AWS](https://aws.amazon.com/). I've decided to give it a try. I've managed to deploy a cluster with the help of [Red Hat's Online Partner Enablement Network](https://www.redhat.com/en/partners/open).

{{< figure link="https://cdn.loncar.net/oc-machines-in-the-cluster.png" src="https://cdn.loncar.net/oc-machines-in-the-cluster.png" alt="All machines in the cluster" caption="All machines in the cluster" >}}

I've opened the door, got a glimpse from the other side, which gave me goose bumps. After the cluster installation, there were over 180 pods created and **133** in state **Running**.

{{< figure link="https://cdn.loncar.net/oc-133-pods-running.png" src="https://cdn.loncar.net/oc-133-pods-running.png" alt="After Cluster installation expect to see about 184 pods in total and about 133 running pods (for the 4.1.0 installer)" caption="After Cluster installation expect to see about 184 pods in total and about 133 running pods (for the 4.1.0 installer)" >}}

Once you are aware of the complexity of the technology and all it's moving parts, you are starting to realise why the customers are willing to pay to be insulated from that complexity.

Significant changes to the underlying architecture and installation process are applied in version 4.1, and many features from 3.x are now deprecated. [Operators](https://docs.openshift.com/container-platform/4.1/applications/operators/olm-what-operators-are.html) are the preferred method for creating on-cluster applications. Template Service Broker and OpenShift Ansible Broker will be deprecated.

That being said, I look forward to working with OpenShift Container Platform 4.1 in production. I believe that Red Hat and the community have done an excellent job with this release. OpenShift is one of the best PaaS on the market.

{{< figure src="https://cdn.loncar.net/oc-static-nginx.png" alt="Nginx HTTP server and reverse proxy (nginx) S2I Sample Application" caption="Nginx HTTP server and reverse proxy (nginx) S2I Sample Application" >}}
