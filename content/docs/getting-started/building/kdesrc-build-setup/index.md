---
title: "Set up a development environment"
description: "Installing and configuring kdesrc-build"
weight: 10
group: "kdesrc-build"
---

Source code for KDE software lives on [KDE Invent](https://invent.kde.org). But before you can work on it, you'll need to set up a **development environment**: a set of tools that allows you to access and edit the source code, compile it into a form that the computer can run, and deploy it to a safe location. To accomplish these tasks, you will need to enter commands using a terminal program, such as KDE's [Konsole](https://apps.kde.org/konsole).

If you're not familiar with the command line interface, you can [find tutorials here](https://community.kde.org/Get_Involved/development/Learn#Unix_command_line). However, advanced command line skills are not required, and you will learn what you need along the way!

If you're a visual learner, we also provide [video tutorials about setting up kdesrc-build](https://community.kde.org/Get_Involved/development/Video).

The tool we will be using here for setting up a development environment and building KDE software is [kdesrc-build](https://invent.kde.org/sdk/kdesrc-build). It will let you set up your development environment and compile applications on Linux and FreeBSD.

{{< alert title="Keep in mind" color=success >}}

You only need to set up your environment once, and then you will be able to compile (and recompile) KDE software as often as needed later on!

{{< /alert >}}

## Install git

Setting up your environment on a Linux machine is fairly simple. First you will need to use your operating system's package manager to install git:

{{< installpackage
    ubuntu="git"
    opensuse="git"
    fedora="git perl perl-IPC-Cmd perl-MD5 perl-FindBin"
    arch="git"
>}}

## Configure git

We then need to set your authorship information properly so that any changes you make can be properly attributed to you:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
```

The name you provide should be your actual name, not your KDE Identity username or a pseudonym.

The email address must be the same as the email address used for your https://bugs.kde.org account.

If they don't match, then the `BUG:` and `FEATURE:` keywords won't work (see [this page](https://community.kde.org/Policies/Commit_Policy#Special_keywords_in_GIT_and_SVN_log_messages) for more information).

For convenience, we can enable a feature that will later become useful when we start pushing code to a repository branch:

```bash
git config --global push.autoSetupRemote true
```

Next, in order to authenticate yourself when pushing code changes, you need to add an ssh key to your GitLab profile as [described here](https://invent.kde.org/help/user/ssh.md). Once you are done, we can start using `kdesrc-build`.

## Set up kdesrc-build

`kdesrc-build` is the official KDE meta build system tool. It is used to manage the building of many software repositories in an automated fashion.

Its primary purpose is to *manage dependencies*. Every software has dependencies: other pieces of software that provide lower-level functionality they rely on. In order to compile any piece of software, its dependencies must be available.

KDE software has two types of dependencies:

* dependencies on other pieces of KDE software
* dependencies on 3rd-party software

For example, the KDE application [KCalc](https://apps.kde.org/kcalc/) depends on more than 20 other KDE libraries as well as the Qt toolkit.

Some Linux distributions do not provide development packages for [KDE Frameworks](https://develop.kde.org/products/frameworks/) and of other libraries that are up-to-date enough for us to build from the "main" branch of the KDE git repositories (the branch where the development of the next software versions takes place), so we use `kdesrc-build` to compile them ourselves. The goal is to avoid using KDE binaries, KDE libraries and other KDE files from the operating system where possible (in the Linux case, these files reside in the `/usr` directory).

Let's set it up now! You will need many gigabytes of free disk space. Budget 50 GB for KDE Frameworks + KDE Plasma, and 10-30 GB more for some apps as well. Then clone the `kdesrc-build` git repository in the following directory:

```bash
mkdir -p ~/kde
mkdir -p ~/.local/share
cd ~/.local/share
git clone https://invent.kde.org/sdk/kdesrc-build.git
cd kdesrc-build
```

And create a symlink to make `kdesrc-build` accessible in your `$PATH`:

```bash
mkdir -p ~/.local/bin
ln -sf ~/.local/share/kdesrc-build/kdesrc-build ~/.local/bin
```

{{< alert title="Note" color="info" >}}

Some distros need source repositories enabled before you can install the development packages you need. Do that now, *if needed*:

<details>
<summary>Click here to see how to enable source repos</summary>
<br>

**KDE neon/Debian/Ubuntu/Kubuntu/etc:**

```bash
sudo sed -i '/^# deb-src/s/^# //' /etc/apt/sources.list && sudo apt update
```

Look at the content of the file `/etc/apt/sources.list`, e.g. `cat /etc/apt/sources.list`. Each line that starts with "deb " should be followed by an identical line to the one that starts with "deb-src ", in the following way:

```bash
deb http://us.archive.ubuntu.com/ubuntu/ noble main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ noble main restricted
```

The archive name might differ depending on your country, and instead of `noble` the name of the Debian or Ubuntu version should appear instead, like `bookworm` or `jammy`.

**openSUSE Tumbleweed:**

```bash
sudo zypper modifyrepo --enable $(zypper repos | awk '/source/{print $5}')
```

This should be enough to enable the source repositories.

</details>

{{< /alert >}}

### Initial setup

With that done, it's time to run the initial setup program, which will install the necessary binary packages from your Linux operating system:

```bash
kdesrc-build --initial-setup
```

The step `kdesrc-build --initial-setup` above installs the Linux binary packages that are needed for kdesrc-build to build all of KDE Frameworks and then creates a default configuration file `~/.config/kdesrc-buildrc`. If you look at that configuration file, you will see that by default kdesrc-build will compile everything inside a new `~/kde` folder for you. You will see that in the next page.

### Updating kdesrc-build

Once in a while you will want to update kdesrc-build to get its latest changes. To do so, run the following:

```bash
# Go to where kdesrc-build was cloned:
cd ~/.local/share/kdesrc-build
# Update kdesrc-build itself:
git pull
# Install new distribution package dependencies, if any:
kdesrc-build --install-distro-packages
```

If you discover any external dependencies needed to build KDE software that were not installed with `kdesrc-build --initial-setup` or `kdesrc-build --install-distro-packages`, then please send a merge request to the [repo-metadata/distro-dependencies](https://invent.kde.org/sysadmin/repo-metadata/-/tree/master/distro-dependencies) repository to include the needed packages in the list.

### Set up Qt

Qt is the fundamental framework that is needed for pretty much all KDE development. A recent enough version of Qt 6, currently Qt version greater or equal to 6.6, is required to proceed.

The initial setup of kdesrc-build should have installed the required Qt6 packages for you already.

If your Linux distribution does not provide recent versions of Qt packages, you have four options:

* Use one of the alternative build methods mentioned in [Building KDE software]({{< ref "building" >}})
* [Build Qt6 using kdesrc-build](https://community.kde.org/Get_Involved/development/More#Build_Qt_using_kdesrc-build)
* [Install Qt6 using the Qt online installer](https://community.kde.org/Get_Involved/development/More#Qt_6_installed_using_the_Qt_online_installer)
* Switch distros to something [better suited for building KDE software from source code](https://community.kde.org/Get_Involved/development#Operating_system) either as the primary operating system or in a virtual machine

### Disable indexing for your development environment

You'll want to disable indexing for your development-related git repos and the files they will build and install.

To do that, add the `~/kde` directory to the exclusions list in System Settings › Search › File Search > Start Indexing a Folder...

{{< figure class="text-center mr-5 pr-5" caption="The Search field in System Settings." src="search-kdesrc-build.webp" >}}

## Next Steps

Your development environment is now set up and ready to build software.

To recapitulate the essentials:

1. You installed and configured git.
2. You cloned kdesrc-build using git.
3. You ran the initial setup for kdesrc-build.

Time to learn how to use kdesrc-build to build software from source code!
