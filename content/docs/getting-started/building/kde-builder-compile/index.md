---
title: "Building KDE software with kde-builder"
description: "Compiling with a single command"
weight: 11
group: "kde-builder"
aliases: kdesrc-build-compile
---

{{< alert color="warning" title="⚠️ kdesrc-build is no longer supported" >}}

</br>
<details>
<summary>Click to see more information</summary></br>

[kdesrc-build](https://invent.kde.org/sdk/kdesrc-build),
the tool that was used previously for this tutorial, is no longer supported.

While the tool is stable and still works for our veteran developers, if you are starting out with KDE development now, we recommend that you switch to
[kde-builder](https://kde-builder.kde.org/). Once you run it for the first time after installation, it will ask whether you want to migrate your existing `kdesrc-buildrc` configuration file to the new `kde-builder.yaml` [file](https://kde-builder.kde.org/en/configuration/config-file-overview.html).

Any support questions related to this tutorial can be asked on the
[KDE New Contributors](https://go.kde.org/matrix/#/#new-contributors:kde.org) group on
[Matrix](https://community.kde.org/Matrix).

See also [Where to find the development team]({{< ref "help-developers" >}}).

</details>

{{< /alert >}}

On this page, you will learn how to use KDE's `kde-builder` tool to build various types of KDE software once you have a development environment set up.

If you haven't set up kde-builder already, please follow the steps in [Set up a development environment]({{< ref "kde-builder-setup" >}}) before proceeding.

It can take an hour or more to compile a KDE application, Framework, or Plasma itself for the first time. The reason for this is that `kde-builder` by default has the [flag](https://kde-builder.kde.org/en/configuration/conf-options-table.html#conf-include-dependencies) `--include-dependencies` enabled, so it will ignore all KDE packages that were installed using the distribution's package manager and will instead build from source all KDE modules that are dependencies of the module you told it to build. The next time you want to compile that or any other piece of KDE software, it will be much faster since most of the dependencies will have already been compiled.

If you don't want to build all dependencies (for instance if you are using a rolling release distro that provides recent versions of software), you can:

* edit the [configuration file](https://kde-builder.kde.org/en/configuration/config-file-overview.html) `~/.config/kde-builder.yaml` and set `include-dependencies: false`
* or add the `--no-include-dependencies` [flag](https://kde-builder.kde.org/en/cmdline/supported-cmdline-params.html#cmdline-include-dependencies) when running `kde-builder`

## Frameworks

[KDE Frameworks](https://community.kde.org/Frameworks) are libraries of tools and features that can be used by any application or Plasma itself. A list of all of the frameworks can be found in the [KDE Frameworks API documentation](https://api.kde.org/frameworks).

If you want to build a certain library from KDE Frameworks, simply run `kde-builder` followed by the name of the library. For example:

```bash
kde-builder kirigami
```

When you tell kde-builder to build a module, it will automatically git clone, configure, build and install the KDE Frameworks that are required by that module.

## Applications

[KDE Applications](https://apps.kde.org/) like [KCalc](https://apps.kde.org/kcalc ), [Dolphin](https://apps.kde.org/dolphin/), [Okular](https://apps.kde.org/okular/), [Konsole](https://apps.kde.org/konsole/) and [Gwenview](https://apps.kde.org/gwenview/) are standalone apps that can be run on multiple platforms, such as Plasma, GNOME, even macOS and Windows!

Note that the Discover app store (git repo name: `plasma-discover`) and System Settings app (git repo name: `systemsettings`) are distributed together with Plasma, but they build like standalone apps using the below instructions. A list of all KDE applications can be found in the [KDE Apps website](https://apps.kde.org/).

To build a single app like KCalc, all you need to do is run:

```bash
kde-builder kcalc
```

This command clones the KDE git repository https://invent.kde.org/utilities/kcalc into the directory `~/kde/src/kcalc`, builds all of KCalc's KDE dependencies, and then builds KCalc itself into `~/kde/build/kcalc`. If the build is successful, the result is installed into `~/kde/usr`. As a result, *there is no need to manually install anything;* `kde-builder` installed it for you!

If the build failed for any reason, please see our instructions on how to proceed with [Basic Troubleshooting]({{< ref "kde-builder-failure" >}}).

To run the self-compiled KCalc, use the `kde-builder --run` command, which launches the built-from-source version of KCalc (from the directory `~/kde/usr`) instead of the version installed using the package manager from your operating system (from the directory `/usr`).

```bash
kde-builder --run kcalc
```

Did it run? If so, then **congratulations, you just compiled your own version of KCalc from source code!** 🎉

## Plasma

[KDE Plasma](https://community.kde.org/Plasma) is the environment in which you can run apps. Plasma is responsible for providing a desktop with wallpaper, app launchers, and widgets; displaying notifications; managing wired and wireless networks; and similar operating-system level tasks.

Plasma has multiple *shells*: [Plasma Desktop](https://kde.org/plasma-desktop) for desktop, laptop, and 2-in-1 computers, [Plasma Mobile](https://www.plasma-mobile.org/) for mobile phones and [Plasma Bigscreen](https://plasma-bigscreen.org/) for televisions. They all share certain common components, such as a window manager, networking stack, basic graphical components, and so on. These shared components are found in [Plasma Workspace](https://invent.kde.org/plasma/plasma-workspace).

### Plasma Desktop

To build the Plasma Desktop environment and all its necessary dependencies, run the following command:

```bash
kde-builder workspace
```

`workspace` is an alias that lets you automatically build the projects necessary to run a full Plasma Desktop session. It is different from `plasma-workspace`, which is only one component among many necessary to build Plasma.

Once built, you can make an entire built-from-source Plasma session accessible from the SDDM login screen. This is a good way to test core Plasma components.

It's also necessary for kde-builder to install the necessary session files and D-Bus files into a root directory.
After the biuld process is finished, kde-builder will prompt you for your password so it can install the session files.

{{< alert color="info" title="⏳ With kdesrc-build..." >}}

<details>
<summary>Click here to know how this was done with kdesrc-build</summary></br>

This step used to be done by manually running a script in `plasma-workspace`.

```bash
bash ~/kde/build/plasma-workspace/login-sessions/install-sessions.sh
```

</details>

{{< /alert >}}

{{< alert title="About SELinux" color="info" >}}

SELinux can interfere with the new D-Bus services working correctly, and the path of least resistance may be to simply turn off enforcement if you are using a distro that ships with it on by default (for example, Fedora). To do this, set the value of `SELINUX` to `permissive` in the file `/etc/selinux`.

{{< /alert >}}

After this, you can log out and select your new Plasma session in SDDM's session chooser menu (located in the bottom-left corner of the screen if you're using the Breeze SDDM theme).

Alternatively, you can run the new version of Plasma on top of your existing system for quick testing like so:

```bash
source ~/kde/build/plasma-workspace/prefix.sh
~/kde/usr/bin/plasmashell --replace
```

### Plasma Mobile

To build the Plasma Mobile environment, run the following command:

```
kde-builder mobile
```

You can run your custom-built Plasma Mobile in an emulated phone session using a phone-sized window within your existing desktop.

Note that you probably want that this emulated phone session does not use the settings of your current user. For example, your emulated phone session should use Angelfish as the default browser, not Mozilla Firefox. To do so, you can run the following on a terminal:

```bash
export XDG_RUNTIME_DIR=/tmp/
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=KDE
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XDG_CURRENT_DESKTOP=KDE
export KSCREEN_BACKEND=QScreen
export KDE_FULL_SESSION=1
export KDE_SESSION_VERSION=5
export QT_QUICK_CONTROLS_MOBILE=1
export PLASMA_PLATFORM=phone:handheld
export $(dbus-launch)
```

Then you can source the Plasma Mobile prefix to load the development environment and run Plasma Mobile in a nested KWin window:

```bash
source ~/kde/build/plasma-mobile/prefix.sh
dbus-run-session kwin_wayland --width 360 --height 720 --xwayland "plasmashell -p org.kde.plasma.mobileshell"
```

Plasma Mobile can also be run on a mobile device itself. For more information, see the [Plasma Mobile Development Guide](https://community.kde.org/Plasma/Mobile/DevGuide#Mobile_device_running_plasma_mobile).

## Building custom projects

Sometimes you want to build your own project using kde-builder, or you'd like to build with a fork of an existing KDE project.

To do this, you can use kde-builder's
[project](https://kde-builder.kde.org/en/configuration/config-file-overview.html#project-configuration) configuration option.

### New projects

If your project is completely new, like in the case of the
[Kirigami]({{< ref "introduction-getting_started/#kde-builder" >}}) or
[KXmlGui]({{< ref "hello_world/#kde-builder" >}})
tutorials, you can create a `project` at the end of your `~/.config/kde-builder.yaml`:

```yaml
project kirigami-tutorial:
  no-src: true
```

Then you may use `kde-builder` to compile the dependencies needed for your project, and after that your project:

```bash
kde-builder kirigami ki18n kcoreaddons breeze kiconthemes qqc2-desktop-style
kde-builder kirigami-tutorial
```

### Project forks

If your project is a fork of an existing KDE project, you can build it with `kde-builder`.

To do so, you need to clone it to `~/kde/src`. For example, if you want to work on Dolphin:

```bash
git clone git@invent.kde.org:your-user/dolphin.git ~/kde/src/dolphin-fork
```

Then add a `project` at the end of your `~/.config/kde-builder.yaml`:

```yaml
project dolphin-fork:
  no-src: true
```

After that, you can build the original project just to compile the same build dependencies, and lastly build your fork:

```bash
kde-builder dolphin
kde-builder dolphin-fork
```

## Useful flags

Congratulations! You have seen how to:

* compile standalone apps: `kde-builder kcalc`
* compile Plasma Desktop: `kde-builder workspace`
* compile Plasma Mobile: `kde-builder mobile`
* run what you've built: `kde-builder --run kcalc`

Now it is possible for you to make changes to the code of the program you want to work on, then simply rebuild the project so it displays your changes.

In this case, it's useful to know a few commonly used flags for kde-builder.

### Check the list of things that will be built

To get a general idea of how many and which programs are going to be built for a certain project, you can use the `--pretend` or `--dry-run` flag:

```bash
kde-builder --pretend kcalc
```

### Rebuild the current project and stay on current branch

Code changes should be done in a separate git branch, not in the `master` branch.

By default, kde-builder will always attempt to go back to the `master` branch before rebuilding. To avoid this, you can use the `--no-src` flag:

```bash
kde-builder --no-src kcalc
```

### Rebuild only a single project without updating the source code

As mentioned above, there are times when you want to rebuild the project in the current branch.

By default, kde-builder will rebuild a project and all its dependencies. To avoid this, you can use the `--no-include-dependencies` flag:

```bash
kde-builder --no-include-dependencies --no-src kcalc
```

### Build a specific project while skipping certain modules

Sometimes a particular program somewhere down the dependency chain fails to build and isn't strictly required for a certain project to compile properly, or sometimes you want to use the program installed from your distribution.

In that case, you can avoid building a project by using the `--ignore-projects` flag, which should come after the module name:

```bash
kde-builder kcalc --ignore-projects gpgme
```

### Specifying executable names when running

To run an application, simply use the flag `--run`.

```bash
kde-builder --run plasma-discover
```

Note that in Discover's case, the name of the project is `discover`, but the name of the executable is `plasma-discover`.

If a project provides more than one executable, you can specify the executable you want as long as you have built the module that provides it:

```bash
kde-builder kate
kde-builder --run kate-syntax-highlighter --list-themes
```

{{< alert color="info" title="⏳ With kdesrc-build..." >}}

<details>
<summary>Click to know how this was done with kdesrc-build</summary></br>

In some modules, the build process will result in an executable that does not match the module name: for example, the module `discover` does not match the executable `plasma-discover`. Because kdesrc-build had no way to associate the name of the project with the executable name, you needed to use the `--exec` or `-e` flag:

```bash
kdesrc-build --run --exec plasma-discover discover
```

Without this flag, attempting to run the application will result in an error similar to:

```
Executable "discover" does not exist.
Try to set executable name with -e option.
```

</details>

{{< /alert >}}

### Running an application after making changes to one of its dependencies

Let's say you want to make a change to the KConfig library that should change a behavior in KCalc. In this case, you don't want kde-builder to discard your changes to KConfig. So first build KConfig separately, on its own, without doing a source code update:

```bash
kde-builder kconfig --no-src --no-include-dependencies --refresh-build
```

This will build just KConfig and install the needed build products into `~/kde/usr`. Now we want to run KCalc in such a way that it makes use of those changed files. Do it like so:

```bash
kde-builder kcalc --no-src --no-include-dependencies --refresh-build
kde-builder --run kcalc
```

## Next Steps

Now you can compile anything in KDE from its source code! Time to think about what to do with this superpower...

Perhaps you went through this whole procedure and still have no idea what to work on:

[Choose what to work on]({{< ref "help-choosing" >}})

Or perhaps you'd like to further adapt kde-builder to your needs by setting up your preferred IDE. If that's what you need, you can visit the following section:

[IDE Configuration]({{< ref "ide" >}})

If you already know what you want to work on and you are in fact already working on it, then it might be time to learn how to make a merge request and send your changes:

[Submit your new software changes for review](https://community.kde.org/Infrastructure/GitLab#Submitting_a_merge_request)
