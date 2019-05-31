+++
draft = true 
date = 2019-05-29T22:39:34+02:00
title = "Loving my new static Blog"
slug = "loving-my-new-static-blog" 
tags = ["Hugo"]
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

Everyone has its reasons and motivations for writing a blog. This is my blog, where I'll write for myself, me doing something for me. I often find myself searching for [code snippets](https://gist.github.com/loncarales) I used a weeks ago and then wasting my time and energy to find them again. Putting them someplace safe ([Snippets]({{< ref "/snippets" >}})) where I could access them anytime makes perfect sense. I don't expect that vast population will read this. It's for specific people, including me, who will find useful bits and pieces later when needed. Out there are thousands of tutorial posts and how to articles, and I'll try to distance myself for writing similar content.

Another big motivation for promoting myself is the reason I've decided to move from a permanent position to work as a freelancer. I am currently in a transition period, which will probably take a couple of months. I've realized that I am now my own business, a brand, a product and a service. In order to sell myself, I need to promote myself 😉 

For some, this comes naturally, for me ... well, it sucks. Through my posts, I am going to indicate that I've come to the solutions/ideas from the ground up, and I can do the same for my clients. They will know me, learn what I am passionate about, what I can do for them, and how it will benefit them, and why they should choose me.

There are plenty of exciting things I'm currently doing as a Software Engineer / DevOps Advocate, and I hope to share some of them on this blog.

{{< figure link="https://unsplash.com/photos/oqStl2L5oxI" src="https://s3.eu-central-1.amazonaws.com/loncar.net/clark-tibbs-367075-unsplash.jpg" alt="Photo by Clark Tibbs on Unsplash" caption="Photo by Clark Tibbs on Unsplash" >}}

## You build it, you run it

[Werner Vogels](https://en.wikipedia.org/wiki/Werner_Vogels), CTO @ Amazon, uttered this legendary [quote](https://seminar.io/2015/04/05/you-build-it-you-run-it/) back in 2006, regarding how development is done at Amazon. It laid out most impactful tech trend and core principles which we are now referring as [DevOps](https://en.wikipedia.org/wiki/DevOps).
The key principle is all about development teams operate their own product. There is no handoff to Operations. One "single" side is writing the code, testing the build, deploying the service and responding to support requests.

I've always been taking care of the operation part of all my pet projects. I've automated as much as possible of this work long before DevOps was born. That usually involved some [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) scripting and using [rsync](https://en.wikipedia.org/wiki/Rsync) for keeping local files in synchronization with those on a server. But all the services and infrastructure were still configured manually; all the patches and updates were done manually. Each of the servers was practically unique, like a [snowflake](https://martinfowler.com/bliki/SnowflakeServer.html), difficult to reproduce and even more difficult to fire up another server to support the same functions.

Times have changed. In the world of DevOps and [Cloud Computing](https://en.wikipedia.org/wiki/Cloud_computing), we thread everything as code, even our [infrastructure](https://en.wikipedia.org/wiki/Infrastructure_as_code). As a DevOps Advocate, I've used some of the tools from [DevOps toolchain](https://xebialabs.com/periodic-table-of-devops-tools/) to help me build and deploy this blog.
