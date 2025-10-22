---
title: Introduction to Kiosk
weight: 1
# SPDX-FileCopyrightText: 2005  Barry O'Donovan
# SPDX-FileCopyrightText: 2016 David Edmundson
# SPDX-FileCopyrightText: 2016 Marco Martin
# SPDX-FileCopyrightText: 2016 Kai Uwe Broulik

SPDX-License-Identifier: CC-BY-SA-4.0
---

The KDE Kiosk is a framework that has been built into KDE since version
3. It allows administrators to create a controlled environment for their
users by customizing and locking almost any aspect of the desktop which
includes the benign such as setting and fixing the background wallpaper,
the functional such as disabling user log outs and access to the print
system and the more security conscientious such as disabling access to a
command shell.

This kind of framework is vital to maintain and increase KDE's
propagation into areas such as business and enterprise environments and
school and university laboratories. Other obvious areas of interest
where a restricted desktop environment is required or desired would be
the likes of Internet cafés, public access terminals and kiosks.

KDE's Kiosk framework is controlled by entries in various configuration
files. In this article I will discuss the layout of KDE's configuration
files and how to edit them to enable Kiosk's features. I will also
discuss the various aspects of the desktop environment that can be
customized and/or locked using the Kiosk framework. Once the reader
understands how the Kiosk framework actually works through KDE's
configuration files, we will discuss the Kiosk Admin Tool for those that
prefer a GUI interface. This tool also allows administrators to more
easily set-up Kiosk profiles and assign them system wide, per-user or
per-group.

## KDE's Configuration File Structure and Hierarchy

All KDE applications use the same API to create, access and alter their
configuration files. As such, all configuration files are stored in
predetermined directories and they share the same syntax and structure.
They are organised into groupings of key-value pairs. For example, let
us examine some of the settings for the mouse behavior and desktop style
stored in `~/.config/kdeglobals`:

```ini
[KDE]
SingleClick=true
DoubleClickInterval=400
widgetStyle=breeze
```

The `KDE` group as shown contains two key-value pairs to indicate
some global settings across the desktop, such as the mouse behavior
(single click activation vs double click) and the used applications
widget style. The beginning of a group is indicated by placing its name
in square brackets and that group ends when the next one begins or when
the end of the configuration file is reached. Both the key and its value
may contain spaces but all whitespace immediately before and after the
equals sign and at the end of the line are ignored.

KDE configuration files can be stored in a number of possible
directories and configuration files with the same name may exist in the
different directories. There is a predetermined order in which these
locations are checked for configuration files and KDE combines
configuration files of the same name on a key-by-key basis; this is
known as "cascading configuration". If the same key is defined in more
than one of the configuration files then the key value read from the
directory tree with the highest precedence will be used.

