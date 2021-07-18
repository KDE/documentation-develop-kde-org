---
title: Templates
weight: 1
description: Templates provides a way for common functionality to be easily reused.
---

Templates are named packages that contain scripts. This provides a way
for common functionality to be easily reused, helping to increase
consistency and lower maintenance costs. Templates can be loaded from
other scripts by name and they are also used to populate some parts of
the user interface, such as the entries in the Add Panels menu.

A template is a small set of files in a specified file hierarchy (or, in
Plasma terms, a "Package"). In particular, a Template package contains
the following files:

-  `metadata.desktop`: a .desktop file describing the template
-  `contents/layout.js`: a Javascript file containing the actual script

Templates are stored in:

-  `/usr/share/plasma/layout-templates/`
-  `~/.local/share/plasma/layout-templates/`

and may be installed using:

```bash
kpackagetool5 --type=Plasma/LayoutTemplate -i /path/to/package
```

Instead of installing a directory, template packages may also be provided
as a `.zip` file renamed to have a `.plasmalayout` suffix.

```bash
(cd ~/Code/mytemplate && zip -r ../mytemplate.plasmalayout *)
kpackagetool5 --type=Plasma/LayoutTemplate -i ~/Code/mytemplate.plasmalayout
```

The `metadata.desktop` file contains the usual .desktop entries such as
Name and Icon but must also contain `Type=Service` and
`ServiceTypes=Plasma/LayoutTemplate` entries. If the layout is specific to
a given Plasma application, such as plasma-desktop, this can be specific
using `X-Plasma-Shell`. `X-Plasma-ContainmentCategories` defines what kind
of layout it is with possible values being panel and desktop. Finally, a
`X-KDE-PluginInfo-Name` entry is required to provide a globally unique
internal name for the Template. Here is an example of a Template that
provides a Panel layout for Plasma Netbook:


```ini
[Desktop Entry]
Encoding=UTF-8
Name=Cool Panel
Type=Service
ServiceTypes=Plasma/LayoutTemplate
X-Plasma-Shell=plasma-netbook
X-Plasma-ContainmentCategories=panel
X-KDE-PluginInfo-Author=Aaron Seigo
X-KDE-PluginInfo-Email=aseigo@kde.org
X-KDE-PluginInfo-Name=org.kde.CoolNetbookPanel
X-KDE-PluginInfo-Version=1.0
X-KDE-PluginInfo-Website=http://plasma.kde.org/
X-KDE-PluginInfo-Category=
X-KDE-PluginInfo-Depends=
X-KDE-PluginInfo-License=GPL
X-KDE-PluginInfo-EnabledByDefault=true
```

When running a template, two global variables will be accessible in
read-only mode: templateName and templateComment. They will contain the
Name and Comment fields of the above desktop file, and are translated if
a localization is available.

### Examples of Usage

#### Creating panels

A good example of the use of templates is the use case that triggered
the creation of this feature: the desire to make it easy for users to
re-create the default panel that is created on the first start. There is
a Template called `org.kde.plasma.desktop.defaultPanel` that ships with
the KDE Plasma Workspace which contains the layout for the initial
default panel. This is referenced by the default Plasma Desktop init
script and because it is marked as a Panel Template in the
metadata.desktop file it also shows up to the user in the Add Panels
menu. When selected by the user from the menu, the exact same panel that
is created on desktop start up is created for them, complete with Plasma
Widgets and configuration.

<!--

TODO figure out if this feature still exists

#### Automating tasks

Another example of the usefulness of templates is the "Find Widgets"
template. This template provides a function for finding widgets by name.
It appears in the toolbar "Load" and "Use" menus in the Desktop Console
in plasma-desktop, and makes finding widgets as simple as:

```js
const template = loadTemplate('org.kde.plasma-desktop.findWidgets');
template.findWidgets('systemtray');
```

Since just finding the widget is not enough, you can connect a callback
to do additional operations, such as removing the widget :

```js
removeWidget = function(widget, containment) {
 widget.remove();
}

const template = loadTemplate('org.kde.plasma-desktop.findWidgets');
template.findWidgets('systemtray', removeWidget);
```

-->

#### Activity templates

Probably the most user visible use of templates are "Activity
templates". The structure of Activity templates is similar to the other
use of templates, but a few extra features are provided in the
metadata.desktop file. Here is an example of such an activity template:

```ini
[Desktop Entry]
Encoding=UTF-8
Name=Cool Activity Template
Icon=user-desktop
Type=Service
ServiceTypes=Plasma/LayoutTemplate
X-Plasma-Shell=plasma-desktop
X-Plasma-ContainmentCategories=desktop
X-Plasma-ContainmentLayout-ExecuteOnCreation=dolphin $desktop, gwenview $pictures
X-Plasma-ContainmentLayout-ShowAsExisting=true
X-KDE-PluginInfo-Author=John Doe
X-KDE-PluginInfo-Email=john@doe.org
X-KDE-PluginInfo-Name=org.kde.plasma-desktop.CoolTemplate
X-KDE-PluginInfo-Version=1.0
X-KDE-PluginInfo-Website=http://john.doe.org
X-KDE-PluginInfo-Category=
X-KDE-PluginInfo-Depends=
X-KDE-PluginInfo-License=GPL
X-KDE-PluginInfo-EnabledByDefault=true
```

The layout itself is still created from the `layout.js` file as usual, but
this template also shows as a precreated activity to the user thanks to
the `X-Plasma-ContainmentLayout-ShowAsExisting` key. Additionally, it
starts applications in the newly created activity using the
`X-Plasma-ContainmentLayout-ExecuteOnCreation` key.

That key is a list of commands to execute, and it supports the following
variables:

-  `$desktop`
-  `$autostart`
-  `$documents`
-  `$music`
-  `$video`
-  `$downloads`
-  `$pictures`

They all expand into the path toward the user corresponding default
folder.
