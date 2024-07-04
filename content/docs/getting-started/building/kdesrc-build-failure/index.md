---
title: "Basic troubleshooting"
description: "What to do in case of build issues"
weight: 13
group: "kdesrc-build"
---

## The project has failed to build

Did one or more modules fail to build (displayed in red font) using `kdesrc-build`?
This page should tell you the most likely causes and how to fix them.

Remember that you can [contact the development team]({{< ref "help-developers" >}}) to get assistance with kdesrc-build.

### Missing dependencies

The most likely reason is that you are missing the dependencies necessary for the failing module.
Once `kdesrc-build` finishes its build and fails, it will display the path to the module's CMake log files (for example: `~/kde/src/log/latest/kwallet/error.log`).
You should take a look at the log files to see if anything is missing: you can read more about how to understand the errors you get from CMake in [Install the dependencies]({{< ref "help-dependencies" >}}).
That page will also tell you how to search for dependencies in your distribution.
When you have the necessary dependencies, you can save time and resume from the failing module with the `--resume-from` flag:

```
kdesrc-build --resume-from [the name of the module that failed]
```

### Old cache

Sometimes a project has suffered big enough changes to its code that its cache starts to affect subsequent builds.

To clear the cache, you can use the `--refresh-build` flag:

```
kdesrc-build [failing module] --refresh-build
```

### Broken master branch

It is rare, but if the master branch of a project contains faulty code, it will not compile with kdesrc-build.

To check, look at the [Invent](https://invent.kde.org), KDE's Gitlab instance where all code is stored.
If the project has a GitLab build pipeline and the pipeline is broken, then it's not your fault.

{{< figure class="text-center mr-5 pr-5" caption="Where to see if the pipeline is working." src="gitlab-successful.webp" >}}

## The project has failed to run

Did the project build successfully, but it does not run as intended?
Here are a few reasons why.

### Changes to the installed files

Sometimes some changes to a project's code (or one of its dependency libraries) lead to its installed files to be renamed or moved.
When that happens, the old files might still linger in `~/kde/usr`.

There are multiple ways to address this:

* You can just always run kdesrc-build with the `--use-clean-install` flag. This will call the uninstall target of CMake that KDE projects using extra-cmake-modules have, uninstalling previously installed files before installing new ones. This will decrease the speed of installing files built with kdesrc-build.
* You can nuke your current installed files with `rm -rf ~/kde/usr` and then rerun kdesrc-build.
* You can start with a new and clean kdesrc-build installation. This can be done by creating a new user and installing kdesrc-build from scratch. Another possibility is to rename your existing development setup with `mv ~/kde ~/kde~bak` and then rerun kdesrc-build.
