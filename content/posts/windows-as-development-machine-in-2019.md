+++
date = "2019-05-15"
title = "Windows as Development Machine in 2019"
slug = "windows-as-development-machine-in-2019"
tags = ["Microsoft", "Windows 10", "WSL", "Linux", "VirtualBox", "Agile", "DevOps", "Scoop", "Chocolatey", "Ansible"]
categories = ["Development", "DevOps"]
+++

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/the_good_the_bad_and_the_ugly.png" alt="The Good, The Bad and The Ugly" caption="The Good, The Bad and The Ugly" >}}

## The Bad and the Ugly

Windows in the past were `marked` as the bad and the ugly from the development community. One particular reason stood out from the crowd. There was no reliable [package manager](https://en.wikipedia.org/wiki/Package_manager) available like there are ones on Linux. We developers are lazy. We would rather spend a day developing some automation task rather than spend a day of manual work required.
It was also harder, and it took longer to install programming tools and languages on Windows, when compared to Linux simple running `apt|yum|pacman` install command. So the Linux was the most reasonable option for many of us.

I am a big Linux fan. I've been using Linux for many years. I actually can't recall when it was the first time I've installed it. What I can tell for sure It was a [Slackware](http://www.slackware.com/) distribution which fit on a few floppy disks.  Over the years I've tried all sorts of setups - everything ranging from dual-booting Linux to using a [VirtualBox](https://www.virtualbox.org/) based Linux VM. The main reason for me sticking with Linux as a development machine was an inconsistent behaviour of PHP 4.X running on Windows systems back in the days. Developers who would do PHP development at that time on Windows would later fight with the inevitable battle to adjust the code base which will run seamlessly on Linux servers. 
Since years I've been avoiding Windows as much as I could for professional use, but lately, I am more and more fond of it. 

## The Good

[Microsoft](https://www.microsoft.com/), as a company has also evolved through time. Microsoft is one of the biggest contributors to open source project on GitHub (platform now owned by Microsoft). But if you look at their projects, you'll notice that almost all of Microsoft's open source products are aimed at programmers and software developers. They are using modern engineering practices. They've been embracing the [Agile Software Development](https://agilemanifesto.org/) principles for years, and they've moved from Agile to DevOps. If I would need to describe what [DevOps](https://en.wikipedia.org/wiki/DevOps) is in one sentence this would much say it:

> DevOps is a set of practices intended to reduce the time between committing a change to a system and the change being placed into normal production while ensuring high quality.

As an example, the [Visual Studio Code](https://code.visualstudio.com/updates/v1_32) got three updates in February 2019.

{{< tweet 993546257988833280 >}}

## Why Windows now, why don't you code on Linux?

I am working with clients who are either Microsoft clients or Solution Partners. I am working daily with the tools like: [Skype for Business](https://www.skype.com/en/business/), [Office 365](https://www.office.com/), [OneDrive for Business](https://onedrive.live.com/about/de-de/business/), [Windows 10](https://www.microsoft.com/en-us/windows). It makes my daily work more accessible if I use the same operating system, and besides that, Windows 10 is one of the most flexible and robust development platforms ever given. The state of developing software on Windows 10 in 2019 is quite impressive.

{{< figure link="https://unsplash.com/photos/LwXKs2XvJVY" src="https://s3.eu-central-1.amazonaws.com/loncar.net/tinh-khuong-1316024-unsplash.jpg" alt="Photo by Tinh Khuong on Unsplash" caption="Photo by Tinh Khuong on Unsplash" >}}


## The current state of Developing on Windows

### Installing software

We can choose from various tools which help us to manage software on Windows. [Chocolatey](https://chocolatey.org/), [Ninite](https://ninite.com/), [CoApp](http://coapp.org/), [Scoop](https://scoop.sh/) are all projects which are aiming to create a vibrant Open Source ecosystem on Windows needed to build a complete community-driven Package Management System.

I use Scoop with the combination of Chocolatey where there is no bucket available in Scoop. Scoop isn't a package manager. Instead, it reads plain JSON manifests that describe how to install a program and its dependencies via command-line. It installs to `~/scoop/` by default. It comes very handily when we don't have admin rights, for example, when utilising User Desktop inside a virtual machine like [VDI](https://www.citrix.com/glossary/vdi.html).

{{< figure link="https://s3.eu-central-1.amazonaws.com/loncar.net/scoop.png" src="https://s3.eu-central-1.amazonaws.com/loncar.net/scoop.png" alt="Scoop: Installed apps" caption="Scoop: Installed apps" >}}

### Running Linux Software

As a Windows user, I would like to run Linux software without leaving the Windows environment. In the past, I had to use [Virtual Machines](https://en.wikipedia.org/wiki/Virtual_machine) or [Cygwin](https://www.cygwin.com/) but with the Windows 10 version 1607 and later we can install compatibility layer for running Linux binary executables natively using [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about). There is also software which won't run on Windows natively, so we need a Unix-like environment. One of such tools is [Ansible](https://www.ansible.com/), an open-source software provisioning, configuration management, and application deployment tool. Ansible will only run on Unix-like systems (Linux, Unix, BSD, Cygwin and WSL) but can configure both Unix-like systems as well as Microsoft Windows. If you're planning to use Ansible on Windows, I would recommend installing it using Windows Subsystem for Linux (WSL).

{{< figure link="https://s3.eu-central-1.amazonaws.com/loncar.net/ansible-inside-wsl.png" src="https://s3.eu-central-1.amazonaws.com/loncar.net/ansible-inside-wsl.png" alt="Using Ansible through Windows 10's Subsystem for Linux" caption="Using Ansible through Windows 10's Subsystem for Linux" >}}

### The Future

WSL (Windows Subsystem for Linux) is a Linux kernel compatibility layer for Windows. It allows many Linux programs (mainly the command line ones) to run inside Windows. Microsoft has recently announced that they will bring the newest architecture for the Windows Subsystem for Linux: [WSL 2](https://devblogs.microsoft.com/commandline/announcing-wsl-2/). 

Changes in this new architecture will allow for: 

* dramatic file system performance increases.
* full system call compatibility, meaning we can run more Linux apps in WSL 2 such as [Docker](https://www.docker.com/). 
  
In WSL 2, the **Linux kernel compatibility layer has been replaced by the real Linux kernel**. So now if you would use WSL, you'll be using the actual Linux kernel 4.9. 


{{< figure src="https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2019/05/runwsl.gif" alt="Demo of WSL 2 in action" caption="Demo of WSL 2 in action" >}}

###### Microsoft loves Linux. Microsoft loves Open Source. What the future will bring ... we'll see. 😉
