---
title: "Set up a development environment"
description: "Installing and configuring kde-builder"
weight: 10
group: "kde-builder"
aliases: kdesrc-build-setup
---

{{< alert color="warning" title="⚠️ kdesrc-build is no longer supported" >}}

</br>
<details>
<summary>Click to see more information</summary></br>

[kdesrc-build](https://invent.kde.org/sdk/kdesrc-build),
the tool that was used previously for this tutorial, is no longer supported.

While the tool is stable and still works for our veteran developers, if you are starting out with KDE development now, we recommend that you switch to
[kde-builder](https://kde-builder.kde.org/). Once you run it for the first time after installation, it will ask whether you want to migrate your existing `kdesrc-buildrc` configuration file to the new `kde-builder.yaml` file.

Any support questions related to this tutorial can be asked on the
[KDE New Contributors](https://go.kde.org/matrix/#/#new-contributors:kde.org) group on
[Matrix](https://community.kde.org/Matrix).

See also [Where to find the development team]({{< ref "help-developers" >}}).

</details>

{{< /alert >}}


Source code for KDE software lives on [KDE Invent](https://invent.kde.org). But before you can work on it, you'll need to set up a **development environment**: a set of tools that allows you to access and edit the source code, compile it into a form that the computer can run, and deploy it to a safe location. To accomplish these tasks, you will need to enter commands using a terminal program, such as KDE's [Konsole](https://apps.kde.org/konsole).

If you're not familiar with the command line interface, you can [find tutorials here](https://community.kde.org/Get_Involved/development/Learn#Unix_command_line). However, advanced command line skills are not required, and you will learn what you need along the way!

If you're a visual learner, we also provide [useful video tutorials](https://community.kde.org/Get_Involved/development/Video).

The tool we will be using here for setting up a development environment and building KDE software is [kde-builder](https://kde-builder.kde.org/). It will let you set up your development environment and compile applications on Linux and FreeBSD.

{{< alert title="💡 Keep in mind" color="success" >}}

You only need to set up your environment once, and then you will be able to compile (and recompile) KDE software as often as needed later on!

{{< /alert >}}

## Why kde-builder?

`kde-builder` is the official KDE meta build system tool. It is used to manage the building of many software repositories in an automated fashion.

Its primary purpose is to *manage dependencies*. Every software has dependencies: other pieces of software that provide lower-level functionality they rely on. In order to compile any piece of software, its dependencies must be available.

KDE software has two types of dependencies:

* dependencies on other pieces of KDE software
* dependencies on 3rd-party software

For example, the KDE application [KCalc](https://apps.kde.org/kcalc/) depends on more than 20 other KDE libraries as well as the Qt toolkit.

Some Linux distributions do not provide development packages for [KDE Frameworks](https://develop.kde.org/products/frameworks/) and of other libraries that are up-to-date enough for us to build from the "main" branch of the KDE git repositories (the branch where the development of the next software versions takes place), so we use `kde-builder` to compile them ourselves. The goal is to avoid using KDE binaries, KDE libraries and other KDE files from the operating system where possible (in the Linux case, these files reside in the `/usr` directory).

## Set up kde-builder

Let's set it up now! You will need many gigabytes of free disk space. Budget 50 GB of storage space for KDE Frameworks + KDE Plasma, and 10-30 GB more for some apps as well. Then run the following:

```bash
cd ~
curl 'https://invent.kde.org/sdk/kde-builder/-/raw/master/scripts/initial_setup.sh' > initial_setup.sh
bash initial_setup.sh
```

kde-builder will install git, a few runtime packages, and will install its executable in your PATH so you can run it from the terminal, as in the next step.

After the initial setup, you will need to generate a configuration file for kde-builder. Run:

```bash
kde-builder --generate-config
```

This will create a new file `~/.config/kde-builder.yaml`.

{{< alert title="About ~/.local/bin" color="info" >}}

<details>
<summary>Click here if you experience problems with finding kde-builder in your PATH</summary></br>

Some Linux distributions might not follow the [Freedesktop Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) that enforces that the `~/.local/bin` directory be added to the `$PATH`, which is required for an executable to show up in the terminal without its absolute path.

To check if `~/.local/bin` is in the `$PATH`, run: `echo $PATH`.

If the directory is not listed, then you will need to add it yourself. You can do so by adding the following to your `~/.bashrc` (or equivalent in your preferred shell):

```bash
export PATH=$PATH:~/.local/bin
```

Closing and reopening your terminal window once should be enough for `kde-builder` to appear for the next steps.

Don't forget to warn your distribution to follow the specification.

</details>

{{< /alert >}}

{{< alert title="⚠️ Read this if you use a Debian/Ubuntu-based distro" color="warning" >}}

Some distros need source repositories enabled before you can install the development packages you need. Do that now, *if needed*:

<details>
<summary>Click here to see how to enable source repos</summary>
<br>

**KDE neon/Debian/Ubuntu/Kubuntu/etc:**

**If the file /etc/apt/sources.list exists**

Open the file `/etc/apt/sources.list` with a text editor such as [Kate](https://kate-editor.org/) or `nano`. Each line that starts with "deb " should be followed by a similar line beginning with "deb-src ", for example:

```bash
deb http://us.archive.ubuntu.com/ubuntu/ noble main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ noble main restricted
```

Note: The URL might differ depending on your country, and instead of `noble` the name of the Debian or Ubuntu version should appear instead, like `bookworm` or `jammy`.

If the deb-src line is commented out with a `#`, remove the `#` character.

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

Note: The URL might differ depending on your country, and instead of `noble` the name of the Debian or Ubuntu version should appear instead, like `bookworm` or `jammy`.

Lastly, run:

```bash
sudo apt update
```

</details>

{{< /alert >}}

While during initial setup kde-builder installed the essentials for itself to run, now, kde-builder will need to install the required distribution packages to build KDE software. To do that, run:

```bash
kde-builder --install-distro-packages
```

Now kde-builder is set up! 🎉

{{< alert color="success" title="💡 A chance to contribute">}}

If you discover any external dependencies needed to build KDE software that were not installed with `kde-builder --install-distro-packages`, for example using our guide on [Installing Build Dependencies]({{< ref "help-dependencies" >}}) then please send a merge request to the [repo-metadata/distro-dependencies](https://invent.kde.org/sysadmin/repo-metadata/-/tree/master/distro-dependencies) repository to include the needed packages in the list.

{{< /alert >}}

{{< alert color="info" title="⏳ With kdesrc-build..." >}}

<details>
<summary>Click here to know how this was done with kdesrc-build</summary></br>

This step used to be done by cloning the repository into a folder, linking the script, and running the script:

```bash
kdesrc-build --initial-setup
```

For details, see: [Install kdesrc-build](https://invent.kde.org/sdk/kdesrc-build#install-kdesrc-build)

</details>

{{< /alert >}}

### Updating kde-builder

Once in a while you will want to update kde-builder to get its latest changes. To do so, run the `initial_setup.sh` file that was created when installing kde-builder:

```bash
cd ~
bash initial_setup.sh
```

{{< alert color="info" title="⏳ With kdesrc-build..." >}}

<details>
<summary>Click here to know how this was done with kdesrc-build</summary></br>

This step used to be done by going to the directory where kdesrc-build was cloned and pulling the new changes:

```bash
cd ~/.local/share/kdesrc-build
git pull
```

</details>

{{< /alert >}}

## Set up Qt

Qt is the fundamental framework that is needed for pretty much all KDE development. A recent enough version of Qt 6, currently Qt version greater or equal to 6.7, is required to proceed.

The initial setup of kde-builder should have installed the required Qt6 packages for you already, in which case you don't need to do anything and may skip directly to the [Configure git]({{< ref "#configure-git" >}}) section.

If your Linux distribution does NOT provide recent versions of Qt packages, you have four options:

* Use one of the alternative build methods mentioned in [Building KDE software]({{< ref "building" >}})
* Build Qt6 using kde-builder
* Install Qt6 using the Qt online installer
* Switch distros to something [better suited for building KDE software from source code]({{< ref "building#choosing" >}})

### Build Qt6 using kde-builder {#build-qt6}

To do this, open the file `~/.config/kde-builder.yaml` and uncomment the line containing:

```
qt-install-dir: ~/kde/qt
```

Then run:

```bash
kde-builder qt6-set
```

It will take quite a while. Once it is done, proceed to [Configure git]({{< ref "#configure-git" >}}).

### Use Qt6 from the online installer {#qt6-online}

Instead of letting kde-builder build Qt for you, you may want to use the online installer that comes directly from Qt. To download Qt you will need to make an account.

First, go to the [QtGroup website](https://www.qt.io/) and create an account.

After creating your new Qt account, go to [Qt for Open Source Development](https://www.qt.io/download-open-source), click on "Download the Qt Online Installer", and follow the download process.

Run the downloaded file, log in with your new Qt account, and follow the wizard to install Qt. It will be installed in `~/Qt` by default.

During the installation, you may deselect the following components that are not used by KDE software:

* Qt Design Studio
* WebAssembly
* Android
* Sources
* Qt Quick 3D
* Qt 3D
* Qt Quick 3D Physics
* Qt Debug Information Files

Once installed, open the file `~/.config/kde-builder.yaml`, uncomment the line with `qt-install-dir: ~/kde/qt`, and change it to point to your Qt installation. The actual path should be similar to this, depending on your Qt version:

```yaml
qt-install-dir: ~/Qt/6.7.0/gcc_64
```

Once it is done, kde-builder will know to use the Qt provided by the online installer to build KDE software.

## Configure git

The first thing we will need to do after having set up kde-builder is to configure git.

Set your authorship information properly so that any changes you make to code can be properly attributed to you:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
```

You should take the chance to create a [KDE Identity account](https://identity.kde.org) that you can use to access KDE's Gitlab instance where all KDE code resides, [Invent](https://invent.kde.org). Take a look at [Infrastructure: Gitlab](https://community.kde.org/Infrastructure/GitLab) to learn more about this.

{{< alert color="info" title="About username and email" >}}

The `user.name` you provide should be your actual name, not your KDE Identity username or a pseudonym.

The email address must be the same as the email address used for your [KDE Bugzilla](https://bugs.kde.org) account, if you have one. If they don't match, then the `BUG:` and `FEATURE:` keywords won't work (see [Special Keywords in Git](https://community.kde.org/Policies/Commit_Policy#Special_keywords_in_GIT_and_SVN_log_messages) for more information).

{{< /alert >}}

For convenience, we can enable a feature that will later become useful when we start pushing code to a repository branch:

```bash
git config --global push.autoSetupRemote true
```

Next, in order to authenticate yourself when pushing code changes, you need to add an SSH key to your Invent profile as described in the [Invent SSH docs](https://invent.kde.org/help/user/ssh.md). Once you are done, we can start using `kde-builder`.

## Disable indexing for your development environment

You'll want to disable indexing for your development-related git repos and the files they will build and install.

To do that, add the `~/kde` directory to the exclusions list in System Settings › Search › File Search > Stop Indexing a Folder...

{{< figure class="text-center mr-5 pr-5" caption="The Search field in System Settings." src="search-kdesrc-build.webp" >}}

## Next Steps

Your development environment is now set up and ready to build software.

To recapitulate the essentials:

1. You installed kde-builder.
2. You generated a configuration file for it.
3. You installed the necessary packages to start building KDE software.
4. You have set it up to use Qt (optional).
5. You have set up git so you can start working on code.

Time to learn how to use kde-builder to build software from source code!