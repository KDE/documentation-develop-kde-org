---
title: "Building KDE software with kde-builder"
description: "Compiling with a single command"
weight: 11
group: "kde-builder"
aliases: kdesrc-build-compile
---

In this section, you will learn how to use KDE's `kde-builder` tool to build KDE software once you have a development environment set up.

If you haven't set up kde-builder already, please follow the steps in [Set up a development environment]({{< ref "kde-builder-setup" >}}) before proceeding.

It can take an hour or more to compile a KDE application, Framework, or Plasma itself for the first time. The reason for this is that `kde-builder` also builds all KDE dependencies of a project by default. The next time you want to compile that or any other piece of KDE software, it will be much faster since most of the dependencies will have already been compiled.

If you don't want to build all dependencies (for instance if you are using a rolling release distro that provides recent versions of software), you can:

* edit the [configuration file](https://kde-builder.kde.org/en/configuration/config-file-overview.html) at `~/.config/kde-builder.yaml` and set `include-dependencies: false`
* or add the `--no-include-dependencies` [flag](https://kde-builder.kde.org/en/cmdline/supported-cmdline-params.html#cmdline-include-dependencies) when running `kde-builder`.

## Building and running applications {#application}

To build KCalc for example, run:

```bash
kde-builder kcalc
```

You can replace `kcalc` with any other project. You can also build more than one project by listing them here.
When you tell kde-builder to build a module, it will automatically download the sources using git, configure, build, and install them.

The project's source code is downloaded to a folder under `~/kde/src`. The build files are stored under `~/kde/build`, and installed to `~/kde/usr`.
If the build failed for any reason, please see our instructions on how to proceed with [Troubleshooting]({{< ref "kde-builder-failure" >}}).

To run the self-compiled KCalc, use the `kde-builder --run` command, which launches the built-from-source version of KCalc (from the directory `~/kde/usr`) instead of the version installed your package manager.

```bash
kde-builder --run kcalc
```

Did it run? If so, then congratulations, you just compiled your own version of KCalc from source code! 🎉

## Building and Running Plasma {#plasma}

`kde-builder` has several aliases for building groups of modules that belong together. These include
- `workspace`: All projects necessary to run a full Plasma Desktop session.
- `mobile`: All projects required for running a Plasma Mobile session.

You can build these like you would a single project, for example with:

```bash
kde-builder workspace
```

After building the `workspace` alias, `kde-builder` will prompt you for password in order to install session files in your system. After this, you can start your self-built Plasma session by choosing it in SDDM before logging in.

You can also install these files manually by running a script that is provided by `plasma-workspace`:

```bash
~/kde/build/plasma-workspace/login-sessions/install-sessions.sh
```

{{< alert title="About SELinux" color="info" >}}

SELinux can interfere with the new D-Bus services working correctly, and the path of least resistance may be to turn off enforcement if you are using a distro that ships with it on by default (like Fedora). To do this, set the value of `SELINUX` to `permissive` in the file `/etc/selinux`.

{{< /alert >}}

Alternatively, you can run the new instance of Plasma on top of your existing system for quick testing like so:

```bash
source ~/kde/build/plasma-workspace/prefix.sh
~/kde/usr/bin/plasmashell --replace
```

### Plasma Mobile

You can run your custom-built Plasma Mobile in an emulated phone session using a phone-sized window within your existing desktop.
To do this, we first set some environment variables that configure the session to behave like a phone and then start a nested KWin session with the mobile shell:

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
[Kirigami]({{< ref "setup-cpp/#kde-builder" >}}) or
[KXmlGui]({{< ref "hello_world/#kde-builder" >}})
tutorials, you can create a `project` at the end of your `~/.config/kde-builder.yaml`:

```yaml
project kirigami-tutorial:
  repository: ""
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

After that, you can build the original project (only required to compile the dependencies), and lastly build your fork:

```bash
kde-builder dolphin
kde-builder dolphin-fork
```

To summarize, you have now seen how to:

* compile standalone apps, frameworks, or other projects: `kde-builder kcalc`
* compile Plasma Desktop: `kde-builder workspace`
* compile Plasma Mobile: `kde-builder mobile`
* run what you've built: `kde-builder --run kcalc`


## Useful flags

The following sections will show some useful options for `kde-builder`. They're not required for normal operation, but can be useful in some situations. If you want, you can skip this part and get started with developing.

### Check the list of things that will be built

To get a general idea of how many and which dependencies are going to be built for a certain project, you can use the `--pretend` or `--dry-run` flag:

```bash
kde-builder --pretend kcalc
```

### Rebuild a project and stay on current branch

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

To run an application, use the flag `--run`.

```bash
kde-builder --run plasma-discover
```

Note that in Discover's case, the name of the project is `discover`, but the name of the executable is `plasma-discover`.

If a project provides more than one executable, you can specify the executable you want as long as you have built the module that provides it:

```bash
kde-builder kate
kde-builder --run kate-syntax-highlighter --list-themes
```

Alternatively, most applications can be run directly from their build directory.

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

What now?

Perhaps you went through this whole procedure and still have no idea what to work on:

In this case, [choose what to work on]({{< ref "help-choosing" >}}).

Or perhaps you'd like to further adapt kde-builder to your needs by setting up your preferred IDE. If that's what you need, have a look at [IDE Configuration]({{< ref "ide" >}}).

If you already know what you want to work on and you are in fact already working on it, then it might be time to learn how to make a merge request and send your changes. See [Submit your new software changes for review](https://community.kde.org/Infrastructure/GitLab#Submitting_a_merge_request) for more information.
