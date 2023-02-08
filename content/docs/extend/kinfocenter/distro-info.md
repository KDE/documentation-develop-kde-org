---
title: Adding distribution information
description: KInfoCenter can be customized by distributions
weight: 1
---

## Introduction

[KInfoCenter](https://invent.kde.org/plasma/kinfocenter) is an application that can show information about your system, both as a standalone window and as a [Plasma configuration module (KCM)](../../kcm/).

It provides a simple way for distributions to showcase their branding in an integrated manner by editing a simple configuration file following the [Desktop Entry spec](https://specifications.freedesktop.org/desktop-entry-spec/latest/). It is possible to specify a custom logo, a link to a website, and make the output of scripts appear in its main page.

To extend KInfoCenter's information with data specific to your distribution you can
do the following:

## Extra Software Data

You can add a `kcm-about-distrorc` file in either `/etc/xdg` or the user's `~/.config/` folder. If the file is stored in `/etc/xdg`, its configuration will be applied to all users in the same computer, whereas if it is stored in `~/.config/` it will only affect the current user. The `~/.config` folder takes precedence over `/etc/xdg`, so if a `kcm-about-distrorc` exists in both places, the user configuration file will override the system configuration file.

Inside the rc file, under the `[General]` section, add an `ExtraSoftwareData` entry containing a semicolon-separated (;) list of scripts to run when KInfoCenter opens.

Each of these scripts should output 2 lines. One for the label (Usually ending in a : character)
and another for the value for that label.

If possible localization can be given by checking the LANGUAGE parameter when the script is executed.

For example in kcm-about-distrorc:

```
[General]
ExtraSoftwareData=/usr/bin/whichpartition;/usr/bin/whatsmyname
```

With /usr/bin/whichpartition giving the following output:

```
Partition:
A
```

And /usr/bin/whatsmyname giving the following output:

```
Username:
acoolusername
```

## Show Build

Another customization that can be included in kcm-about-distrorc is to have a ShowBuild key set to true.

```
[General]
ShowBuild=true
```

If this is present kinfocenter will show the BUILD_ID from /etc/os-release next to the version.

