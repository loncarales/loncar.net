+++
date = "2019-03-25"
title = "Resolve Git merge conflicts the unpainful way"
slug = "resolve-git-merge-conflicts"
tags = ["Git", "P4Merge"]
categories = ["Development"]
+++

## What is a Git Merge Conflict?

A merge conflict is an event that occurs when Git is unable to automatically resolve differences in code between two commits. However, when there are different changes on the same lines, a “merge conflict” occurs because Git doesn’t know which code to keep and which to discard.

Merge conflicts can be painful and are traditionally cause developers a lot of grief, especially when working in the terminal. There are various Visual merge conflict tools which help users identify where the conflict is occurring and how to resolve it. An excellent visual merge tool will display at least three panels for each file with conflicts. There will be a panel showing the version of that file:

* In local branch
* In the remote branch
* As it will appear after merging

There are also tools which also include a fourth display panel showing the version of that file in the merge base. Such a tool is [Helix Visual Merge Tool (P4Merge)](https://www.perforce.com/downloads/visual-merge-tool).


{{< figure link="https://s3.eu-central-1.amazonaws.com/loncar.net/Perforce+P4Merge.png" src="https://s3.eu-central-1.amazonaws.com/loncar.net/Perforce+P4Merge.png" alt="P4Merge as a four-pane merge tool" caption="P4Merge as a four-pane merge tool" >}}

P4Merge show you these panes:

* LOCAL – your file with the changes you’ve made to it
* BASE – the common ancestor file that LOCAL and REMOTE came from
* REMOTE – the file you’re merging in, possibly authored by someone else
* MERGE_RESULT – the file resulting from the merge where you resolve conflicts

## Git commands that can help resolve merge conflicts

### General tools

```bash
git status
```
> The status command is in frequent use when a working with Git and during a merge it will help identify conflicted files.

```bash
git log --merge
```
> Passing the `--merge` argument to the git log command will produce a log with a list of commits that conflict between the merging branches.

```bash
git diff
```
> `diff` helps find differences between states of a repository/files. This is useful in predicting and preventing merge conflicts

### Tools for when git fails to start a merge

```bash
git checkout
```
> `checkout` can be used for undoing changes to files, or for changing branches

```bash
git reset --mixed
```
> `reset` can be used to undo changes to the working directory and staging area.

### Tools for when git conflicts arise during a merge

```bash
git merge --abort
```

> Executing git merge with the `--abort` option will exit from the merge process and return the branch to the state before the merge began.

```bash
git reset
```

> Git `reset` can be used during a merge conflict to reset conflicted files to a know good state

## Example: Creating a merge conflict

<script src="https://embed.cacher.io/d4566a840e37fb44fdac1d940f2b48f52b5faf43.js?a=ce8f75fb31c151d6a24cdd9aac8cd4ae"></script>

Take a look at the following snippet: [Git on Windows: Set up P4Merge as default mergetool]({{< ref "p4-merge-as-default-mergetool.md" >}})
