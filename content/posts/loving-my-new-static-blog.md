+++
date = 2019-05-29T22:39:34+02:00
title = "Loving my new static Blog"
slug = "loving-my-new-static-blog" 
tags = ["Hugo", "GitHub", "Scaleway", "Packer", "Debian", "Go", "Terraform", "Ansible", "Nginx", "Certbot", "Let's Encrypt", "CloudFlare"]
categories = ["Development", "Product"]
+++

## Static websites are coming back, just like vinyl LPs.

I've been lately playing with [Hugo](https://gohugo.io/), popular open-source [static site generator](https://www.staticgen.com/). With its incredible speed and flexibility, Hugo makes building websites fun again. The tools like Hugo or [Jekyll](https://jekyllrb.com/) build HTML files for serving directly, rather than dynamically generating them on-demand using your popular [server-side](https://en.wikipedia.org/wiki/Server-side_scripting) programming language. Static blog engines have high performance, and since the pages are static, they will cache easily.

This is not my first blog. I was self-employed back in Slovenia from 2009 to 2013, and during that era, I was actively writing two blogs. One in English and one in Slovenian language. Both of them can now only be seen on [Wayback Machine](https://web.archive.org/).

###### Captured snapshot of www.celavi.org

{{< figure link="https://web.archive.org/web/20130524070830/http://www.celavi.org/2009/07/06/how-to-add-plural-support-to-gettext-adapter-in-zend-framework" src="https://s3.eu-central-1.amazonaws.com/loncar.net/celavi-blog.png" alt="Captured snapshot of my old English blog by Wayback Machine." caption="Captured snapshot of my old English blog by Wayback Machine." >}}

###### Captured snapshot of www.internet-solutions.si

{{< figure link="https://web.archive.org/web/20130630085541/http://www.internet-solutions.si/2010/09/03/prestashop-brezplacen-facebook-like-box-block-modul" src="https://s3.eu-central-1.amazonaws.com/loncar.net/internet-solutions.png" alt="Captured snapshot of my old Slovenian blog by Wayback Machine." caption="Captured snapshot of my old Slovenian blog by Wayback Machine." >}}

## Bringing back my motivation for blogging

Everyone has its reasons and motivations for writing a blog. This is my blog, where I'll write for myself, me doing something for me. I often find myself searching for [code snippets](https://gist.github.com/loncarales) I used in the past and then wasting my time and energy to find them again. Putting them someplace safe ([Snippets]({{< ref "/snippets" >}})) where I could access them anytime makes perfect sense. I don't expect that vast population will read this. It's for specific people, including me, who will find useful bits and pieces later when needed. Out there are thousands of tutorial posts and how to articles, and I'll try to distance myself for writing similar content.

Another big motivation for promoting myself is the reason I've decided to move from a permanent position to work as a freelancer. I am currently in a transition period, which will probably take a couple of months. I've realized that I am now my own business, a brand, a product and a service. In order to sell myself, I need to promote myself 😉 

For some, this comes naturally, for me ... well, it sucks. Through my posts, I am going to indicate that I've come to the solutions/ideas from the ground up, and I can do the same for my clients. They will know me, learn what I am passionate about, what I can do for them, and how it will benefit them, and why they should choose me.

There are plenty of exciting things I'm currently doing as a Software Engineer / DevOps Advocate, and I hope to share some of them on this blog.

{{< figure link="https://unsplash.com/photos/oqStl2L5oxI" src="https://s3.eu-central-1.amazonaws.com/loncar.net/clark-tibbs-367075-unsplash.jpg" alt="Photo by Clark Tibbs on Unsplash" caption="Photo by Clark Tibbs on Unsplash" >}}

## You build it, you run it

[Werner Vogels](https://en.wikipedia.org/wiki/Werner_Vogels), CTO @ Amazon, uttered this legendary [quote](https://seminar.io/2015/04/05/you-build-it-you-run-it/) back in 2006, regarding how development is done at Amazon. It laid out most impactful tech trend and core principles which we are now referring as [DevOps](https://en.wikipedia.org/wiki/DevOps).
The key principle is all about development teams operate their own product. There is no handoff to Operations. One "single" side is writing the code, testing the build, deploying the service and responding to support requests.

I've always been taking care of the operation part of all my pet projects. I've automated as much as possible of this work long before DevOps was born. That usually involved some [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) scripting and using [rsync](https://en.wikipedia.org/wiki/Rsync) for keeping local files in synchronization with those on a server. But all the services and infrastructure were still configured manually; all the patches and updates were done manually. Each of the servers was practically unique, like a [snowflake](https://martinfowler.com/bliki/SnowflakeServer.html), difficult to reproduce and even more difficult to fire up another server to support the same functions.

Times have changed. In the world of DevOps and [Cloud Computing](https://en.wikipedia.org/wiki/Cloud_computing), we thread everything as code, even our [infrastructure](https://en.wikipedia.org/wiki/Infrastructure_as_code). As a DevOps Advocate, I've used some of the tools from [DevOps toolchain](https://xebialabs.com/periodic-table-of-devops-tools/) to help me build and deploy this blog.

## Tools of trade

The most trivial way to host a static website would probably be to use the [Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html) bucket. It's quite straightforward to create and configure Amazon S3 buckets for website hosting and to upload your website content. That would be too easy 😉 I love learning by doing it, which gives me a better understanding of what it means to do the activity. It also gets me a deeper understanding of the tools and API's. Learning by doing also promotes critical thinking.

Here are the tools I've used for this blog:

### [Hugo](https://gohugo.io/)

> The world’s fastest framework for building websites.

* Using it to draft posts and test site locally with `hugo serve`

### [GitHub](https://github.com/)

* It contains all source code including infrastructure without generated files. You should never store **secrets** or **credentials** here.

### [Scaleway](https://www.scaleway.com/en/)

> Scalable Cloud Platform designed for Developers. I would not recommend using Scaleway for anything serious. But low prices, unmetered bandwidth, SSD volumes makes it perfect for the developer's playground.

* Utilizing Compute services to spin up Linux instances in the Cloud

### [Packer](https://www.packer.io/)

> Packer is perfect for creating immutable and identical machine images for multiple platforms from a single source configuration file. 

* Using it for building virtual-machine images for later deployment on Scaleway
* My base image is [Debian](https://www.debian.org/) Stretch, and on top of it I've:
  * removed root access and added a limited user account
  * installed all required packages
  * secure the server
  * automated security updates
  * harden SSH access
  * utilize Fail2Ban for SSH login protection

### [Terraform](https://www.terraform.io/)

> Infrastructure as a code software tool which enables provisioning and adapting virtual infrastructure across all major cloud providers.

* Terraform is my favourite infrastructure orchestrator, besides that is cloud-agnostic and it is written in [Go]({{< ref "yearly-recap-2017.md" >}}). It's maintaining the state of your infrastructure using a concept called state files.
* Using it to create immutable infrastructure on Scaleway


### [Ansible](https://docs.ansible.com/)

> Software for provisioning, configuration management, and application-deployment.

* I love Ansible. It's agent-less configuration management, provisioning as well as an orchestration tool. Configuration modules called a ["Playbooks"](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) are written in readable [YAML](https://yaml.org/) format, and it is relatively easy to write when compared to other configuration management tools. Definitely number one tool when building automated tasks to ensure [idempotency](https://en.wikipedia.org/wiki/Idempotence) and battle against [Configuration Drift](http://kief.com/configuration-drift.html).

### [Nginx](https://nginx.org/)

* Using it for serving static content, minimal features need, just as fast as possible.

### [Certbot](https://certbot.eff.org/)

> Automatically enable HTTPS on your website with EFF's Certbot, deploying Let's Encrypt certificates.

* Using it to obtain a wildcard certificate from [Let's Encrypt](https://letsencrypt.org/). 
* For obtaining the certificate on a machine other than a target web server, we can use one of Certbot's DNS plugins. 
* [CloudFlare](https://www.cloudflare.com/) manages my domain DNS records. Cloudflare DNS plugin for Certbot automates the process of completing a dns-01 challenge(DNS01) by creating and subsequently removing, TXT records using the Cloudflare API.

#### You can find the complete source code of my [blog](https://github.com/loncarales/loncar.net) on GitHub.

## Configuration files

Currently, all sensitive information, such as API tokens, API access keys, passwords, server IP addresses, ... are stored in `-dist` files and are not containing the actual values. For all scripts to working correctly, we need first to copy the `-dist` files to right config files and add the exact parameters.

Example for `.envrc`

```bash
$ cd iac
$ cp .envrc-dist .envrc
```

## Installing

A step by step series of examples that tell you how to get everything up and running

### Build Debian Base image

```bash
$ cd iac
$ ./build.sh
```

### Deploy infrastructure with Terraform

```bash
$ cd iac
$ terraform init
$ terraform plan -out plan.out
$ terraform apply plan.out
```

### Provision software and configuration with Ansible

```bash
$ cd iac/ansible
$ # Let's use ping module to check if our machine is up and running
$ ansible hugo -i hosts.ini -u deploy --private-key ../pki/id_rsa_deploy -m ping
$ # install requirements
$ ansible-galaxy install -r requirements.yml
$ # provision machine
$ ansible-playbook -u deploy -i hosts.ini --private-key ../pki/id_rsa_deploy provision-hugo.yml
```

Once the infrastructure is created and all software installed and configured, we can generate and deploy new content with the following command.

### Generate static content and deploy it to the web server
```bash
cd iac/ansible
$ ansible-playbook -u deploy -i hosts.ini --private-key ../pki/id_rsa_deploy deploy-content.yml
```

{{< figure link="https://s3.eu-central-1.amazonaws.com/loncar.net/time-ansible-deploy.png" src="https://s3.eu-central-1.amazonaws.com/loncar.net/time-ansible-deploy.png" alt="The new content is generated, deployed and ready to serve in less than 15 seconds." caption="The new content is generated, deployed and ready to serve in less than 15 seconds." >}}

## Analysis

> Some thoughts about how to improve the blog deployment process

### Handling sensitive data

Currently, confidential information is stored in plain text as placeholder values. The better way to do this is to use a tool for securely managing secrets and encryption, for example, [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html), [Vault by HashiCorp](https://www.vaultproject.io/), [Chamber](https://github.com/segmentio/chamber) and similar.

### CI/CD Pipeline

Setting up a streamlined pipeline with CI/CD tool like [Jenkins](https://jenkins.io/) or [Travis CI](https://travis-ci.org/) should be like a walk in a park.

### Rotate tokens and secrets periodically

All API tokens, secrets, credentials, SSH keys ... should be regularly rotated. Ansible playbook can be easily extended to switch SSH key with a new one.

### Service monitoring

We need to monitor every dimension of the service that we are using. First one in the list should be the monitoring of SSL certificate expiration. Next thing on the list is infrastructure & application monitoring. The [Sensu](https://docs.sensu.io/) is an open source solution that monitors cloud infrastructure simply and efficiently.

## You did it!

Congratulations!!! I am now a  proud owner of a new blog. Let's start playing!

> Are you still manually deploying your code or opening tickets for your Operations team and throwing them artefacts over the wall of confusion? Let's meet for Coffee. ☕ We'll discuss how you can transform your current software principles to be more DevOps friendly across your entire organization.

> And remember, contributions earn you karma. 😜
