---
title: KWin Scripting Tutorial
weight: 4
description: Learn how to programmatically manipulate windows with KWin scripts.
---

## Quick Start: Desktop Console

The easiest way to test KWin scripts is to use the Plasma Desktop
Scripting Console which can be opened via the KRunner window (Alt+F2,
by default, or via the "Run Command" entry in various desktop menus)
by entering "wm console" as the search term. It can be triggered directly
via dbus with:

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

## Packaging KWin Scripts

In order to have KWin load a script on each session start the script has to
be packaged. KWin Scripts use the [KPackage](https://api.kde.org/frameworks/kpackage/html/)
format. In the metadata.desktop file of the package the value for `X-KDE-ServiceTypes`
has to be `KWin/Script`, as `X-Plasma-API` only javascript and declarativescript are supported.

A packaged KWin Script can either be installed via the KWin Script KCM (note: the list
does not yet reload after installing a script) or with the plasmapkg tool:

```bash
plasmapkg2 --type kwinscript -i /path/to/myscript.js
```

## Where can I find example scripts?

A few KWin Scripts are shipped directly with the window manager. You can find those in your
system installation. Just use plasmapkg to get a list of the available scripts:

```bash
plasmapkg2 -t kwinscript -l -g
```

The scripts can be found in the data install path of your local KDE installation
under "kwin/scripts". E.g. in `/usr/share/kwin/scripts/` and `~/.local/share/kwin/scripts/`.

Additionally you can find the scripts in the [KWin](https://invent.kde.org/plasma/kwin/-/tree/master/src/scripts)
repository.

## KWin scripting basics

To follow this tutorial, you must have some idea about [ECMAScript](http://en.wikipedia.org/wiki/ECMAScript)
(or [JavaScript](http://en.wikipedia.org/wiki/JavaScript)). A quick introduction can be found
in the [Plasma scripting tutorial](https://develop.kde.org/docs/plasma/scripting/).

KWin Scripts can either be written in [javascript](https://doc.qt.io/qt-5/topics-scripting.html#js-api)
(service type "javascript") or [QML](https://doc.qt.io/qt-5/qtqml-index.html) (service type "declarativescript").
In order to develop KWin Scripts you should know the basic concepts of [signals and properties](https://doc.qt.io/qt-5/signalsandslots.html).

### Global Objects and Functions

KWin Scripts can access two global properties workspace and options. The workspace object
provides the interface to the core of the window manager, the options object provides read
access to the current configuration options set on the window manager. To get an overview
of what is available, please refer to the [API documentation](api).

The following global functions are available to both QML and JavaScript:

* `print(QVariant...):` prints the provided arguments to stdout. Takes an arbitrary number
of arguments. Comparable to `console.log()` which should be preferred in QML scripts.

* `readConfig(QString key, QVariant defaultValue=QVariant())`: reads a config option of the
KWin Script. First argument is the config key, second argument is an optional default value
in case the config key does not exist in the config file.

## Clients

The window manager calls a window it manages a "Client". Most methods of workspace operating
on windows either return a Client or require a Client. Internally the window manager supports
more types of windows, which are not clients. Those windows are not available for KWin Scripts,
but for KWin Effects. To have a common set of properties some properties and signals are
defined on the parent class of Client called Toplevel. Be sure to check the documentation of
that class, too when looking for properties. Be aware that some properties are defined as
read-only on Toplevel, but as read-write on Client.

The following examples illustrates how to get hold of all clients managed by the window manager
and prints the clients' caption:

```js
const clients = workspace.clientList();
for (var i = 0; i < clients.length; i++) {
  print(clients[i].caption);
}
```

The following example illustrates how to get informed about newly managed clients and prints out
the window id of the new client:

```js
workspace.clientAdded.connect(function(client) {
  print(client.windowId);
});
```

To understand which parameters are passed to the event handlers (i.e. the functions we connect to),
one can always refer the [API documentation](api).

## Your first (useful) script

In this tutorial we will be creating a script based on a suggestion by Eike Hein. In Eike’s words:
“A quick use case question: For many years I’ve desired the behavior of disabling keep-above on a
window with keep-above enabled when it is maximized, and re-enabling keep-above when it is restored.
Is that be possible with kwin scripting? It’ll need the ability to trigger methods on state changes
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

```js
var keepAboveMaximized = [];
```

Now we need to know whenever a window got maximized. There are two approaches to achieve that: either
connect to a signal emitted on the workspace object or to a signal of the client. As we need to track
all Clients it is easier to just use the signal *clientMaximizeSet* on the workspace. This signal is
emitted whenever the maximization state of a Client changes and passes the client and two boolean
flags to the callback. The flags indicate whether the Client is maximized horizontally and/or
vertically. If a client is maximized both horizontally and vertically it is considered as fully
maximized. Let's try it:

```js
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

```js
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

```js
workspace.clientMaximizeSet.connect(manageKeepAbove);
```

### Restoring it all

Now the last and most important part of it all. Whenever the client is restored, we must set it’s `‘Keep Above’`
property if it was set earlier. To do this, we must simply extend our manageKeepAbove code to handle this
scenario. In case the client is not maximized both vertically and horizontally, we check if the client is
in our keepAboveMaximized array and if it is, we set its ‘Keep Above’ property, otherwise we don’t bother:

```js
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

```js
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

Once you have created something nice, consider sharing it with other [Plasma users](https://store.kde.org)!
