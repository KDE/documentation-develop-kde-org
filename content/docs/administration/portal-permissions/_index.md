---
title: XDG Portal Pre-Authorization
group: administration
description: Pre-authorize applications to allow usage of XDG portal tech without interactive dialogs
---

This feature was introduced in Plasma 6.3.

# Introduction

Interactive permission prompts are nice, but sometimes users
need to authorize access to resources non-interactively.

To solve this, we have a bespoke permission table named `kde-authorized` in
the standard xdg-desktop-portal permission store. Inside this table the user may store
pre-authorization to bypass the interactive workflow.
To authorize a well-known application, the user can pass the `app_id` to the
set command:

```bash
flatpak permission-set kde-authorized remote-desktop org.kde.krdpserver yes
```

To authorize a host application without an `app_id`, an empty `app_id` may be
provided:

```bash
flatpak permission-set kde-authorized remote-desktop "" yes
```

Usually the `app_id` is obtained from flatpak/snap metadata.
For host applications, it is obtained from the systemd unit name:
* For applications that get started by Plasma, those will be set up correctly.
* For manually created units, the https://systemd.io/DESKTOP_ENVIRONMENTS/
spec should be followed (i.e. name the unit
`app-org.kde.appname.service`).
* When the name cannot be determined, the empty `app_id` is used.

# Supported Types

* remote-desktop

# Caveats

* Host applications may impersonate any app_id
* The empty `app_id` may match too broadly. It's advisable to get the application to provide an `app_id` instead. See https://systemd.io/DESKTOP_ENVIRONMENTS/. In the future possibly also via https://github.com/flatpak/xdg-desktop-portal/pull/1521.
