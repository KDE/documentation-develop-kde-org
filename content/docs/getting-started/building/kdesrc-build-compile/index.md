---
title: "Building KDE software with kdesrc-build"
description: "Compiling with a single command"
weight: 11
group: "kdesrc-build"
---

On this page, you will learn how to use KDE's `kdesrc-build` tool to build various types of KDE software once you have a development environment set up.

It can take an hour or more to compile a KDE application, Framework, or Plasma itself for the first time. The reason for this is that `kdesrc-build` by default has the option `--include-dependencies` enabled, so it will ignore all KDE packages that were installed using the distribution's package manager and will instead build from source all KDE modules that are dependencies of the module you told it to build. The next time you want to compile that or any other piece of KDE software, it will be much faster since most of the dependencies will have already been compiled.

If you don't want to build all dependencies (for instance if you are using a rolling release distro that provides recent versions of software), you can:

* edit the configuration file `~/.config/kdesrc-buildrc` and set `include-dependencies false`
* or add the `--no-include-dependencies` option when running `kdesrc-build`

## Frameworks

[KDE Frameworks](https://community.kde.org/Frameworks) are libraries of tools and features that can be used by any application or Plasma itself. A list of all of the frameworks can be found here: https://api.kde.org/frameworks.

There is no reason to build any of the frameworks manually unless you are working on code changes to a specific one.

When you tell kdesrc-build to build a module, kdesrc-build will automatically git clone, configure, build and install the KDE Frameworks that are required by that module.

## Applications

[KDE Applications](https://apps.kde.org/) like [KCalc](https://apps.kde.org/kcalc ), [Dolphin](https://apps.kde.org/dolphin/), [Okular](https://apps.kde.org/okular/), [Konsole](https://apps.kde.org/konsole/) and [Gwenview](https://apps.kde.org/gwenview/) are standalone apps that can be run on multiple platforms, such as Plasma, GNOME, even macOS and Windows!

Note that the Discover app store (git repo name: `plasma-discover`) and System Settings app (git repo name: `systemsettings`) are distributed together with Plasma, but they build like standalone apps using the below instructions. A list of all KDE applications can be found here: https://apps.kde.org/.

To build a single app like KCalc, all you need to do is run:

```bash
kdesrc-build kcalc
```

This command clones the KDE git repository https://invent.kde.org/utilities/kcalc in the directory `~/kde/src/kcalc`, builds all of KCalc's KDE dependencies, and then builds KCalc itself into `~/kde/build/kcalc`. If the build is successful, the result is installed into `~/kde/usr`. As a result, *there is no need to manually install anything;* `kdesrc-build` installed it for you!

If the build failed for any reason, please see our instructions on how to proceed with [Basic Troubleshooting]({{< ref "kdesrc-build-failure" >}}).

To run it, use the `kdesrc-build --run` command, which launches the built-from-source version of KCalc (from the directory `~/kde/usr`) instead of the version installed using the package manager from your operating system (from the directory `/usr`).

```bash
kdesrc-build --run kcalc
```

Did it run? If so, then **congratulations, you just compiled your own version of KCalc from source code!** 🎉

## Plasma

[KDE Plasma](https://community.kde.org/Plasma) is the environment in which you can run apps. Plasma is responsible for providing a desktop with wallpaper, app launchers, and widgets; displaying notifications; managing wired and wireless networks; and similar operating-system level tasks.

Plasma has multiple *shells*: [Plasma Desktop](https://kde.org/plasma-desktop) for desktop, laptop, and 2-in-1 computers, [Plasma Mobile](https://www.plasma-mobile.org/) for mobile phones and [Plasma Bigscreen](https://plasma-bigscreen.org/) for televisions. They all share certain common components, such as a window manager, networking stack, basic graphical components, and so on. These shared components are found in [Plasma Workspace](https://invent.kde.org/plasma/plasma-workspace).

### Plasma Desktop

To build the Plasma Desktop environment and its related apps, run the following command:

```bash
kdesrc-build workspace
```

Once built, you can make an entire built-from-source Plasma session accessible from the SDDM login screen. This is a good way to test core Plasma components. It's also necessary to copy the built-from-source DBus files into a location where they are visible to the system bus. To perform these actions, run the following command:

```bash
~/kde/build/plasma-workspace/login-sessions/install-sessions.sh
```

{{< alert title="Note" color="info" >}}

In KDE Builder, this is done automatically. See https://kde-builder.kde.org/en/using-kde-builder/advanced-features.html#installing-login-session.

{{< /alert >}}

{{< alert title="Note" color="info" >}}

SELinux can interfere with the new DBus services working correctly, and the path of least resistance may be to simply turn off enforcement if you are using a distro that ships with it on by default (for example, Fedora). To do this, set the value of `SELINUX` to `permissive` in the file `/etc/selinux`.

{{< /alert >}}

After this, you can log out and select your new Plasma session in SDDM's session chooser menu (located in the bottom-left corner of the screen if you're using the Breeze SDDM theme).

Alternatively, you can run the new version of Plasma on top of your existing system for quick testing like so:

```bash
source ~/kde/build/plasma-workspace/prefix.sh
~/kde/usr/bin/plasmashell --replace
```

Take note of [known issues with built-from-source dev sessions](https://community.kde.org/Plasma/Plasma_6#Known_issues).

### Plasma Mobile

To build the Plasma Mobile environment, run the following command:

```
kdesrc-build mobile
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

## Useful flags

Congratulations! You have seen how to:

* compile standalone apps: `kdesrc-build kcalc`
* compile Plasma Desktop: `kdesrc-build workspace`
* compile Plasma Mobile: `kdesrc-build mobile`
* run what you've built: `kdesrc-build --run kcalc`

Now it is possible for you to make changes to the code of the program you want to work on, then simply rebuild the project so it displays your changes.

In this case, it's useful to know a few commonly used flags for kdesrc-build.

### Check the list of things that will be built

To get a general idea of how many and which programs are going to be built for a certain project, you can use the `--pretend` or `--dry-run` flag:

```bash
kdesrc-build --pretend kcalc
```

### Rebuild the current project and stay on current branch

Code changes should be done in a separate git branch, not in the `master` branch.

By default, kdesrc-build will always attempt to go back to the `master` branch before rebuilding. To avoid this, you can use the `--no-src` flag:

```bash
kdesrc-build --no-src kcalc
```

### Rebuild only a single project without updating the source code

As mentioned above, there are times when you want to rebuild the project in the current branch.

By default, kdesrc-build will rebuild a project and all its dependencies. To avoid this, you can use the `--no-include-dependencies` flag:

```bash
kdesrc-build --no-include-dependencies --no-src kcalc
```

### Build a specific project while skipping certain modules

Sometimes a particular program somewhere down the dependency chain fails to build and isn't strictly required for a certain project to compile properly, or sometimes you want to use the program installed from your distribution.

In that case, you can avoid building a project by using the `--ignore-modules` flag, which should come after the module name:

```bash
kdesrc-build kcalc --ignore-modules gpgme
```

### Specifying executable names when running

In some modules, such as `discover`, the build process will result in an executable which does not match the module name. You may specify the executable using the `-e` flag:

```bash
kdesrc-build --run -e plasma-discover discover
```

Without this flag, attempting to run the application will result in an error similar to:

```
Executable "discover" does not exist.
Try to set executable name with -e option.
```

### Running an application after making changes to one of its dependencies

Let's say you want to make a change to the KConfig library that should change a behavior in KCalc. In this case, you don't want kdesrc-build to discard your changes to KConfig. So first build KConfig separately, on its own, without doing a source code update:

```bash
kdesrc-build kconfig --no-src --no-include-dependencies --refresh-build
```

This will build just KConfig and install the needed build products into `~/kde/usr`. Now we want to run KCalc in such a way that it makes use of those changed files. Do it like so:

```bash
kdesrc-build kcalc --no-src --no-include-dependencies --refresh-build
kdesrc-build --run kcalc
```

## Next Steps

Now you can compile anything in KDE from its source code! Time to think about what to do with this superpower...

Perhaps you went through this whole procedure and still have no idea what to work on:

[Choose what to work on]({{< ref "help-choosing" >}})

If you already know what you want to work on and you are in fact already working on it, then it might be time to learn how to make a merge request and send your changes:

[Submit your new software changes for review](https://community.kde.org/Infrastructure/GitLab#Submitting_a_merge_request)

Or perhaps you'd like to further adapt kdesrc-build to your needs like managing different builds on the same machine or setting up your preferred IDE. If that's what you need, you can visit the advanced section:

[Advanced kdesrc-build features and troubleshooting](https://community.kde.org/Get_Involved/development/More)
