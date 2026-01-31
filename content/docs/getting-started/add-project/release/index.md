---
title: "Preparing your software for release"
weight: 4
description: >
  Do this to make a stable or unstable release
---

This guide applies to all software which is not part of a bigger bundle like Frameworks, Plasma and KDE Gear, which have specific release cycles and release managers.

KDE provides a collection of scripts to facilitate making a new release called [releaseme](https://invent.kde.org/sdk/releaseme), which will be explained in this page.

## Deciding on a stable or unstable release {#type-of-release}

The first thing to consider when making a release is whether you want to make an unstable release or a stable release. Unstable releases serve to prepare for a stable release, allowing your users to test your software beforehand.

Projects undergoing [Incubation]({{< ref "incubation" >}}) are only allowed to make unstable releases. Projects that have passed [KDE Review]({{< ref "review" >}}) are effectively KDE projects and may do either.

KDE projects typically create up to three unstable releases: alpha, beta, and release candidate. Their versioning scheme ends with `.70`, `.80` and `.90` respectively, with the release candidate `.90` being the final version before a stable release. See [Understanding the software lifecycle]({{< ref "lifecycle" >}}) for details.

This is not a strict versioning scheme: projects like Plasma and KDE Gear for example use `.80` for alpha and `.90` for beta, and arbitrary numbers in-between may be used as well (for example, for a second or third beta). The only requirement is that only numbers be used, as letters are more difficult to compute and may cause issues in downstream packaging.

If you want to make an unstable release, you don't need to branch and may skip to the next section, [Changes in code]({{< ref "#changes-in-code" >}}). If you plan to make a stable release, follow through with the next sections.

## releaseme {#releaseme}

KDE has a tool that can be used to semi-automate the release process called [releaseme](https://invent.kde.org/sdk/releaseme).

The tool will **only** work with projects that contain an entry in [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata) as detailed in [Updating repo-metadata]({{< ref "#repo-metadata" >}}). This means it cannot be used on non-KDE projects in personal user namespaces in [Invent](https://invent.kde.org), and can only be used on projects that have passed at least [Incubation]({{< ref "incubation" >}}) or [KDE Review]({{< ref "review" >}}).

It consists of a collection of Ruby scripts for each individual step of the process:

* branchme
* tarme
* tagme
* logme

You may clone the repository elsewhere and point your PATH to it in order to run the scripts in each directory:

```bash
git clone https://invent.kde.org/sdk/releaseme.git
export PATH=$PATH:/path/to/releaseme
```

## Updating repo-metadata {#repo-metadata}

The central place where projects are defined is in [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata). Upon Incubation, projects should get an entry under `repo-metadata/projects-invent` containing two files: `i18n.json` and `metadata.yaml`.

Among other things, the `metadata.yaml` file specifies in which [Invent](https://invent.kde.org) group  the project belongs and its current state: whether it's in Incubation's `playground`, being `in-review`, or has already been `reviewed`.

The `i18n.json` file points to *origins*, namely `trunk_kf6` and `stable_kf6`. These are used by [releaseme](https://invent.kde.org/sdk/releaseme) during the [tarme]({{< ref "#tarme" >}}) process and used to determine which branches are used for translations, which is relevant for the [freeze]({{< ref "#freeze" >}}) process.

You must also update the following entries in `repo-metadata/dependencies/logical-module-structure.json` for your project: `kf6-qt6` which should point to the `master` branch, and `stable-kf6-qt6` which should point to the desired stable branch.

This means making sure repo-metadata is updated with the correct information is *required* for making a release, and [releaseme]({{< ref "#releaseme" >}}) will not work without this step.

## Changes in code {#code}

When you are ready to do a release, make sure the current HEAD in the stable branch has the correct version string set in its source code.

If your project consists of a library, you will also need to set the SOVERSION accordingly to reflect what you want to release.

A good suggestion is to use [ecm_setup_version()](https://api.kde.org/ecm/module/ECMSetupVersion.html) in your top-level CMakeLists.txt:

```cmake
cmake_minimum_required(VERSION 3.30)
project(kgraphviewer VERSION 2.4.0)

# ...

find_package(ECM 6.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(ECMSetupVersion)

# ...

ecm_setup_version(${PROJECT_VERSION}
    VARIABLE_PREFIX KGRAPHVIEWER
    SOVERSION ${PROJECT_VERSION_MAJOR}
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/config-kgraphviewer.h"
)
```

This is all that is required for *binary* applications.

If you are releasing a *library*, edit the `CMakeLists.txt` file where the main library target is created with the following:

```cmake
set_target_properties(kgraphviewerlib
    PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${KGRAPHVIEWER_SOVERSION}
    OUTPUT_NAME kgraphviewer
)
```

[ecm_setup_version()](https://api.kde.org/ecm/module/ECMSetupVersion.html) will autogenerate a `config-kgraphviewer.h` file that looks like this:

<details>
<summary>Click here to open the config-kgraphviewer.h file</summary>

```cpp
// This file was generated by ecm_setup_version(): DO NOT EDIT!

#ifndef KGRAPHVIEWER_VERSION_H
#define KGRAPHVIEWER_VERSION_H

#define KGRAPHVIEWER_VERSION_STRING "2.4.0"
#define KGRAPHVIEWER_VERSION_MAJOR 2
#define KGRAPHVIEWER_VERSION_MINOR 4
#define KGRAPHVIEWER_VERSION_PATCH 0
#define KGRAPHVIEWER_VERSION ((2<<16)|(4<<8)|(0))

#endif
```

</details>
<br>

The file can then be included in your main.cpp, making the `KGRAPHVIEWER_VERSION` define and others available in your code. This can be used, for example, in the [KAboutData](https://api.kde.org/kaboutdata.html) project version in your application. You can also install this file (useful for libraries to do feature-detection based on the version number).

{{< alert color="danger" title="🚨 Bump the version in the master branch" >}}

Don't forget to also increase the version number in master after you branched off.

For example, as soon as you create a "1.2" branch, ensure master's source code uses a version string such as "1.2.80".

{{< /alert >}}

## Feature freeze and freeze for translators {#freeze}

To prevent regressions early before a release, you *will* have to perform a feature freeze on the branch. From this point on, no new features should be introduced to the stable branch.

Additionally, because your project will ship translations, you will have to perform a string freeze, that is, making no changes to any translatable strings.

Before a release, you'll need to give translators a notification about the upcoming new version.

If you created a stable branch, make sure to update [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata) to set the `stable` i18n branch to the planned stable branch.

Send an email about one month before the release or so to the KDE i18n-doc mailing list <kde-i18n-doc@kde.org> notifying translators of the string freeze.

This is to ensure that translators have some time to localize your software before release. If you do need a string changed, ask the translators for a string freeze exception.

Other feature branches will always be unfrozen, and any kind of strings or features can be changed or added.

If the release is going to be unstable, the string freeze (and all pertinent steps) may be performed on the master branch as well until the day of release.

## Creating a tarball {#tarball}

A tarball is an archive containing the source code matching the tag, used by downstreams to reproducibly build your software.

To create the tarball, you will need to generate your own GPG key, which can be easily done with [Kleopatra](https://apps.kde.org/kleopatra/). The subsequent steps will fail if you do not have a GPG key.

Before using releaseme, you will need to make a merge request to [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata) changing your project's `i18n.json` file to point `trunk_kf6` to the master branch and `stable_kf6` to the created stable branch (if you are planning on making point releases). These will be considered `origin`s for releaseme.

After having [set up releaseme]({{< ref "#releaseme" >}}), create a new tarball with something similar to:

```bash
tarme.rb --origin stable --version 6.5.0
```

If you are not planning to make point releases, you may instead use the trunk origin:

```bash
tarme.rb --origin trunk --version 6.5.0
```

Creating a tarball is *required* for the next steps, and releaseme will not branch or tag without this step.

After running tarme, you will see a new tarball ending with `tar.xz`, and a signature file ending with `tar.xz.sig`.

## Branching {#branching}

Branching is done to allow the developer to make point releases in the future by using tags. For example, you might:

* create a `6.5` branch
* make a `6.5.0` tag based on the `6.5` branch, and thus make a `6.5.0` release
* later develop on the `6.5` branch
* make a `6.5.1` tag based on the developed `6.5` branch, and thus make a `6.5.1` release

See [Understanding the software lifecycle: The release process in practice]({{< ref "lifecycle#the-release-process-in-practice" >}}) for a practical example and diagram.

Branching is an optional step when making stable releases. You should branch when you effectively intend to make new point releases from a stable branch, as the process of making point releases is more complex than just tagging from the master branch. If your master branch doesn't have much feature development, you might prefer to create releases from the master branch.

After having set up [releaseme]({{< ref "#releaseme" >}}), create a new branch with something similar to:

```bash
branchme.rb --name 6.5
```

## Tagging {#tagging}

After having [set up releaseme]({{< ref "#releaseme" >}}) and having made a [tarball]({{< ref "#tarball" >}}), create a new tag with something similar to:

```bash
tagme.rb --version 6.5.0
```

## Publishing {#publishing}

The instructions on uploading the tarball are present in [upload.kde.org](https://upload.kde.org):

```bash
kate ftp://upload.kde.org/README
```

The first time you publish KDE software, you will be required to register your GPG key (which you should already have since the [Creating a tarball]({{< ref "#tarball" >}}) step) in [release-keyring](https://invent.kde.org/sysadmin/release-keyring). The file you are required to add is an ASC signature file.

You will also be required to send the SHA256 and SHA1 of the generated tarball and signature files from the [Creating a tarball]({{< ref "#tarball" >}}) step. This should mostly be automated by releaseme, but if you lose its output you may do something similar to the following:

```bash
sha256sum yourproject-6.0.0.tar.xz
sha256sum yourproject-6.0.0.tar.xz.sig
sha1sum yourproject-6.0.0.tar.xz
sha1sum yourproject-6.0.0.tar.xz.sig
```

The [upload.kde.org](https://upload.kde.org) domain is used only for uploading tarballs. You may upload the tarball with something like:

```bash
curl -T "myapp-0.1.tar.xz{,.sig}" ftp://upload.kde.org/incoming/
```

Or:

```bash
echo put myapp-0.1.tar.xz | ftp ftp://upload.kde.org/incoming/
echo put myapp-0.1.tar.xz.sig | ftp ftp://upload.kde.org/incoming/
```

Then, file a sysadmin ticket to notify about the upload and to provide the checksums for verification: [go.kde.org/u/systickets](https://go.kde.org/u/systickets). The tarball will be moved from the incoming folder to the correct place under [download.kde.org](https://download.kde.org), which is where downstreams like Linux distributions will download the sources of your application.

## Aftersteps {#aftersteps}

The new version should be added to the list of available versions to the component/product.
If you don't have enough permissions, [create a sysadmin ticket](https://go.kde.org/u/systickets) for that, or ask this a part of the ticket created when uploading the tarballs.

## Release announcement {#release}

Once the sysadmins moved the tarball, you can announce the release. First send an e-mail to kde-announce-apps@kde.org and your project's mailing list(s). The mail can be short and link to a longer announcement blog post or news item. If you write a detailed blog post, make sure that that your blog/site is aggregated on [planet.kde.org](https://planet.kde.org). This can be done on the [planet-kde-org repository](https://invent.kde.org/websites/planet-kde-org).

You should include the full fingerprint to the GPG key used to sign the tar and tags in your announcement e-mail. Upload your key to openPGP key servers using  `gpg2 --send-keys <fingerprint>`.

Ideally you also want to sign your email with the key in question to prove that you have control over the key.
