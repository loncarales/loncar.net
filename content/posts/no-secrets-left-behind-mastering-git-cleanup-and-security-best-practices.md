+++
date = 2024-03-15T06:25:08+02:00
title = "No Secrets Left Behind: Mastering Git Cleanup and Security Best Practices"
slug = "no-secrets-left-behind-mastering-git-cleanup-and-security-best-practices"
tags = ["Git Security", "Code Hygiene", "Secret Management", "Repository Cleanup", "Preventive Measures", "Developer Tools", "Data Privacy", "DevOps Best Practices"]
categories = ["Cybersecurity", "Software Development", "DevOps", "IT Compliance", "Version Control"]
+++

{{< figure src="https://cdn.loncar.net/no-secrets-left-behind-mastering-git-cleanup-and-security-best-practices.png" alt="No Secrets Left Behind: Mastering Git Cleanup and Security Best Practices" >}}

As a seasoned developer, I may be scratching my head, wondering why anyone may put secrets inside a git repository. **But the fact is, secrets inside git repositories are the current state of the world.**

## 🔄 TL;DR

* Secrets inside git repositories are prevalent, even in private repositories.
* Git keeps track of all changes made, meaning that removed code still exists in the git history, and secrets could be buried deep within it.
* There are two scenarios: accidentally pushing sensitive data to Git and needing to remove sensitive content from Git history.
* Secret scanning tools like GitGuardian, TruffleHog, and Gitleaks can help identify potential vulnerabilities.
* Tools like git-filter-repo and BFG Repo-Cleaner can help purge files or sensitive content from repository history.
* After cleanup, it's essential to communicate with your team and review CI/CD pipelines to ensure the integrity and security of the repository.

## The Prevalence of Secrets in Git Repositories

I've recently stumbled upon the fact regarding the public Git repositories. - Every 5 commits out of 1000 exposes at least one secret. 😮
It's a known "secret" that most personal public leaks belong to companies and are "accidentally" pushed to developers' personal repos.

## The Challenge with Private Repositories

I can tell what surprised me more: this previous statement or the recent encounter with one of the seniors/lead team members pushing secret data from the project's initial start to a private repo. When confronted, the response was: It is a private repo, and we will change that later. Both of these statements left me speechless.

## The Git Nature of Code Duplication

Source code repositories are meant to be shared with teammates, within the company, or the entire world (as is the case for open-source software). Code is copied and transferred everywhere. Git is designed to allow, even promote, code to be freely distributed. Projects can be cloned onto multiple machines, forked into new projects, distributed to customers, made public, and so forth. **Each time a project is duplicated on Git, the entire history of that project is also duplicated.** Private repositories don't openly publish the source code to the Internet, but they don't have adequate protection to store such sensitive information.

## The Challenge with Git History

Another important consideration is that **code removed from a git repository is never actually gone.** Git keeps track of all changes that are made. Code that is removed - or, more technically correct, code that is committed over - still exists within the git history. This means that the code within repositories is much deeper than the first layer, and secrets could be buried deep within the git history under a mass of commits that have been long forgotten.

## Scenarios and Solutions

**"We all make mistakes"** is one of my mantras as a developer. It shouldn't be an excuse, but it can be an opportunity to grow. I have been on both sides of the fence — unintentionally adding the wrong content and was also a part of the "cleanup" squad. As such, I would like to share how you can scrub this content from your Git repositories thoroughly.

Typically, we have two scenarios.
1. Someone accidentally pushed sensitive data to Git.
   * You should consider any sensitive data compromised in the commit. If you have committed a password, you should change it. If you have committed a key, generate a new one. Removing the compromised data doesn't resolve its initial exposure.
   * You must purge a file from Git history or remove sensitive content in plain text from Git history.
2. As a dedicated security person, you must find and fix hardcoded secrets in the software supply chain with a secret scanner for git repositories, files, and directories.

## Tools to Safeguard Against Accidental Exposure of Sensitive Information

Both scenarios, in reality, are bringing to light the pressing need for tools and practices that can help developers safeguard their code against accidental exposure of sensitive information. Enter the realm of secret scanning tools like [GitGuardian](https://www.gitguardian.com/), [TruffleHog](https://trufflesecurity.com/trufflehog), and [Gitleaks](https://gitleaks.io/). These powerful allies in the fight against security breaches operate by scanning your repositories for known patterns that resemble secrets, such as API keys, passwords, and tokens. Whether it's a piece of code or an infrastructure-as-code configuration, these tools diligently sift through every line to identify potential vulnerabilities before they can be exploited.

## Rewriting Git history

However, identifying secrets is only half the battle. What happens when sensitive data makes its way into your Git history? This is where tools like [git-filter-repo](https://github.com/newren/git-filter-repo) and [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) come into play, offering a lifeline for developers looking to rewrite history—literally. These tools allow you to purge files or sensitive content from your repository's history, effectively erasing any trace of the data you never intended to commit. This process, known as history rewriting, is a crucial step in mitigating the damage caused by accidental exposure and ensuring that your secrets don't become public knowledge.

After the arduous task of scrubbing your Git history clean of any sensitive data, it's tempting to think the job is done. However, this cleanup is just the beginning of a series of critical steps required to ensure the integrity and security of your repository moving forward, especially when collaborating on platforms like [Bitbucket](https://bitbucket.org/) or [GitHub](https://github.com/).

## Post-Cleanup Actions

* **Communicate with Your Team:** Informing your collaborators about the cleanup is essential. Advise them to rebase their branches instead of merging them. Merging could inadvertently reintroduce the data you've worked hard to expunge from the repository's history.
* **Review CI/CD Pipelines:** This is a critical step that is often overlooked. Your CI/CD pipelines might have cached versions of your repository or use environment variables and secrets that were part of the compromised history. Review and reset these configurations to ensure they do not use or reintroduce the old, sensitive data.
* **Garbage Collection:** After a prudent period, and once you're confident there are no unintended consequences from the cleanup, enforce a garbage collection on every local repository. This step ensures that all dereferenced objects are permanently removed, further tightening your repo's security.

## Preventing Future Leaks

The best defence against sensitive data exposure is a good offence. Implementing strategies to prevent accidental commits of sensitive information is crucial.

* **Opt for Visual Tools:** Tools like [Sourcetree](https://www.sourcetreeapp.com/) provide a graphical interface for managing your commits, making it easier to see exactly what you're about to push to the repository. This visibility can help avoid unintentional commits of sensitive data.
* **Be Mindful with Git Commands:** Avoid broad-stroke commands like `git add .` or `git commit -a` that stage or commit all changes without discrimination. Instead, take a more granular approach by using `git add <filename>` and `git rm <filename>` to stage files individually, reducing the risk of including unwanted files in your commit.
* **Implement Pre-commit Hooks:** Pre-commit hooks are scripts that run before each commit, acting as a final checkpoint to catch any sensitive data before it becomes part of the commit. You can customize these scripts to scan for patterns indicative of secrets, such as API keys or passwords, preventing their accidental inclusion.

## Conclusion

The journey through cleansing Git repositories and securing CI/CD pipelines underscores a broader theme in software development: the paramount importance of vigilance and proactive security measures. The lessons learned extend beyond the technical nuances of Git history rewriting tools on fundamental principles every developer should internalize: **Never store sensitive data in Git with the old but gold; never trust the user input blindly.**
