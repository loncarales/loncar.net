+++
date = "2019-03-10"
title = "How to easily extract PKCS7 DER-encoded certificates"
slug = "how-to-easily-extract-certificates-from-p7b"
tags = ["CI/CD", "DevOps", "OpenShift"]
categories = ["Development", "DevOps"]
+++

Recently I've got a task to prepare templates for deploying a couple of applications on Red Hat [OpenShift](https://www.openshift.com/) cluster.  I would not go into details about OpenShift resources, but anyone familiar with [Kubernetes (K8s)](https://kubernetes.io/) knows that services are by default visible and exposed only inside the Openshift (K8s) cluster, not outside it. To expose the service to outside, we create a new entity called route associated with a service. Routes are resources specific to OpenShift and not found in K8s. Think of route as a mapping between your service and a domain name. The route default format is: `https://app-name.project-name.cluster-domain`

## Route Types

Routes can be either secured or unsecured. Secure routes provide the ability to use several types of [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) termination to serve certificates to the client. Routers support edge, passthrough, and re-encryption termination.

Our applications are using [**Edge Termination**](https://docs.openshift.com/container-platform/3.6/architecture/networking/routes.html#secured-routes). With edge termination, TLS termination occurs at the router, before proxying traffic to its destination. The front end of the router serves TLS certificates, so they must be configured into the route; otherwise, the router's default certificate will be used for TLS termination.

For a secured route using edge termination, we need:

* The private key for the route in PEM format
* Certificate for the route in PEM format
* CA certificate chain for the route validation in PEM format

The client provided me with private keys and certificates. The private keys were already in [PEM](https://en.wikipedia.org/wiki/X.509#Certificate_filename_extensions) format, but the certificates were PKCS7 DER-encoded. P7B certificates are Base64 encoded ASCII files and are only supported on Windows OS, [Apache Tomcat](https://tomcat.apache.org/), so we need to convert P7B to PEM format.

Take a look at the following snippet: [Extract all certificate chain from DER-encoded .p7b file]({{< ref "extract-certificates-from-p7b.md" >}})

> And remember, contributions earn you karma. 😜
