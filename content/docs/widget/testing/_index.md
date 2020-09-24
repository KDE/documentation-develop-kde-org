---
title: "Testing"
weight: 2
description: >
  How to quickly test a plasma widget
---

## plasmawindowed

There are 3 ways to test a widget.

1. `plasmawindowed` can be used if the widget is installed to:  
  `~/.local/share/plasma/plasmoids`  
  It will remember any changes you make to the config as this is the same command used for "Windowed widgets" like the "Calculator" app. It has limited features for displaying the widget, but the command should be preinstalled.
2. `plasmoidviewer`, explained further down, can display a widget as a desktop widget, or a panel widget. You can also test a widget that is not yet installed. You will need to first install the `plasma-sdk` package to use it.
3. Install the widget and add it to your panel. Restarting plasma every time using:  
  `plasmashell --replace`  
  I only recommend this testing method for a final test as it takes a few seconds for the panel to load.

```bash
plasmawindowed --help
```
```log
Usage: plasmawindowed [options] applet [args...]
Plasma Windowed

Options:
  --statusnotifier  Makes the plasmoid stay alive in the Notification Area,
                    even when the window is closed.
  -v, --version     Displays version information.
  -h, --help        Displays this help.

Arguments:
  applet            The applet to open.
  args              Arguments to pass to the plasmoid.
```



## plasmoidviewer

With `metadata.desktop` and `main.qml`, we now have enough to test our widget. If you haven't yet, install the `plasma-sdk` package with `sudo apt install plasma-sdk`.

```bash
plasmoidviewer --help
```
```log
Usage: plasmoidviewer [options]
Run Plasma widgets in their own window

Options:
  -v, --version                    Displays version information.
  -c, --containment <containment>  The name of the containment plugin
  -a, --applet <applet>            The name of the applet plugin
  -f, --formfactor <formfactor>    The formfactor to use (horizontal, vertical,
                                   mediacenter, planar or application)
  -l, --location <location>        The location constraint to start the
                                   Containment with (floating, desktop,
                                   fullscreen, topedge, bottomedge, leftedge,
                                   rightedge)
  -x, --xPosition <xPosition>      Set the x position of the plasmoidviewer on
                                   the plasma desktop
  -y, --yPosition <yPosition>      Set the y position of the plasmoidviewer on
                                   the plasma desktop
  -s, --size <widthXheight>        Set the window size of the plasmoidview
  -p, --pixmapcache <size>         The size in kB to set the pixmap cache to
  -t, --theme <themeName>          The name of the theme which the shell will
                                   use
  -h, --help                       Displays this help.
```


## Test as Desktop Widget

Note that `--location=desktop` is used for the desktop wallpaper, not desktop widgets. Desktop widgets use `--location=floating`.

```bash
plasmoidviewer -a package --location=floating --formfactor=planar
plasmoidviewer -a package -l=floating -f=planar
plasmoidviewer -a package # floating+planar is the default.
````

## Test as Horizontal Panel Widget

If we set `plasmoidviewer`'s `plasmoid.formFactor` to be `horizontal` and `plasmoid.location` to the `topedge` or `bottomedge`, we can test a widget focusing in the panel.

```bash
plasmoidviewer -a package -l topedge -f horizontal
```

## Testing DPI Scaling

By setting the `QT_SCALE_FACTOR=2` we can double the DPI value from `96` to `192` just for the `plasmoidviewer` window. This is great for testing if your code will support a HiDPI screen.

If you're testing a very high DPI, you'll probably find the default `plasmoidviewer` window is too small to show the widget, so we'll set the size and position of the window. Note that the window will go maximized if you set a size larger than you screen has available.
{% endcapture %}{% capture sectionRight %}

```bash
QT_SCALE_FACTOR=2 plasmoidviewer -a package
QT_SCALE_FACTOR=2 plasmoidviewer -a package -l topedge -f horizontal -x 0 -y 0 -s 1920x1080
```

## Enable logging

By default in Qt 5.9, `console.log()`, which used to write a string to stdout (the Terminal output), is hidden by default. In order to reenable it, we need to set `[Rules] qml.debug=true` in `~/.config/QtProject/qtlogging.ini`. You can easily set it by running this `kwriteconfig5` command:  

```bash
kwriteconfig5 --file ~/.config/QtProject/qtlogging.ini --group "Rules" --key "qml.debug" "true"
```

```qml
// main.qml
Item {
    Component.onCompleted: {
        console.log("Hello World")
    }
}
```
```ini
# ~/.config/QtProject/qtlogging.ini
[Rules]
qml.debug=true
```
