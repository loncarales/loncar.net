+++ 
date = 2019-06-13T22:34:47+02:00
title = "The Challenge: Create a minimalistic environment on Kuberntes to run a small Web application"
slug = "the-challenge-minimalistic-environment-on-kubernetes" 
tags = ["DIY", "Kubernetes", "Docker", "Helm", "GitLab CI/CD", "Jenkins", "Perl"]
categories = ["Development", "Product", "Learn-by-Doing"]
series = ["Learn-by-Doing"]
+++

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/continuous-improvement-is-better-than-delayed-perfection.jpg" alt="Continuous improvement is better than delayed perfection. - Mark Twain" caption="Continuous improvement is better than delayed perfection. - Mark Twain" >}}

## Fun Challange

### Prologue

A while ago, I stumbled upon an exciting challenge. The final goal is to create a minimalistic environment on [Kubernetes (K8s)](https://kubernetes.io/) for running a small Web application of our choice.

### Requirements

For a task not to be so simple, there are some requirements:

* All resources must be defined in a code.
* Application must not use containers from [Docker Hub](https://hub.docker.com/).
* Use  a programming language of your choice.
* Docker HUB containers are allowed for "infrastructure" parts like databases, cache, proxies.
* Solutions should be as simple as possible while applying best practices whenever see a fit for it.

### Toolchain

Use at least these tools from DevOps toolchain to provision your Web application:

* [Minikube](https://github.com/kubernetes/minikube) (local Kubernetes cluster) for container management
* Application Docker image created from [Dockerfile](https://docs.docker.com/engine/reference/builder/)
* [Kubernetes YAML](https://kubeyaml.com/) files or [Helm](https://helm.sh/) Chart
* CI/CD: [GitLab CI/CD](https://docs.gitlab.com/ee/ci/) or [Jenkins](https://jenkins.io/) pipeline

### Deliverables

* Use a public Git repository containing all the resources previously mentioned
* Put up a nice-looking and helpful README file. It should include sections for summary/introduction, installation, usage, dependencies, and whatever else would want for other people to read.
* Write a simple Analysis. Break down into sections what could be improved: deployment, scaling, security etc.

### The Hurdle

The most challenging for me was to come up with some appropriate application. There are numerous tutorials out there how to run [PHP](https://www.php.net/) ([Wordpress](https://wordpress.com/)), [Python](https://www.python.org/) ([Flask](http://flask.pocoo.org/)) or [Ruby](https://www.ruby-lang.org/en/) ([Spina](https://www.spinacms.com/))  application inside the Kubernetes cluster. I wanted to do something more uniquely. What is the better place to look for an example application than in a library where are hosted millions of repositories? Of course, I am talking about [GitHub](https://github.com/). I had to dig up a project which is not yet containerised.  Easier said than done. All popular and newest projects already have instructions on how to containerise them (running in Docker). I had to extend my search a little. 

I've found a simple [**blog example**](https://github.com/mojolicious/mojo-pg/tree/master/examples/blog) written in [Perl](https://www.perl.org/), which uses [PostgreSQL](https://www.postgresql.org/) for storing persistent data.

{{< figure link="https://s3.eu-central-1.amazonaws.com/loncar.net/mojo-pg-blog.png" src="https://s3.eu-central-1.amazonaws.com/loncar.net/mojo-pg-blog.png" alt="Using a Port Forwarding to access Mojo::Pg example blog application running in local Kubernetes cluster" caption="Using a Port Forwarding to access Mojo::Pg example blog application running in local Kubernetes cluster" >}}

### Mojo::Pg

[Mojo::Pg](https://github.com/mojolicious/mojo-pg) is a tiny wrapper around [DBD::Pg](https://metacpan.org/pod/DBD::Pg) that makes PostgreSQL a lot of fun to use with the [Mojolicous](https://mojolicious.org/) real-time web framework. I've tackled the challenge by "Dockerising" this simple but non-trivial Perl application and adding all dependencies for running the app inside Kubernetes cluster.

{{< figure link="https://s3.eu-central-1.amazonaws.com/loncar.net/mojo-pg-postgresql.png" src="https://s3.eu-central-1.amazonaws.com/loncar.net/mojo-pg-postgresql.png" alt="Using a Port Forwarding to access a PostgreSQL database on Kubernetes with DBeaver (database tool)" caption="Using a Port Forwarding to access a PostgreSQL database on Kubernetes with DBeaver (database tool)" >}}

### A little history of Perl

Perl gained widespread popularity in the late 1990s as a [CGI](https://en.wikipedia.org/wiki/Common_Gateway_Interface) scripting language. It also came very handily in cases where unique [regular expression](https://en.wikipedia.org/wiki/Regular_expression) and string [parsing](https://en.wikipedia.org/wiki/Parsing) abilities were needed. Later it lost the battle against PHP. It was more comfortable and convenient to copy the entire application to web space as every hosting provider had PHP already set up for you. Perl was not embedded in the web server so it couldn't compete.
Perl evolved into much more flexible and rich language. In my opinion, this flexibility referred to as [TMTOWTDI](https://en.wikipedia.org/wiki/There%27s_more_than_one_way_to_do_it) is the main reason most programmers find it annoying to learn. Perl is one of the most hated programming languages according to [Stack Overflow](https://stackoverflow.com/), anyway.  But still, Perl work in a lot of projects. 

As long Perl will come installed by [default](https://www.archlinux.org/groups/x86_64/base/) by most of Linux distributions, and it will be used in the process of building the [Linux Kernel](https://www.kernel.org/doc/html/v4.10/process/changes.html) it will stay in our lives. 😉

### Why Perl

In the world of programming, the mainstream is broad. [Enterprise software](https://en.wikipedia.org/wiki/Enterprise_software) is written predominantly in one of a few major languages. For some, this means [Java](https://www.java.com/en/), for others, is Python or [Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript). Perl is not in this list, not is a trendy programming language. Choosing it for the challenge was me pointing out that "containerising" Perl web applications do not differ as putting into container any other app from your favourite scripting language like Python, JavaScript (Node.js), PHP.

### Getting the hands dirty

I've forked the project and added the missing pieces. I didn't change the functionality of the application. You can find everything on [**GitHub**](https://github.com/loncarales/mojo-pg/tree/master/examples/blog) and on [**GitLab**](https://gitlab.com/loncarales/mojo-blog).

### Epilogue

Each and every one of us is unique. Each of us also has it's own learning style. Some learn by hearing and listening, others by reading or seeing pictures, and there are ones who learn by doing, and we are all unstoppable. In my case, the way to learn something is to do it. If I want to learn how to cook a family ragu, I'll have a go at doing it. Online learning is becoming more and more popular. [MOOCs](https://en.wikipedia.org/wiki/Massive_open_online_course) - Massive Open Online Courses are picking up momentum. I use them to get me a better understanding of the topic, so after I can get my hands dirty with actually doing the stuff.

> Whatever is your way of learning, remember **"Progress. Not Perfection"**

### Excerpt

* Dockerfile 
  * Try to follow [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/). For me, the most important rule is to never run process inside a container as a privileged user if a service can run without root privileges! In our application, this is the USER  `app`. RedHat OpenShift [S2I](https://docs.openshift.com/container-platform/3.9/creating_images/s2i.html) builder images are using USER `1001`
* docker-compose.yml
  * It is just used for testing the multi-container Docker applications locally.
* README.md
  * The file contains a few information about the application.
* ANALYST.md
  * The file has some ideas on how to improve the deployment, for simplicity, the app is missing some production-ready features, but they could be easily added.
* Jenkinsfile
  * Declarative Jenkins pipeline without deployment stage. It's an ideal solution for the simple continuous delivery pipeline as it has very limited and pre-defined structure.
* gitlab-ci.yml
  * Simple GitLab CI/CD pipeline without deployment stage. It can be seen in action in [**Pipelines**](https://gitlab.com/loncarales/mojo-blog/pipelines) page.

<script src="https://embed.cacher.io/d8073b880d36ab13adae10975c241cf32908ab42.js?a=c6ebf525c6364246a2fcb0375ab1f222"></script>
