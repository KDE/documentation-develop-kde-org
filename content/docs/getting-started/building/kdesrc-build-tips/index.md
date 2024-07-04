---
title: "Tips and tricks"
description: "Improve your kdesrc-build experience"
weight: 14
group: "kdesrc-build"
---

## Opening logs directly from Konsole / Yakuake {#directlogs}

Konsole and Yakuake, two terminal applications by KDE, have the ability to open files by clicking directly on their path on the screen.

For example, if you build Kirigami using kdesrc-build and you happen to face an error like this:

```
<<<  PACKAGES FAILED TO BUILD  >>>
kirigami - /home/youruser/kde/src/log/2024-03-17-01/kirigami/build.log
```

Clicking on the file path text will open the log file with your preferred text editor.

To enable this functionality in Konsole or Yakuake:

Right click the terminal -> Edit Current Profile... -> Mouse -> Miscellaneous -> enable Underline Files.

## Colorizing build logs correctly in Kate

By default, when you open a `.log` file in Kate, its syntax will be highlighted as "Log File (simplified)".  
The mode "Log File (advanced)" applies full syntax highlighting which makes it easier to read log files.

There are two ways to change from simplified to advanced mode:

* Through the menu: **Tools | Highlighting | Other | Log File (advanced)**
* Through the syntax highlighting button at the bottom right of Kate (where it says "Log File (simplified)")

To avoid applying this manually each time you open log file, change the priority of the Filetype:

In the main menu, go to **Settings | Configure Kate**. In the _Configure Kate_ window choose
**Open/Save | Modes & Filetypes**. In the Filetype dropdown list:
- select _Other/Log File (advanced)_ and set its _Priority_ to "-10"
- select _Other/Log File (simplified)_ and set its _Priority_ to "-11"

Apply changes and close the window.

## Viewing colored build logs

The log files include escape symbols (that are used to color the text, or format it as bold for example). To view it properly, you will need to open the log with a suitable tool.

There are two main possibilities for this:

1. Opening the log files with your preferred text editor.

Any editor that does syntax highlighting for `.log` files will do. KDE provides Kate / KWrite, which has both "Log File (simple)" and "Log File (advanced)" highlighting options selectable from the bottom right of the window.

Sublime Text has the [ANSI color](https://github.com/aziz/SublimeANSI) plugin.

This method also works with the above tip [Open logs directly with Konsole / Yakuake]({{< ref "#directlogs" >}}).

2. Opening the log files with a terminal application.

You can view log files with a terminal application like `cat` or [bat](https://github.com/sharkdp/bat).

## Preventing accidental src/ folder deletion

When you want to start the whole build from scratch, by deleting your `~/kde/build` and `~/kde/usr`, you may accidentally delete your `~/kde/src`. To protect yourself from that, you [can set the immutable flag to that directory](https://wiki.archlinux.org/title/File_permissions_and_attributes#File_attributes):

```
sudo chattr +i ~/kde/src
```

Now you have write permissions to the folder, but you cannot delete it.
