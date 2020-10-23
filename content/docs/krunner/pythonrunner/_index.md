---
title: "Creating KRunner Plugins in Python"
linkTitle: "Creating KRunner Plugins in Python"
weight: 1
description: Learn how to create KRunner Plugins in Python
--- 

## Basic setup

We will also use [KAppTemplate](https://kde.org/applications/kapptemplate) to generate a suitable project to start from.
On Debian-based distributions, it can be installed using `sudo apt install kapptemplate`.

After starting KAppTemplate, skip through to the page that lets you choose
a template for your new project. From the Plasma category, choose *KRunner*
and then the Python variant. If you can't find the template your installed KRunner version might be older than 5.75.
In that case you don't have the latest features,
but you can still get the template from the KDE Store https://store.kde.org/p/1333634/.  
*The name for the project when generating it from the template is `MyPythonRunner`*.

After generating the project ou should see the following files:  
```
README.md
install.sh
mypythonrunner.py
org.kde.mypythonrunner.service
plasma-runner-mypythonrunner.desktop
uninstall.sh
```

The `mypythonrunner.py` is the Python file in which you will write your code in. `plasma-runner-mypythonrunner.desktop`
is a configuration file, it will tell KRunner that the plugin should be queried and it provides some data like the
name, comment and version. The `org.kde.mypythonrunner.service` file is the D-Bus service file, if your python plugin
is not running, but you type a query in KRunner it will get started. This is really useful, because you don't need to
autostart it. You could say that it only gets started if it is actually needed. The `install.sh` and `uninstall.sh`
scripts are intended to make the installation easier: They copy the files in the right directory and restart KRunner.  
The `README.md` contains some useful information. You might want to extend it with the awesome features your
runner provides. Especially when uploading it on for example Github it make sure to add some examples and screenshots to it.

## The Python File

```python3
#!/usr/bin/python3

import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib

DBusGMainLoop(set_as_default=True)

objpath = "/mypythonrunner"

iface = "org.kde.krunner1"

class Runner(dbus.service.Object):
    def __init__(self):
        dbus.service.Object.__init__(self, dbus.service.BusName("org.kde.mypythonrunner", dbus.SessionBus()), objpath)

    @dbus.service.method(iface, in_signature='s', out_signature='a(sssida{sv})')
    def Match(self, query: str):
        """This method is used to get the matches and it returns a list of tupels"""
        if query == "hello":
            # data, text, icon, type (Plasma::QueryType), relevance (0-1), properties (subtext, category and urls)
            return [("Hello", "Hello from MyPythonRunner!", "document-edit", 100, 1.0, {'subtext': 'Demo Subtext'})]
        return []

    @dbus.service.method(iface, out_signature='a(sss)')
    def Actions(self):
        # id, text, icon
        return [("id", "Tooltip", "planetkde")]

    @dbus.service.method(iface, in_signature='ss')
    def Run(self, data: str, action_id: str):
        print(data, action_id)


runner = Runner()
loop = GLib.MainLoop()
loop.run()
```

The file can be interpreted as three parts: The imports & declaration of constants, the Runner class and the
starting of the process loop.