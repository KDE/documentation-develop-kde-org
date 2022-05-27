---
title: KWin Scripting Tutorial
weight: 4
description: Learn how to programmatically manipulate windows with KWin scripts.
aliases:
  - /docs/plasma/kwin/
---

## Quick Start: Desktop Console

The easiest way to test KWin scripts is to use the Plasma Desktop
Scripting Console which can be opened via the KRunner window (`Alt+F2`,
by default, or via the "Run Command" entry in various desktop menus)
by entering `wm console` as the search term.

The console can also be opened from the terminal using the following command:
```bash
plasma-interactiveconsole --kwin
```

In Plasma versions earlier than 5.23 the command is:

```bash
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.showInteractiveKWinConsole
```

The interactive console allows to send a script to the window manager
which is directly loaded and executed. All debug output is displayed in
the scripting console. This provides a very easy way to develop and test the
script to be written. It is important to know that scripts executed from the
scripting console are only used by the window manager as long as the window
manager is running. In a new session the script has to be sent to the window
manager again.

Since Plasma version 5.23, [the output is not visible in the console window](https://bugs.kde.org/show_bug.cgi?id=445058). You can retrieve all KWin scripting output from the journal instead, as described in the section on output below.

## Packaging KWin scripts

In order to have KWin load a script on each session start the script has to
be packaged. KWin scripts use the [KPackage](https://api.kde.org/frameworks/kpackage/html/)
format.

### Package structure

A KWin script package has the following directory structure:

```plaintext
myscript
├── contents
│   ├── code
│   │   └── main.js
├── metadata.json
```

`contents/code/main.js`, or `contents/code/main.qml` if you write your script in QML, is where the main code of the script resides.

Additionally you need a `metadata.json` file which provides some general information about the script.

The  toplevel folder `myscript` may contain any number of additional files, such as a readme.

### Metadata

Open up `metadata.json` in your text editor then paste the following. Keep in mind that `Id` is the folder name the script is installed to. Eg: `.../share/kwin/scripts/myscript/`.

`X-Plasma-API` can be either `javascript` or `declarativescript` if you want to generate QML windows.

```javascript
{
    "KPlugin": {
        "Name": "My Script",
        "Description": "Description of the script",
        "Icon": "preferences-system-windows",
        
        "Authors": [
            {
                "Email": "username@gmail.com",
                "Name": "Firstname Lastname"
            }
        ],
        "Id": "myscript",
        "ServiceTypes": [
            "KWin/Script"
        ],
        "Version": "1.0",
        "Licsense": "GPLv3",
        "Website": "https://github.com/username/myscript"
    },
    "X-Plasma-API": "javascript",
    "X-Plasma-MainScript": "code/main.js"
}
```

### Installation

Installed KWin scripts can be found in System Settings > Window Management > KWin scripts.

A packaged KWin script can either be installed from there (note: the list
does not yet reload after installing a script) or with the `kpackagetool5` tool:

```bash
kpackagetool5 --type=KWin/Script -i ~/Code/myscript/
```

After installing the script, enable it, either from the system settings page or with the `kwriteconfig5` tool:

```bash
kwriteconfig5 --file kwinrc --group Plugins --key myscriptEnabled true
qdbus org.kde.KWin /KWin reconfigure
```

Providing a custom installation shell script that would automatically perform additional steps upon installation is not possible for KWin scripts.

## Where can I find example scripts?

A few KWin scripts are shipped directly with the window manager. You can find those in your
system installation. Just use `kpackagetool5` to get a list of the available scripts:

```bash
kpackagetool5 --type=KWin/Script --list --global # /usr/share/kwin/scripts/
```

The default scripts bundled with the window manager can also be
[found in the KWin repository](https://invent.kde.org/plasma/kwin/-/tree/master/src/scripts).

[Downloaded KWin scripts](https://store.kde.org/browse/cat/210/) can be found in your user's data install path under `kwin/scripts/`. This is where your new script will be installed to.

```bash
kpackagetool5 --type=KWin/Script --list # ~/.local/share/kwin/scripts/
```

## KWin scripting basics

To follow this tutorial, you must have some idea about [ECMAScript](http://en.wikipedia.org/wiki/ECMAScript)
(or [JavaScript](http://en.wikipedia.org/wiki/JavaScript)). A quick introduction can be found
in the [Plasma scripting tutorial](https://develop.kde.org/docs/plasma/scripting/).

KWin scripts can either be written in [JavaScript](https://doc.qt.io/qt-5/topics-scripting.html#js-api)
(service type `javascript`) or [QML](https://doc.qt.io/qt-5/qtqml-index.html) (service type `declarativescript`).
In order to develop KWin scripts you should know the basic concepts of [signals and properties](https://doc.qt.io/qt-5/signalsandslots.html).

To get a full overview of the available objects and functions, please refer to the [API documentation](api).

### Output

The following global function is available to both QML and JavaScript:

* `print(QVariant...)`: prints the provided arguments to stdout. Takes an arbitrary number
  of arguments. Comparable to `console.log()` which should be preferred in QML scripts. 

The print output of Plasma and KWin scripts can be read from the journal:

```bash
journalctl -g "js:" -f
```

If you are not getting any output, open `kdebugsettings` and make sure KWin Scripting is set to Full Debug.

Additionally, you may need to enable [Plasma systemd boot](https://invent.kde.org/plasma/plasma-workspace/-/wikis/Plasma-and-the-systemd-boot) to obtain log information.

### Workspace and Options

KWin scripts can access two global properties: `workspace` and `options`. The `workspace` object
provides the interface to the core of the window manager, the `options` object provides read
access to the current configuration options set on the window manager.

### Clients

The window manager calls a window it manages a "Client". Most methods of workspace operating
on windows either return a Client or require a Client. Internally the window manager supports
more types of windows, which are not clients. Those windows are not available for KWin scripts,
but for KWin Effects. To have a common set of properties some properties and signals are
defined on the parent class of Client called Toplevel. Be sure to check the documentation of
that class, too when looking for properties. Be aware that some properties are defined as
read-only on Toplevel, but as read-write on Client.

The following examples illustrates how to get hold of all clients managed by the window manager
and prints the clients' caption:

```javascript
const clients = workspace.clientList();
for (var i = 0; i < clients.length; i++) {
  print(clients[i].caption);
}
```

The following example illustrates how to get informed about newly managed clients and prints out
the window id of the new client:

```javascript
workspace.clientAdded.connect(function(client) {
  print(client.windowId);
});
```

To understand which parameters are passed to the event handlers (i.e. the functions we connect to),
one can always refer the [API documentation](api).

## Configuration

KWin scripts can have a user configuration. To enable this, add the following line to your `metadata.json`:

```json
"X-KDE-ConfigModule": "kwin/effects/configs/kcm_kwin4_genericscripted"
```

### Declaration

User configurable settings are defined in a file `myscript/contents/config/main.xml`. An example can be found in the [Plasma widget tutorial](https://develop.kde.org/docs/extend/plasma/widget/configuration/). This results in the following package structure:

```plaintext
myscript
├── contents
│   ├── code
│   │   └── main.js
│   ├── config
│   │   └── main.xml
├── metadata.json
```

### Graphical interface

A graphical configuration menu for the script can be provided in the form of a file `myscript/contents/ui/config.ui`.

A KWin script package with a configuration UI will thus have the following sctructure:

```plaintext
myscript
├── contents
│   ├── code
│   │   └── main.js
│   ├── config
│   │   └── main.xml
│   └── ui
│       └── config.ui
├── metadata.json
```

`.ui` widgets are most easily edited with the Qt Designer application.

The object name of each UI element which provides the setting for a configuration value must be `kcfg_keyName`, where `keyName` is the value of the  `name` attribute for the corresponding entry in the xml flie.

The configuration menu is then accessible through the configuration button in the KWin script KCM. Note that users on Plasma versions <5.23 will have to take [additional steps after installation](https://bugs.kde.org/show_bug.cgi?id=444378#c10) to be able to access the configuration menu.

### Reading configuration values

Configuration values for KWin scripts will be stored in the file `~/.config/kwinrc`, and can be read with the following global function (available in both Javascript and QML scripts):

* `readConfig(QString key, QVariant defaultValue=QVariant())`: reads a config option of the
  KWin script. First argument is the config key, second argument is an optional default value
  in case the config key does not exist in the config file.

The `key` to be used is the value of the `name` attribute for the corresponding entry in the xml flie.

## Your first (useful) script

In this tutorial we will be creating a script based on a suggestion by Eike Hein. In Eike’s words:
“A quick use case question: For many years I’ve desired the behavior of disabling keep-above on a
window with keep-above enabled when it is maximized, and re-enabling keep-above when it is restored.
Is that be possible with KWin scripting? It’ll need the ability to trigger methods on state changes
and store information above a specific window across those state changes, I guess.”

Other than the really functional and useful script idea, what is really great about this is that it
makes for a perfect tutorial example. We get to cover most of the important aspects of KWin scripting
while at the same time creating something useful.

So let’s get on with it…

### The basic outline

Design statement: For every window that is set to ‘Keep Above’ others, the window should not be above
all windows when it is maximized.

To do so, this is how we’ll proceed:

1. Create an array of clients whose **Keep Above** property has been removed for maximized windows
2. Whenever a client is maximized, if it’s **Keep Above** property is set, remove the **Keep Above** property.
3. Whenever a client is restored, if it is in the ‘array’, set it’s **Keep Above** property.

### The basic framework

So, for first steps, let us just create an array:

```javascript
var keepAboveMaximized = [];
```

Now we need to know whenever a window got maximized. There are two approaches to achieve that: either
connect to a signal emitted on the workspace object or to a signal of the client. As we need to track
all Clients it is easier to just use the signal `clientMaximizeSet` on the workspace. This signal is
emitted whenever the maximizationf state of a Client changes and passes the client and two boolean
flags to the callback. The flags indicate whether the Client is maximized horizontally and/or
vertically. If a client is maximized both horizontally and vertically it is considered as fully
maximized. Let's try it:

```javascript
workspace.clientMaximizeSet.connect(function(client, h, v) {
  if (h && v) {
    print(client.caption + " is fully maximized");
  } else {
    print(client.caption + " is not maximized");
  }
});
```

Best give the script a try in the desktop scripting console and play with your windows. Remember right
and middle clicking the maximize button changes the horizontal/vertical state of the window. 

### Checking keep above

Now we actually want to do something with the maximized Client. We need to check whether the window is set
as keep above. If it is so, we need to remove the keep above state and remember that we modified the Client.
For better readability the callback is moved into an own method:

```javascript
function manageKeepAbove(client, h, v) {
  if (h && v) {
    // maximized
    if (client.keepAbove) {
      keepAboveMaximized.push(client);
      client.keepAbove = false;
    }
  }
}
```

This code checks whether the window is maximized, if that is the case we access the Client's `keepAbove`
property which is a boolean. If the Client is keep above we append the Client to our global array
`keepAboveMaximized` of Clients we modified. This is important to be able to reset the keep above state
when the window gets restored again.

Last but not least we have to remove keep above which is a simple assignment to the Client's property.
If you want to test it in the desktop scripting console remember to adjust the signal connection: 

```javascript
workspace.clientMaximizeSet.connect(manageKeepAbove);
```

### Restoring it all

Now the last and most important part of it all. Whenever the client is restored, we must set it’s `‘Keep Above’`
property if it was set earlier. To do this, we must simply extend our manageKeepAbove code to handle this
scenario. In case the client is not maximized both vertically and horizontally, we check if the client is
in our keepAboveMaximized array and if it is, we set its ‘Keep Above’ property, otherwise we don’t bother:

```javascript
function manageKeepAbove(client, h, v) {
  if (h && v) {
    // maximized
    if (client.keepAbove) {
      keepAboveMaximized[keepAboveMaximized.length] = client;
      client.keepAbove = false;
    }
  } else {
    // no longer maximized
    var found = keepAboveMaximized.indexOf(client);
    if (found != -1) {
      client.keepAbove = true;
      keepAboveMaximized.splice(found, 1);
    }
  }
}
```

In the end, our entire script looks like:

```javascript
var keepAboveMaximized = new Array();

function manageKeepAbove(client, h, v) {
  if (h && v) {
    // maximized
    if (client.keepAbove) {
      keepAboveMaximized[keepAboveMaximized.length] = client;
      client.keepAbove = false;
    }
  } else {
    // no longer maximized
    var found = keepAboveMaximized.indexOf(client);
    if (found != -1) {
      client.keepAbove = true;
      keepAboveMaximized.splice(found, 1);
    }
  }
}

workspace.clientMaximizeSet.connect(manageKeepAbove);
```

### What next?

The script is of course very simple. It does not take care of windows which are already present when the
window manager starts. It might be an idea to restrict the script to some window classes (e.g. video
players). It's up to you.

## Publishing

Once you have created something nice, consider sharing it with other Plasma users! Create a zip file of the package folder `myscript`, and upload it to the [KDE Store](https://store.kde.org) under the category Linux/Unix Desktops > Window Managers > KWin > KWin scripts. Users will then be able to find and install your script with Discover or via “Get New Scripts…” in System Settings.
