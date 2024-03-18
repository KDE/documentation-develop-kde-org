---
title: "Tips and tricks"
description: "Improve your kdesrc-build experience"
weight: 14
group: "kdesrc-build"
---

## Opening logs directly with Konsole / Yakuake {#directlogs}

Konsole and Yakuake, two terminal applications by KDE, have the ability to open files by clicking directly on their path on the screen.

For example, if you build Kirigami using kdesrc-build and you happen to face an error like this:

```
<<<  PACKAGES FAILED TO BUILD  >>>
kirigami - /home/youruser/kde/src/log/2024-03-17-01/kirigami/build.log
```

Clicking on the file path text will open the log file with your preferred text editor.

To enable this functionality in Konsole or Yakuake:

Right click the terminal -> Edit Current Profile... -> Mouse -> Miscellaneous -> enable Underline Files.

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
