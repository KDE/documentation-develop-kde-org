---
title: "Set up a development environment"
description: "Installing and configuring kde-builder"
weight: 10
group: "kde-builder"
aliases: kdesrc-build-setup
---

Source code for KDE software lives on [KDE Invent](https://invent.kde.org). Before you can work on it, you'll need to set up a **development environment**: a set of tools that allows you to access and edit the source code, compile it into a form that the computer can run, and deploy it to a safe location. To accomplish this, you will need to enter commands using a terminal program.

If you're not familiar with the command line interface, you can [find tutorials here](https://community.kde.org/Get_Involved/development/Learn#Unix_command_line). However, advanced command line skills are not required, and you will learn what you need along the way.

If you're a visual learner, we also provide [useful video tutorials](https://community.kde.org/Get_Involved/development/Video).

The tool we will be using here for setting up a development environment and building KDE software is [kde-builder](https://kde-builder.kde.org/). It will let you set up your development environment and compile applications on Linux and FreeBSD. You can find out more about it in its [repository](https://invent.kde.org/sdk/kde-builder) and the [README](https://invent.kde.org/sdk/kde-builder/-/blob/master/README.md).

{{< alert title="💡 Keep in mind" color="success" >}}

You only need to set up your environment once, and then you will be able to compile (and recompile) KDE software as often as needed later on.

{{< /alert >}}

## Why kde-builder?

`kde-builder` is the official KDE meta build system tool. It is used to manage the building of many software repositories in an automated fashion.

Its primary purpose is to *manage dependencies*. Every software has dependencies: other pieces of software that provide lower-level functionality they rely on. In order to compile any piece of software, its dependencies must be available.

KDE software has two types of dependencies:

* dependencies on other pieces of KDE software
* dependencies on 3rd-party software

For example, the KDE application [KCalc](https://apps.kde.org/kcalc/) depends on more than 20 other KDE libraries as well as the Qt toolkit.

Some Linux distributions do not provide development packages for [KDE Frameworks](https://develop.kde.org/products/frameworks/) and of other libraries that are up-to-date enough for us to build from the `master` branch of the KDE git repositories (the branch where the development of the next software versions takes place), so we use `kde-builder` to compile them ourselves. The goal is to avoid using KDE binaries, KDE libraries and other KDE files from the operating system where possible.

## Set up kde-builder

Before setting it up, you will need some free disk space. Budget 50 GB of storage space for KDE Frameworks + KDE Plasma, and 10-30 GB more for some apps as well. Then run the following:

```bash
cd ~
curl 'https://invent.kde.org/sdk/kde-builder/-/raw/master/scripts/initial_setup.sh' > initial_setup.sh
bash initial_setup.sh
```

`kde-builder` will install git, a few runtime packages, and will install its executable in your PATH so you can run it from the terminal, as in the next step.

{{< alert color="info" >}}

Dependening on your distribution, you may need to add `~/.local/bin` to the `PATH` environment variable. The kde-builder installer will tell you if this is required.

{{< /alert >}}

After the initial setup, you will need to generate a configuration file for kde-builder. Run:

```bash
kde-builder --generate-config
```

This will create a new file `~/.config/kde-builder.yaml`. See the [documentation](https://kde-builder.kde.org/en/configuration/config-file-overview.html) for a list of available options.

{{< alert title="Debian/Ubuntu-based distributions" color="warning" >}}

Some distributions need source repositories enabled before you can install the development packages you need. Do that now, *if needed*:

<details>
<summary>Click here to see how to enable source repos</summary>
<br>

**If the file /etc/apt/sources.list exists**

Open the file `/etc/apt/sources.list` with a text editor such as [Kate](https://kate-editor.org/) or `nano`. Each line that starts with `deb ` should be followed by a similar line beginning with `deb-src `, for example:

```bash
deb http://us.archive.ubuntu.com/ubuntu/ noble main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ noble main restricted
```

Note: The URL might differ depending on your country, and instead of `noble` the name of the Debian or Ubuntu version should appear instead, e.g., `bookworm` or `jammy`.

If the `deb-src` line is commented out with a `#`, remove the `#` character.

Lastly, run:

```bash
sudo apt update
```

**If the file /etc/apt/sources.list does not exist**

Starting with Kubuntu 24.04, the configuration file for apt repositories has moved to `/etc/apt/sources.list.d/ubuntu.sources`.

Open the file `/etc/apt/sources.list.d/ubuntu.sources` with an editor like [Kate](https://kate-editor.org/) or `nano`. Change the contents of the file by replacing all occurrences of `Types: deb` with `Types: deb deb-src`. For example, replacing the following:

```bash
Types: deb
URIs: http://archive.ubuntu.com/ubuntu
Suites: noble noble-updates noble-backports
Components: main universe restricted multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

With:

```bash
Types: deb deb-src
URIs: http://archive.ubuntu.com/ubuntu
Suites: noble noble-updates noble-backports
Components: main universe restricted multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

Note: The URL might differ depending on your country, and instead of `noble` the name of the Debian or Ubuntu version should appear instead, e.g., `bookworm` or `jammy`.

Lastly, run:

```bash
sudo apt update
```

</details>

{{< /alert >}}

During initial setup, `kde-builder` installed the essentials to run the tool itself. To install the distribution packages required to actually build KDE software, run:

```bash
kde-builder --install-distro-packages
```

Finally, perform your first build:

```shell
kde-builder kcalc
```

This will build [KCalc](https://apps.kde.org/kcalc/), a calculator app, and its KDE dependencies. If you happen to find any build issues, don't fret! That means kde-builder is working.

In the next section, [Building KDE software with kde-builder]({{< ref "kde-builder-compile" >}}), we have a more in-depth look into the build process. To solve any build issues, you can check out [Installing build dependencies]({{< ref "help-dependencies" >}}).

`kde-builder` is now set up for building! 🎉

{{< alert color="success" title="💡 A chance to contribute">}}

If you discover any external dependencies needed to build KDE software that were not installed with `kde-builder --install-distro-packages`, for example using our guide on [Installing Build Dependencies]({{< ref "help-dependencies" >}}), please send a merge request to the [repo-metadata/distro-dependencies](https://invent.kde.org/sysadmin/repo-metadata/-/tree/master/distro-dependencies) repository to include the needed packages in the list.

{{< /alert >}}

### Updating kde-builder

You should occasionally update `kde-builder` to get its latest changes.

This can be done by running

```bash
kde-builder --self-update
```

{{< alert color="info" >}}

If this does not work, your version of `kde-builder` does not support updating itself yet. In this case, you can update it by running

```bash
cd ~
bash initial_setup.sh
```

{{< /alert >}}

## Setting up Qt

Qt is the fundamental framework that is needed for all KDE development. A recent enough version of Qt 6 - currently usually mean at least version 6.7 - is required to proceed.

The initial setup of `kde-builder` should have installed the required Qt6 packages for you already, in which case you don't need to do anything and may skip directly to the [Configure git]({{< ref "#configure-git" >}}) section.

If your Linux distribution does not provide a recent enough versoin of Qt, you have the following options:

* Use Craft or containers, as mentioned in [Building KDE software]({{< ref "building" >}})
* [Install Qt6 using the Qt online installer]({{< ref "#qt6-online" >}})
* [Install Qt6 using the unofficial aqtinstall installer]({{< ref "#qt6-aqtinstall" >}})
* [Build Qt6 using kde-builder]({{< ref "#qt6-build" >}})
* Switch to a [more up-to-date distro]({{< ref "building#choosing" >}})

### Use Qt6 from the online installer {#qt6-online}

Instead of letting `kde-builder` build Qt for you, you may want to use Qt's official installer

First, create an account on [Qt's website](https://www.qt.io/). Then, download the installer from the [Qt for Open Source Development](https://www.qt.io/download-qt-installer-oss) page.

Run the downloaded file, log in with your Qt account, and follow the wizard. During the installation, choose the option `Custom installation`, and:

* Uncheck `Qt Design Studio`
* Uncheck `Qt Creator`
* Make sure the `Desktop` item for the latest version of Qt is selected

This will install only the essential Qt libraries in `~/Qt` by default, occupying a little less than 2 GB of storage.

Once installed, open `~/.config/kde-builder.yaml`, uncomment the line with `qt-install-dir: ~/kde/qt`, and change it to point to your Qt installation. The actual path should be similar to this, depending on your Qt version:

```yaml
qt-install-dir: ~/Qt/6.9.0/gcc_64
```

Once this is done, `kde-builder` will know to use the Qt provided by the online installer to build KDE software.

If you ever need to install more Qt components, you can do so using the `Qt Maintenance Tool` that was added by the installer.

### Use Qt6 from aqtinstall {#qt6-aqtinstall}

{{< alert title="⚠️ Experimental" color="warning" >}}

This method was not fully tested yet.

{{< /alert >}}

If you do not want to create a Qt account to use Qt's official installer and do not want to build Qt yourself,
you can try using the unofficial installer `aqtinstall` which downloads
Qt from the same sources as the official installer.

First, install `aqtinstall`:

```bash
pipx install aqtinstall
```

If you don't have `pipx` installed, you can install it from your distribution.

You can then install Qt using

```bash
aqt install-qt linux desktop 6.9 linux_gcc_64 --outputdir ~/Qt --modules all
```

replacing `6.9` with the latest Qt version number.

This will install all Qt modules available in the latest version and will occupy a bit more than 8 GB of storage.

Once installed, open the file `~/.config/kde-builder.yaml`, uncomment the line with `qt-install-dir: ~/kde/qt`, and change it to point to your Qt installation. The actual path should be similar to this, depending on your Qt version:

```yaml
qt-install-dir: ~/Qt/6.9.0/gcc_64
```

Once this is done, `kde-builder` will know to use the Qt provided by the online installer to build KDE software.

### Build Qt6 using kde-builder {#qt6-build}

{{< alert title="⚠️ Work in Progress" color="warning" >}}

This method is undergoing testing to make sure it works on most systems.

{{< /alert >}}

It is possible to build Qt with kde-builder, but it requires a minimum of 30 GB of storage and has a long compilation time, up to a few hours depending on your machine.

To do this, open the file `~/.config/kde-builder.yaml` and uncomment the line containing:

```yaml
qt-install-dir: ~/kde/qt
```

Near the end of the file, add an override so you build Qt from the latest release instead of the development branch (the default):

```yaml
override qt6-set:
  branch: "6.9"
```

Then run:

```bash
kde-builder qt6-set
```

This will take a long time.

## Configure git

To properly track who created a commit, your name and email must be configured in git. If this is not done correctly, [invent.kde.org](https://invent.kde.org) might reject your changes when you push them.
To configure name and email, run:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
```

The name given here must be a human name, not the username of your KDE account or similar. The email should be the same as configured in GitLab and for your account on [bugs.kde.org](https://bugs.kde.org), if you have one. This is required for some integrations to work correctly.

You should take the chance to create a [KDE Identity account](https://identity.kde.org) that you can use to access KDE's Gitlab instance where all KDE code resides, [Invent](https://invent.kde.org). Take a look at [Infrastructure: Gitlab](https://community.kde.org/Infrastructure/GitLab) to learn more about this.

For convenience, you can enable a feature that will become useful when starting to push code to GitLab:

```bash
git config --global push.autoSetupRemote true
```

Next, in order to authenticate yourself when pushing code changes, you need to add an SSH key to your Invent profile as described in the [Invent SSH documentation](https://invent.kde.org/help/user/ssh.md). Once you are done, we can start using `kde-builder`.

## Disable indexing for your development environment

You'll want to disable indexing for your development-related git repos and the files they will build and install.

To do that, add the `~/kde` directory to the exclusions list in `System Settings` › `Search` › `File Search` > `Stop Indexing a Folder...`

{{< figure class="text-center" caption="The Search field in System Settings." src="search-kdesrc-build.webp" >}}

## Next Steps

Your development environment is now set up and ready to build software.

- You installed [kde-builder](https://kde-builder.kde.org/).
- You generated a [configuration file](https://kde-builder.kde.org/en/configuration/config-file-overview.html) for it.
- You installed the necessary packages to start building KDE software.
- You have set it up to use Qt (optional).
- You have set up git so you can start working on code.

The next section explains how to use `kde-builder` to build software from source code.
