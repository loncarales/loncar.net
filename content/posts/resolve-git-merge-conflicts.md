+++
date = "2019-05-12"
title = "Resolve Git merge conflicts the unpainful way"
slug = "resolve-git-merge-conflicts"
tags = ["Git", "P4Merge"]
categories = ["Professional Development"]
+++

## What is a Git Merge Conflict?

A merge conflict is an event that occurs when Git is unable to automatically resolve differences in code between two commits. However, when there are different changes on the same lines, a “merge conflict” occurs because Git doesn’t know which code to keep and which to discard.

Merge conflicts can be painful and are traditionally cause developers a lot of grief, especially when working in the terminal. There are various Visual merge conflict tools which help users identify where the conflict is occurring and how to resolve it. An excellent visual merge tool will display at least three panels for each file with conflicts. There will be a panel showing the version of that file:

* In local branch
* In the remote branch
* As it will appear after merging

There are also tools which also include a fourth display panel showing the version of that file in the merge base. Such a tool is [Helix Visual Merge Tool (P4Merge)](https://www.perforce.com/downloads/visual-merge-tool).


{{< figure link="https://cdn.loncar.net/Perforce+P4Merge.png" src="https://cdn.loncar.net/Perforce+P4Merge.png" alt="P4Merge as a four-pane merge tool" caption="P4Merge as a four-pane merge tool" >}}

P4Merge show you these panes:

* LOCAL – your file with the changes you’ve made to it
* BASE – the common ancestor file that LOCAL and REMOTE came from
* REMOTE – the file you’re merging in, possibly authored by someone else
* MERGE_RESULT – the file resulting from the merge where you resolve conflicts

## Git commands that can help resolve merge conflicts

### General tools

```bash
$ git status
```
> The status command is in frequent use when a working with Git and during a merge it will help identify conflicted files.

```bash
$ git log --merge
```
> Passing the `--merge` argument to the git log command will produce a log with a list of commits that conflict between the merging branches.

```bash
$ git diff
```
> `diff` helps find differences between states of a repository/files. This is useful in predicting and preventing merge conflicts

### Tools for when git fails to start a merge

```bash
$ git checkout
```
> `checkout` can be used for undoing changes to files, or for changing branches

```bash
$ git reset --mixed
```
> `reset` can be used to undo changes to the working directory and staging area.

### Tools for when git conflicts arise during a merge

```bash
$ git merge --abort
```

> Executing git merge with the `--abort` option will exit from the merge process and return the branch to the state before the merge began.

```bash
$ git reset
```

> Git `reset` can be used during a merge conflict to reset conflicted files to a know good state

## Example: Creating a merge conflict

<script src="https://embed.cacher.io/82523f825d3bf911fdf945c0032d49f57a08a113.js?a=a3c18eac0c35d4e521489c80f92a4c71&t=atom_one_dark"></script>

If you would like to setup P4Merge as your favourite git merging tool, take a look at the following snippet:

[Git for Windows: Set up P4Merge as default mergetool]({{< ref "p4-merge-as-default-mergetool.md" >}})

You can configure your weapon of choice if you prefer, but you'll need to consult your tool's documentation for detailed instructions.

Then, in case of a conflict, you invoke it by simply typing

```bash
$ git mergetool
```

You should keep in mind is that you can always undo a merge and go back to the state before the conflict occurred. You're always able to undo and start fresh.

> And remember, contributions earn you karma. 😜
