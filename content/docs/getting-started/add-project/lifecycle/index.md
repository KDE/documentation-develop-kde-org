---
title: "Understanding the software lifecycle"
weight: 1
description: >
  Start here if you are new to the process
  of managing and publishing software
---

## General overview

The process of delivering software requires multiple steps.

If the software is not a part of KDE, then it needs to undergo an [Incubation]({{< ref "incubation" >}}) process to be integrated into KDE infrastructure, and then pass KDE Review.

If the software is already using KDE infrastructure, then it can go straight to [KDE Review]({{< ref "review" >}}).

{{< figure src="lifecycle.png" class="text-center" >}}

If the release you plan to do is an alpha, beta or release candidate (RC), then it would use an *unstable branch*. If the release is stable, then it would use a *stable branch*. A branch, in this context, is a line of development, that is, where you would continue to develop your software.

Before passing KDE Review, a project is allowed to release their software in the unstable branch, but not in the stable branch. After passing review, the project can release under either branch.

In practice, this means that the tarballs will be stored in a `stable/` or `unstable/` folder under <https://download.kde.org>.

When preparing the project for release, you will need to make changes in code to reflect a specific version, branch and tag it, and then create a tarball containing the source code, and move it to a place where downstreams (like Linux distributions) can access it.

Stable releases require using a versioned tag such as `v6.0.0`, but unstable releases can be tagged from master. Tags are, in this context, just an immutable pointer or snapshot of a branch/revision used for releases.

When preparing for a stable release, you would create a new branch matching `$MAJOR.$MINOR`, such as `6.0` (alternatively: `release/6.0`), and then tag it as `v6.0.0` to create a tarball. This matches the general development workflow: after creating the `v6.0.0` tarball, you may continue to work on the `6.0` branch, and in the future make *point releases* such as `v6.0.1` and `v6.0.2`. This allows you to use the `master` branch to develop for the next version (say, `6.1`) while using the `6.0` branch to iterate on the current release.

Unstable releases on the other hand do not require branching since you can use snapshots of the master branch to create new tags and subsequently tarballs. Tags should use `.70`, `.80` or `.90` at the end of the versioning name for alpha, beta and release candidates, respectively. For example: `v6.0.80`.

After branching a stable release, you *will* have to perform a feature freeze on the branch (as above, `6.0`). Additionally, because your project will ship translations, you will have to perform a string freeze, that is, making no changes to any translatable strings. You *will* have to update [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata) by setting the "stable i18n branch" to the stable branch (`6.0`). Send an email to the KDE i18n-doc mailing list <kde-i18n-doc@kde.org> notifying translators of the string freeze. This is to ensure that translators have some time to localize your software before release. If you do need a string changed, ask the translators for a string-freeze exception.

If the release is going to be unstable, the string freeze (and all pertinent steps) may be performed on the master branch as well until the day of release.

Then, you create the tarball, which is simply an archive containing the source code matching the tag, used by downstreams to reproducibly build your software. To create the tarball, you will need to generate your own GPG key, which can be easily done with [Kleopatra](https://apps.kde.org/kleopatra/). After creating the tarball, some testing is required before creating the tag and moving it to the right place.

## The release process in practice

This can all be rather confusing, but let's take a look at what it looks like in sequential order depending on whether you want to make a stable or unstable release.

Suppose you plan to make multiple unstable releases that correspond to the beta (6.4.80) and release candidate (6.4.90) in preparation for making a future 6.5.0 release:

{{< figure src="unstable-lifecycle.png" >}}

Now that you've gotten some unstable releases for your users to test, you want to make a stable 6.5.0 release and plan to create two point releases, namely 6.5.1 and 6.5.2:

{{< figure src="stable-lifecycle.png" >}}

Because of this release workflow, you are now able to work on the master branch for the development of the next 6.6.0 release and continue shipping point releases for your users of the 6.5 branch.
