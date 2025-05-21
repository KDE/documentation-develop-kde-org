---
title: "Building KDE software on Windows with Craft"
description: "TODO"
weight: 41
group: "craft"
aliases: craft-building
---
Craft is a tool with multiple purposes related to packaging:

* It can build for multiple platforms: Windows, Android, OSX
* It can generate packages in multiple packaging formats: APPX, MSIX, APK, AppImage

Unlike kde-builder (KDE's build tool of choice on Linux), Craft defaults to downloading precompiled cached packages for the dependencies of your application, with the option to compile these packages locally.

Craft is also tightly integrated into KDE's continuous integration system, and capable of automatically signing packages in such a way that they can be published to official stores like Microsoft Store and Google Play. You can read more about this in [Packaging KDE Software](/docs/packaging/).

Given these capabilities, Craft can be an excellent tool to build C++ projects on Windows, even for non-KDE projects.

This tutorial will teach you how to:

* [Make changes to existing KDE software](#changes)
* [Build your own custom projects on Windows](#custom-projects)

If you have any issues regarding Craft, visit the [#kde-craft:kde.org](https://go.kde.org/matrix/#/##kde-craft:kde.org) group on [Matrix](https://community.kde.org/Matrix).

## Craft setup on Windows

On Windows 11, open the Terminal. On Windows 10, open Powershell.

Type `python3`. If you don’t have Python installed, it will open the Microsoft Store page for the latest release of Python, which you can then install without needing a Microsoft account.

Install Microsoft Visual Studio by going to [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/) and downloading the installer. Make sure to select the "Desktop development with C++" workload.

[Enable “Developer Mode”](https://learn.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) in the settings.

In the terminal, run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Then:

```powershell
python.exe -m pip install --upgrade certifi
```

Lastly, install Craft with the following command:

```powershell
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/KDE/craft/master/setup/install\_craft.ps1'))
```

It will ask you a series of questions. Press Enter for all options to accept the defaults.

Now you should have a new app option called `CraftRoot` in your main menu. You can either use that for everything Craft related, or open Powershell/Terminal and run:

```powershell
C:\CraftRoot\craft\craftenv.ps1
```

## Make changes to existing KDE software {#changes}

Let's attempt to make changes to KCalc with Craft.

The first thing you need to do is to install its dependencies as well as kcalc:

```powershell
craft kcalc
```

The first time you attempt to build any program using Craft, it will take a very long while to download all dependencies from the Craft cache. Depending on your internet connection and the project you want to hack, even just the dependencies might take more than one hour. This is because Windows lacks many of the default libraries that would be present in other operating systems, and because you will be installing cached builds.

After the command is finished, you should be able to run KCalc using Craft:

```powershell
craft --run kcalc
```

But because we downloaded a cached build of KCalc, we can't do modifications to its code just yet. Moreover, the version of KCalc installed will be the latest release rather than master, which is what we want to build.

Set the version to master:

```powershell
craft --set version=master kcalc
```

Then grab the source code for the project and build it:

```pwsh
craft --ignoreInstalled --no-cache kcalc
```

This will force installation of KCalc again, this time pulling the source code from the master branch and building KCalc instead of pulling from the cache. It will also pull the source code and build some of the necessary dependencies.

Now you may switch to the directory where the source code is with:

```powershell
cs kcalc
```

If you run `git status`, you should see that the source code has been pulled and it is in the latest `master` branch:

```powershell
PS C:\_\58afbb54\kcalc> git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

You may then start hacking! For example, try changing the `KAboutData aboutData` in `kcalc.cpp` to rename KCalc to something else.

Then, run:

```powershell
craft --ignoreInstalled kcalc
craft --run kcalc
```

And you should see KCalc now has a new name.

## Build your own custom projects on Windows {#custom-projects}

