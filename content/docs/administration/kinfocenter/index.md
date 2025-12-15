---
title: KInfoCenter branding
group: administration
description: Customize your distro details in KInfoCenter
---

## Introduction

[KInfoCenter](https://invent.kde.org/plasma/kinfocenter) is an application that can show information about your system, both as a standalone window and as a [KDE configuration module (KCM)]({{< ref "kcm">}}).

It provides a way for distributions to showcase their branding by editing a simple file following the [Desktop Entry spec](https://specifications.freedesktop.org/desktop-entry-spec/latest/).

## About this System entries

The main page for KInfoCenter is the "About this System" page. It also shows up in Plasma System Settings.

It is possible to add custom entries at the bottom of the Software information section.

Add a file `/etc/xdg/kcm-about-distrorc`, which should apply immediately to all users upon reopening KInfoCenter/System Settings. Adding it to `~/.config/kcm-about-distrorc` applies to only one user.

Inside the rc file, under the `[General]` section, add an `ExtraSoftwareData` entry containing a semicolon-separated (`;`) list of scripts to run when KInfoCenter opens.

Each of these scripts should output 2 lines. One for the label (ending in a colon `:` character, for consistency with the rest of the About System entries) and another for the value for that label.

Localization can be given by checking the `LANGUAGE` environment variable when the script is executed, keeping the English variant with 2 lines as the default output. KInfoCenter will fail to open if the entry points to a script but the script does not result in a 2-line output.

An example `kcm-about-distrorc` would look like this:

```
[General]
ExtraSoftwareData=/usr/bin/whichpartition;/usr/bin/whatsmyname
```

With `/usr/bin/whichpartition` giving the following output:

```
Partition:
A
```

And `/usr/bin/whatsmyname` giving the following output:

```
Username:
acoolusername
```

## Show Build

Another customization that can be included in `kcm-about-distrorc` is to use `ShowBuild=true`.

```
[General]
ShowBuild=true
```

When present, KInfoCenter will show the `BUILD_ID` from `/etc/os-release` next to the version.

For example, instead of just showing `SteamOS 3.5` at the top, it would say `SteamOS 3.5 Build: 20230201.1000`.