Some [environment variables](https://specifications.freedesktop.org/basedir-spec)
are used to indicate which directories should be searched for
configuration files: `$XDG_CONFIG_DIRS` is a cross-desktop
environment variable used to locate configuration files globally in the
system. `$XDG_CONFIG_HOME` defines the directory where user specific
configs should be stored.

The cascading nature of KDE's configuration files allows system
administrators to set system wide defaults while ensuring that the
user's custom configuration settings will always override these system
defaults. It is also the basis of the Kiosk framework as configuration
entries may be marked as "immutable" - entries in a user's configuration
file in `$XDG_CONFIG_HOME` that have been marked as immutable in a
system level directory will not be read and will therefore have no
effect.

Let us continue with the applications widget style example and, as the
system administrators of an Internet café, we want to ensure that the
widget style is the default "Breeze" style and can't be changed by
customers to ensure a visual branding integrity between the machines in
the shop. In one of the system level directory trees
(`$XDG_CONFIG_DIRS`), we would edit the file
`$XDG_CONFIG_DIRS/kdeglobals` so that it contained:

```ini
[KDE]
SingleClick=true
DoubleClickInterval=400
widgetStyle[$i]=breeze
```

Appending `[$i]` to the configuration key marks it as immutable. As
configuration files from `$XDG_CONFIG_DIRS` are read before
`$XDG_CONFIG_HOME`, the background is now "locked down" and any
custom settings made by a user to it, either directly or though a
configuration dialog, will not be read by the configuration system.

Configuration options can also be marked immutable by group and by file.
To mark a group as immutable, we append `[$i]` to the group name:

```ini
[KDE][$i]
SingleClick=true
DoubleClickInterval=400
widgetStyle=breeze
```

Similarly, we can mark an entire configuration file as immutable by
placing `[$i]` on a line of its own at the beginning of the file;
the system will now ignore a configuration file of the same name in the
user's KDE configuration directory.

Setting default configuration options for KDE applications is just as
easy as fixing the desktop background. We could lock Dolphin settings to
always show the available space indicator in its statusbar by setting
the following in a file called `dolphinrc` in one of the system
directory trees:

```ini
[General]
ShowSpaceInfo[$i]=true
```

Any setting that can be changed or customized in an application is one
that can be locked down using the Kiosk framework. Examine the contents
of the various configuration files that can be found under to get a
feeling for KDE application configuration settings.

You should also bear in mind that most applications will need to be
restarted for configuration settings to take effect. For changes to
configuration files such as `kdeglobals` you will need to log out and
back into the Plasma session for changes to be applied.

The information presented in this section will allow you to set system
defaults and lock them if necessary for any KDE application. However,
this is only the proverbial tip of the iceberg of the KDE Kiosk system
and in the following sections we will cover many more of its
capabilities.

The order of files is loaded as follows:

* `~/.config/myAppConfigrc` (i.e dolphinrc)
* `/etc/xdg/myAppConfigrc` (i.e dolphinrc)
* `~/.config/kdeglobals`
* `/etc/xdg/kdeglobals`
* `~/.config/system.kdeglobals`
* `/etc/xdg/system.kdeglobals`
* `/etc/kde5rc`

## KDE Action Restrictions

Many actions in KDE applications and Plasma can be restricted through
the Kiosk system by placing appropriate entries in the 
file in a system level directory, such as `/etc/xdg/kdeglobals`. We
could disable the file open action by adding the following entry:

```ini
[KDE Action Restrictions][$i]
action/file_open=false
```

This change can be visibly seen in Kate's 'File' menu and toolbar that is
now unable to change the settings.

The actions that can be restricted include all standard file options,
editing options, Internet and file browsing actions, the use of
bookmarks and access to the help system. A comprehensive list can be
found in the [Keys page](../keys).

A few other actions that are worthy of individual mention in the context
of corporate and similar environments are:

* **shell_access:** Defines whether the user can start a shell for entering commands,
  whether the “Run Command” option (<kbd>Alt</kbd>-<kbd>F2</kbd>) can be used to run shell
  commands and arbitrary executables and whether executables placed in
  the user's Autostart folder will be executed.

* **logout:** Defines whether a user will be able to end the KDE Plasma session.

* **lock_screen:** Defines whether a user will be able to lock the screen.

* **run_command:** Controls access to the “Run Command” (KRunner) option.

* **movable_toolbars:** Whether or not toolbars can be detached and/or moved around.

* **action/options_show_toolbar:** Whether or not toolbars can be hidden.

* **plasma/plasmashell/unlockedDesktop:** Whether or not widgets can be
   unlocked by the user. Unlocking widgets would allow the user to
   move around, add, and remove widgets, panels, launchers, etc.

In a public environment, set the action `lineedit_text_completion` to
false so that text boxes and the “Run Command” dialog do not remember
previously entered information. Do note that this will not affect 3rd
party web browsers like Firefox.

## KDE URL Restrictions

The KDE Kiosk system allows system administrators to control access to
specific URLs based on the referrer, the protocol, the host and the path
through entries in the file. Although some of these tasks may be more
appropriate for a proxy server or a firewall, this functionality becomes
incredibly useful when you consider the fact that KDE treats all
locations as URLs. For blocking access to websites, one might use the
following example:

Note this, only affects KDE applications, such as Dolphin or Konqueror.
Other browsers are not affected.

```ini
[KDE URL Restrictions][$i]
rule_count=2
rule_1=open,,,,http,*.hotmail.msn.com,,false
rule_2=open,,,,http!,webmail.college.com,,false
```

The first rule blocks all http and https access to any URL that contains
`.hotmail.msn.com` in the host part. Specifying one protocol will also
match similar protocols that start with the same name; so specifying
http will also include https. Rule 2 above blocks only http and thus
forces the user to use https (assuming it is supported). The above rules
could be used as a basis, for example, to block all access to third part
web-based e-mail clients and force users to use a company or college
provided virus-scanned e-mail account over https. If, for example, an
Internet café took sponsorship from a search engine then its system
administrators could use similar rules to block access to that search
engine's competitors.

The format for URL restrictions is:

```ini
rule_N=<action>,<referrer protocol>,<referrer host>,<referrer path>,
   <protocol>,<host>,<path>,<enabled>
```

Any option that is left blank will match all by default. As we saw in
the example above, wild cards may be used for host names. Specifying a
path will match all URLs that begin with that path unless an exclamation
mark is placed at the end of the path.

As I mentioned, KDE treats all locations as URLs: for example Internet
addresses are URLs with the http or https protocol whereas local files
on the hard drive are URLs using the file protocol. Access to the local
filesystem can be restricted using rules such as the following:

```ini
[KDE URL Restrictions][$i]
rule_count=6
rule_1=open,,,,file,,,false
rule_2=list,,,,file,,,false
rule_3=open,,,,file,,$HOME,true
rule_4=list,,,,file,,$HOME,true
rule_5=open,,,,file,,$TMP,true
rule_6=list,,,,file,,$TMP,true
```

These rules will only allow the user to browse and access files stored
in their home directory. We also allow access to the temporary directory
used by KDE to ensure normal operation. If you are implementing a
security policy then these rules should be used in conjunction with
other rules such as restricted shell access.

## KDE Control Module Restrictions

Almost all aspects of Plasma can be configured and customized through
the "System Settings". Each "group" of settings, such as "Screens",
"Colours", "Fonts", etc correspond to a system settings module and
each of these modules can be locked down through the Kiosk
framework.

As an example, a way of preventing users from changing their mouse
settings would be to lock down that system settings module:

Add the following to the global kde5rc file, in the hierarchy listed
above.

```ini
[KDE Control Module Restrictions][$i]
kcm_mouse=false
```

The users will not even see an option to configure the mouse in System
settings.

Run the command `kcmshell6 --list` for a list of available modules
and use the format <module-name>.desktop in the configuration file. In
most public access/café environments, one will probably want to lock
down almost all control centre modules.

![System settings](systemsettings.png)

## Closing Remarks

KDE's Kiosk framework is an essential tool for any system administrator
who is maintaining or deploying the Plasma in a multi-desktop/multi-user
scenario and/or in an environment where users cannot be trusted. By
preventing users from changing default settings and locking down
settings that may pose a security risk, a system administrator can
significantly reduce the amount of time that will be spent "maintaining
and repairing" each desktop as well as ensuring that each user has a
common and familiar desktop environment every time they sit down to the
computer.

