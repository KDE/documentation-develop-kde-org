---
title: "Tips and tricks"
description: "Improve your kde-builder experience"
weight: 14
group: "kde-builder"
aliases: kdesrc-build-tips
---

## Opening logs directly from Konsole / Yakuake {#directlogs}

Konsole and Yakuake, two terminal applications by KDE, have the ability to open files by clicking directly on their path on the screen.

For example, if you build Kirigami using kde-builder and you happen to face an error like this:

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

## Faster compile times

It is possible to change various CMake options globally in kde-builder so that projects will build faster, which is convenient especially for building KDE software on weaker machines. By setting these options globally, if you ever need them enabled for a specific project, you can then use [kde-builder config overrides](https://kde-builder.kde.org/en/configuration/config-file-overview.html#overriding-configuration).

{{< alert title="⚠️ Tread with caution" color="warning" >}}

Disabling certain CMake options, while providing build speed improvements, can make major changes to your build, most notably CMAKE_BUILD_TYPE and BUILD_TESTING. You should be aware of these customizations and mention them whenever you request for assistance from other developers.

{{< /alert >}}

These options can be set in the global section of your `~/.config/kde-builder.yaml`, under `cmake-options`, for example:

```yaml
cmake-options: -DOPTION=OFF -DANOTHER_OPTION=value2
```

Or with multiline:

```yaml
cmake-options: >
  -DOPTION=OFF
  -DANOTHER_OPTION=value
```

Then, at the end of the file, you can set overrides for each individual option that go against the global `cmake-options` values:

```yaml
override kirigami:
  cmake-options: -DOPTION=ON
```

If it is a custom project (not a KDE project), you can use `project` instead:

```yaml
project kirigami-tutorial:
  cmake-options: -DOPTION=ON
```

### Faster iterative compiling with Debug mode

By default, kde-builder compiles projects in `RelWithDebInfo` mode, that is, Release with Debug Info.

You might want to set it to Debug mode which is optimal for iterative compilation:

```yaml
cmake-options: >
  -DCMAKE_BUILD_TYPE=Debug
```

### Building without tests

All KDE projects that use extra-cmake-modules have [tests set to build by default](https://api.kde.org/ecm/kde-module/KDECMakeSettings.html#testing) together with the main project. This ensures that developers catch bugs easily and quickly, but it also takes significant time when building dozens of modules.

```yaml
cmake-options: >
  -DBUILD_TESTING=OFF
```

### Building without docs

KDE projects can make use of multiple ways of generating documentation: [Qt Help projects (.qhp) and compressed Qt Help files (.qch)](https://doc.qt.io/qt-6/qthelp-framework.html), [Doxygen HTML or manpages](https://www.doxygen.nl/), Sphinx, and recently QDoc. The first two can be globally disabled, although the speed improvements are not as significant as the build type or tests.

```yaml
cmake-options: >
  -DBUILD_QTHELP_DOCS=OFF
  -DBUILD_QCH=OFF
  -DBUILD_HTML_DOCS=OFF
  -DBUILD_MAN_DOCS=OFF
```

### Building with ccache or sccache

Compiler cache, or `ccache`, can be used to increase build speed only when recompiling projects.

Running it your first time building KDE projects will not make any difference whatsoever, and even subsequent runs will only see some improvement. Where `ccache` excels at is when switching between different branches, stashes, rebases or bisects and recompiling repeatedly, that is to say, when you are developing a patch.

{{< alert title="⚠️ Tread with caution" color="warning" >}}

There are certain caveats that you must be aware when using `ccache`, most notably that you can have compilation failures caused specifically by ccache, and that lookup in large caches can actually make compilation slower. See [Ccache caveats on the Arch wiki](https://wiki.archlinux.org/title/Ccache#Caveat).

While you will still likely perceive some improvement by setting this globally, you might prefer to override each individual project you are likely to work on instead to minimize these issues.

Before reporting compilation issues, disable this option for the project you are working on.

{{< /alert >}}

To use `ccache` you will first need to install it.

```yaml
cmake-options: >
  -DCMAKE_C_COMPILER_LAUNCHER=ccache
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
```

If you prefer, you may also want to experiment with [sccache](https://github.com/mozilla/sccache), a newer alternative to accomplish the same job:

```yaml
cmake-options: >
  -DCMAKE_C_COMPILER_LAUNCHER=sccache
  -DCMAKE_CXX_COMPILER_LAUNCHER=sccache
```
