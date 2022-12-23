---
title: Toolbar
weight: 6
---

Desktop
-------

<video src="https://cdn.kde.org/hig/video/20201125/Toolbar1.webm" 
    loop="true" playsinline="true" width="800" controls="true" 
    onended="this.play()" class="border"></video>

Toolbar with the most common actions and a menu button for additional
actions

-   Use Toolbar + Menu Button command pattern when the number of
    frequently used commands are about 8 or less, and the remaining
    commands are not essential to performing the primary task of the
    application. The toolbar pattern exposes the frequently used
    commands. The menu button pattern exposes more of the command
    structure.
-   Commands are also exposed using context menus, a context panel or by
    the direct manipulation of content.

See [toolbar]({{< relref "toolbar" >}}) for more details.

### Examples

Web browser, File manager, Text editor, Email, Calendar, Image editor,
Music player, Archiver

Mobile
------

![Toolbar](/hig/Actionbutton2.png)

On mobile, a toolbar is displayed as a group of
[primary action buttons]({{< relref "actionbutton" >}}).

-   If there are controls that need to be accessed often within the
    application\'s primary tasks but the content needs as much space to
    be available as possible, you can add up to three primary action
    buttons.
-   The primary action buttons are at the bottom of the user interface
    and there cannot be more then three buttons.
-   If more than three actions are required, put the remaining ones in
    the
    [global drawer]({{< relref "globaldrawer" >}}) or 
    [context drawer]({{< relref "contextdrawer" >}}).
