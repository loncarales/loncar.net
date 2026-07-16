+++
date = "2026-07-15"
title = "Git rerere: Automatically Resolve Repeated Merge Conflicts"
slug = "git-rerere-reuse-recorded-resolution"
tags = ["Git", "Workflow", "Automation"]
categories = ["Professional Development"]
series = ["Git-Without-Tears"]
+++

In my previous post long time ago 😜, I discussed [resolving Git merge conflicts the unpainful way]({{< relref "2019-05-12-resolve-git-merge-conflicts.md" >}}) using visual merge tools.

Visual merge tools make resolving conflicts much easier. But if you work on a long-lived feature branch, you've probably run into a different problem:

> You resolve a conflict today...
>
> ...and Git asks you to resolve **the exact same conflict again tomorrow.**

This commonly happens when you regularly rebase your feature branch on top of a busy `main` branch.

Fortunately, Git has a built-in feature designed specifically for this.

Meet **`git rerere`**.

## What is `git rerere`?

`rerere` stands for **Reuse Recorded Resolution**.

When enabled, Git records how you resolved a merge conflict. If Git encounters the same conflict again later, it automatically applies your previous resolution.

Think of it as Git saying:

> "I've seen you solve this before. I'll do it for you."

This can save a surprising amount of time if you frequently:

- rebase long-lived feature branches
- merge `main` into feature branches
- cherry-pick commits
- repeatedly resolve the same conflicts during development

## Enable it once

Enable `rerere` globally:

```bash
git config --global rerere.enabled true
```

That's it.

From now on, Git will quietly record your conflict resolutions in the background.

## A real walkthrough

Suppose your repository starts like this:

```bash
main
A ── B ── C

feature
     \
      D ── E
```

Both `main` and `feature` modify the same lines in `app.js`.

You decide to rebase your feature branch:

```bash
git checkout feature
git rebase main
```

Git stops with a conflict:

```bash
Auto-merging app.js
CONFLICT (content): Merge conflict in app.js
Recorded preimage for 'app.js'
```

Open the file, resolve the conflict, then continue:

```bash
git add app.js
git rebase --continue
```

At this point, `rerere` records your resolution.

---

The next day, more commits land on `main`.

```bash
main
A ── B ── C ── F ── G

feature
                \
                 D ── E
```

You rebase again:

```bash
git rebase main
```

Git recognizes the same conflict and automatically reuses your previous resolution:

```bash
Resolved 'app.js' using previous resolution.
```

Instead of manually editing the file again, Git has already applied the fix you taught it yesterday.

You should still review the result before continuing, but in many cases there's nothing left to do besides:

```bash
git add app.js
git rebase --continue
```

For long-running branches, this can eliminate a lot of repetitive work.

## Useful `git rerere` commands

Most of the time, `rerere` works automatically. But Git also provides a few commands that let you inspect what it's doing.

> **Note**
>
> `git rerere status` and `git rerere diff` are mainly troubleshooting commands. They only produce output while Git is in the middle of resolving a merge (or rebase/cherry-pick) conflict. If your working tree has no active conflicts, they'll simply produce no output.

### See which files have recorded resolutions

During an active conflict, run:

```bash
git rerere status
```

Example output:

```
app.js
```

This lists the conflicted files that `rerere` is currently tracking.

### See what Git learned

Also during an active conflict:

```bash
git rerere diff
```

This shows the difference between the conflicted version ("preimage") and the resolution that `rerere` plans to apply or has recorded.

### Forget recorded resolutions

If you accidentally taught Git an incorrect resolution, clear the recorded data:

```bash
git rerere clear
```

Git will forget the stored resolutions, allowing you to resolve future conflicts manually again.

## A few things to keep in mind

`rerere` isn't magic.

Git only reuses a resolution when it recognizes the conflict as being essentially the same one you've solved before.

Even when Git applies a recorded resolution automatically, it's still a good idea to review the result before committing or continuing a rebase. If the surrounding code has changed significantly, the previous resolution may no longer be the right one.

## Wrap up

If you've ever thought:

> "Didn't I already fix this conflict yesterday?"

then `git rerere` is for you.

It's one of Git's lesser-known features, but once enabled, it quietly removes one of the most frustrating parts of working with long-lived branches.

Resolve a conflict once, let Git remember it, and spend your time writing code instead of repeating yourself.

> And remember, contributions earn you karma. 😜
