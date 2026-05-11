+++
date = 2020-08-13T16:25:08+02:00
title = "Certificates, Skills or Attitude"
slug = "certificates-skills-or-attitude"
tags = ["Kubernetes", "Learning", "Learn-by-Doing", "Linux Foundation", "CKA", "OpenShift"]
categories = ["Professional Development", "Skill", "Certificates", "Learn-by-Doing"]
+++

{{< figure src="https://cdn.loncar.net/ales-loncar-certified-kubernetes-administrator-cka-certificate.png" alt="CKA Certification" caption="CKA Certification" >}}

## To cert, or not to cert, that is the question? 😉

It seems that these days the certificates are a new measurement of candidates proficiency. It is going so far that some people are gathering them like candies and masquerading as experts in all trades, which gives certs a bad name if you ask me.
I was never keen on them, and until now this race has gone by me almost unnoticed. What I like is getting hands-on experience with tools and technologies via on-line courses. I am taking classes at [Udemy](https://www.udemy.com/), [Coursera](https://www.coursera.org/), [Udacity](udacity.com), [edX](https://www.edx.org/) and have subscriptions for [LinkedIn Learning](https://www.linkedin.com/learning) and [Linux Academy](https://acloudguru.com/) (new A Cloud Guru). If there is a need to fill in the gap which I am currently missing, this is usually the way to go for me.

## What has changed

From my perspective, absolutely nothing. I still have my own opinion that hiring managers should be more focused on candidates passion, attitude and willingness to learn/teach stuff. Certificates try to validate a "proven" skill. Suppose we can prove without a cert some skill (vouchable by peers or for example by [GitHub](https://github.com/) contribution) then great. If not, a cert can also help. I've been lately in situations like described below.

* Interviewer: I see you have a hand on experience with OpenShift/Kubernetes.
* **Me**: Yes. Following 10 minutes of detailed explanation about what sort of magic I did. From production usage to playing with pet projects, the cold shower happens.
* Interviewer: What about administrating the cluster?
* **Me**: Not in production. The clusters were already available. I've been only using them from a developer application perspective.  But I've spun up a couple of clusters by myself for playing: locally, and also in the cloud - [AWS](https://aws.amazon.com/), [GCP](https://cloud.google.com/), [Scaleway](https://www.scaleway.com/).
* Interviewer: So no experience with the administration in production.
* **Me**: No
* Interviewer: Oohhh, I am sorry, we are looking for someone who knows how to administer the cluster and preferably also has a certificate.

Well, It's hard to have production experience if you don't have access as admin cluster.

## Why now

I bought Cloud Engineer Starter Pack at [Linux Foundation](https://www.linuxfoundation.org/) in January. The pack also came with a [Certified Kubernetes Administrator (CKA)](https://www.cncf.io/certification/cka/) Exam Voucher. Since I was deep into the project with my client at the time, I've put everything on hold. I completely forgot about it if I am frankly, until July, when I was suddenly without a project. We all know the story, COVID-19, budget deficits.

So suddenly beside taking care of our dog (Mike), helping homeschooling kids and preparing meals (a little preview see down) for all of us I had a bit of time to spare.

{{< figure class="img-left" link="https://cdn.loncar.net/Mike.jpg" src="https://cdn.loncar.net/Mike.jpg" alt="Mike" >}} {{< figure class="img-right" link="https://cdn.loncar.net/Burek.jpg" src="https://cdn.loncar.net/Burek.jpg" alt="Burek" >}}

{{< figure class="img-left" link="https://cdn.loncar.net/Chakalaka.jpg" src="https://cdn.loncar.net/Chakalaka.jpg" alt="Chakalaka" >}} {{< figure class="img-right" link="https://cdn.loncar.net/Sourdough+Bread.jpg" src="https://cdn.loncar.net/Sourdough+Bread.jpg" alt="Sourdough Bread" >}}

{{< figure class="img-left" link="https://cdn.loncar.net/Chicken+legs+in+the+oven.jpg" src="https://cdn.loncar.net/Chicken+legs+in+the+oven.jpg" alt="Chicken legs in the oven" >}} {{< figure class="img-right" link="https://cdn.loncar.net/foccacia.jpg" src="https://cdn.loncar.net/foccacia.jpg" alt="Focaccia" >}}

## How did I prepare/practice

With the help of [CKA Practice Exams at Linux Academy](https://acloud.guru/learn/d068441f-75b4-4fe8-a7a6-df9153f24a35) (new A Cloud Guru) and [Mock Exams at Kode Kloud](https://kodekloud.com/p/certified-kubernetes-administrator-with-practice-tests) I've got a feeling how the real exam could look like. I've skipped most of the videos and only focused on those where my knowledge was lacking. In between, I took my kids to a weekly visit to their grandparents in Slovenia and once came back, I've scheduled an exam.

You can find the examples I've been going through on [GitHub](https://github.com/loncarales/certification-practice-material/tree/master/CKA). Hopefully, I am not breaking any copyrights agreements by putting this publicly.

## Certified Kubernetes Administrator (CKA) Exam tips

I didn't do anything related to the topic on the day of the exam. Just took care of that I've got plenty of sleep before night. Once the proctor gave a go for taking the exam, I had 3 hours to complete it. The exam consisted of 24 performance-based tasks. First I've set up `kubectl` autocomplete on jump host, didn't bother with aliases. They are useless in the exam.  I've been going through tasks one by one, staying calm and ensuring than I' am in the right context. I've tried to use imperative commands as much as possible and created the definition files on the fly to be able to edit them for later usage if needed. Don't bother memorising all the resource types. You can find everything in the Kubernetes documentation. This is the one extra tab you can have opened during the exam. Everything I couldn't get directly from my head I've found in the documentation. I was finished half an hour before, and then I've done a final check. I've found out that one of the services was not reachable and had to fix the issue. I must have missed something 😂
**The results of the score: 93**

{{< figure src="https://cdn.loncar.net/Exam+Preparation+Checklist.png" alt="Exam Preparation Checklist" caption="Exam Preparation Checklist" >}}

## My two cents (my 2¢)

I've already had quite a lot of hand-on practice with [K8s](https://kubernetes.io/) and [OpenShift](https://www.openshift.com/) from the developer perspective. What I can tell from my own experience, is that while studying for the exam, I filled in gaps in my experience knowledge that companies/projects I had worked for in the past did not need for me to do it. Studying for cert can give you a broader understanding of what the platform does even if you have worked on it for quite some time.

## What's next

I've already spent quite some time preparing for the exam. Based on the fact that I am a developer in my heart, I will schedule for [Certified Kubernetes Application Developer (CKAD)](https://www.cncf.io/certification/ckad/) in September. Now I'll take a little time off with my family.

And remember certs or no I agree with late [Herb Kelleher](https://en.wikipedia.org/wiki/Herb_Kelleher) quote:
> You don't hire for skills; you hire for attitude. You can always teach skills.
