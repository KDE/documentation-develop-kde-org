---
title: "Building KDE software on Windows with Craft"
description: "Run and ship your programs on Windows"
weight: 41
group: "craft"
aliases: craft-building
---
Craft is a tool with multiple purposes related to packaging:

* It can build for multiple platforms: Windows, Android, macOS and Linux
* It can generate packages in multiple packaging formats: Windows APPX, Android APK, Linux AppImage and macOS DMG

Unlike kde-builder (KDE's build tool of choice on Linux), Craft defaults to downloading precompiled cached packages for the dependencies of your application, with the option to compile these packages locally.

Craft is also tightly integrated into KDE's continuous integration system, and capable of automatically signing packages in such a way that they can be published to official stores like Microsoft Store and Google Play. You can read more about this in [Packaging KDE Software](/docs/packaging/).

Given these capabilities, Craft can be an excellent tool to build C++ projects on Windows, even for non-KDE projects.

This tutorial will teach you how to:

* [Make changes to existing KDE software](#changes)
* [Build your own custom projects on Windows](#custom-projects)

If you have any issues regarding Craft, visit the [#kde-craft:kde.org](https://go.kde.org/matrix/#/##kde-craft:kde.org) room on [Matrix](https://community.kde.org/Matrix).

## Craft setup on Windows

On Windows 11, open the Terminal. On Windows 10, open Powershell.

Type `python` and press Enter. If you don’t have Python installed, it will open the Microsoft Store page for the latest release of Python, which you can then install without needing a Microsoft account.

Install Microsoft Visual Studio by going to [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/) and downloading the installer. Make sure to select the "Desktop development with C++" workload.

[Enable “Developer Mode”](https://learn.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) in the settings.

In the terminal, run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Then:

```bash
python.exe -m pip install --upgrade certifi
```

Lastly, install Craft with the following command:

```powershell
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/KDE/craft/master/setup/install_craft.ps1'))
```

It will ask you a series of questions. Press Enter for all options to accept the defaults.

Now you should have a new app entry called `CraftRoot` in the Windows Start menu. You can either use that for everything Craft related, or open Powershell/Terminal and run:

```powershell
C:\CraftRoot\craft\craftenv.ps1
```

## Make changes to existing KDE software {#changes}

Let's attempt to make changes to KCalc with Craft.

The first thing you need to do is to install KCalc and its dependencies:

```bash
craft kcalc
```

The first time you attempt to build any program using Craft, it will take a long time to download all dependencies from the Craft cache. Depending on your internet connection and the project you want to hack, even just the dependencies might take more than one hour. This is because Windows lacks many of the default libraries that would be present in other operating systems.

After the command has finished, you should be able to run KCalc using Craft:

```bash
craft --run kcalc
```

Craft keeps a cached build of most libraries, but for applications Craft instead downloads a tarball of the last release and builds from that. Because of this, there is no repository with source code for us to modify. Moreover, for development purposes, we want to modify KCalc from the master branch.

Set the version to master:

```bash
craft --set version=master kcalc
```

Then rebuild it:

```bash
craft --ignoreInstalled --no-cache kcalc
```

This will force installation of KCalc again, this time pulling the source code from the master branch and building KCalc instead of building from a tarball.

Now that Craft has pulled the source code repository, you may switch to the directory where the source code is with:

```bash
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

```bash
craft --ignoreInstalled kcalc
craft --run kcalc
```

And you should see KCalc now has a new name.

To build on a work branch:

```bash
git branch work/yourname/newbranch
git switch work/yourname/newbranch
craft --compile --install --qmerge kcalc
```

Later on, you can then just `git switch` to the branch you want to build and run the last command.

{{< alert title="" color="danger" >}}

If you rebuild the project with the default Craft build (`craft --ignoreInstalled kcalc`), it will revert to the master branch.

{{< /alert >}}

## Adding a blueprint {#blueprint}

To make Craft build a custom project, you will need a [Craft Blueprint](https://community.kde.org/Craft/Blueprints), a recipe written in very simple-to-write Python that Craft uses to know where the source code for a project is and what to do with it.

For starter projects that still have no repository to pull the source code from, it is possible to run Craft on a project stored in any directory. This works well for making iterative changes in a project before committing.

We will be using the [Kirigami Tutorial](/docs/getting-started/kirigami/) as an example.

Store the project in your home directory on Windows Explorer, in `Documents\kirigami-tutorial`.

Next, in your `CraftRoot` terminal, run the following to enter the Blueprints directory and create a directory for your project:

```powershell
cs craft-blueprints-kde
mkdir kde\kirigami-tutorial
```

Then copy the following Blueprint to `kde\kirigami-tutorial\kirigami-tutorial.py`:

```python
import info
from Blueprints.CraftPackageObject import CraftPackageObject

class subinfo(info.infoclass):
    def setTargets(self):
        self.displayName = "Kirigami Tutorial"
        self.description = "A test to run a Kirigami app on Windows with Craft"
        self.webpage = "https://kde.org"
    def setDependencies(self):
        self.buildDependencies["kde/frameworks/extra-cmake-modules"] = None
        self.runtimeDependencies["libs/qt/qtdeclarative"] = None
        self.runtimeDependencies["kde/frameworks/tier1/kirigami"] = None
        self.runtimeDependencies["kde/frameworks/tier1/breeze-icons"] = None
        self.runtimeDependencies["kde/frameworks/tier3/kiconthemes"] = None
        self.runtimeDependencies["kde/frameworks/tier3/qqc2-desktop-style"] = None

from Package.CMakePackageBase import CMakePackageBase

class Package(CMakePackageBase):
    def createPackage(self):
        self.defines["appname"] = "kirigami-hello"
        self.defines["shortcuts"] = [{"name": "Kirigami Tutorial", "target": "bin/kirigami-hello.exe"}]
        return super().createPackage()
```

{{< alert title="Note" color="info" >}}

`buildDependencies` should be used for build tools, not libraries.

`runtimeDependencies` refers to libraries and tools that are required by the application at build time *and* runtime. Despite Kirigami being a build dependency for the project, it is marked as a runtime dependency because without Kirigami the application would not run. Runtime dependencies are shipped with the package when it gets built.

{{< /alert >}}

## Build your own custom projects on Windows {#custom-projects}

Navigate to the directory where your project is:

```powershell
cd $env:USERPROFILE\OneDrive\Documents\kirigami-tutorial
```

{{< alert title="About Windows user directories" color="info" >}}

Windows 10 and 11 come with OneDrive enabled. By default, the `Documents` directory is backed up by OneDrive, so it is stored in `C:\Users\youruser\OneDrive\Documents`.

After installation, if you set OneDrive to not back up this folder, then the new path becomes `C:\Users\youruser\Documents`.

Additionally, the `Documents` directory might be localized into your language. Change the command above accordingly.

{{< /alert >}}

Then run:

```bash
craft --ignoreInstalled --options kirigami-tutorial.srcDir=$(Get-Location) kirigami-tutorial
craft --options kirigami-tutorial.srcDir=$(Get-Location) --run kirigami-hello
```

This will ignore any repository options and branches and just use the current source directory as is.

Once your project is pushed to a repository somewhere, you can add it to your blueprint:

```python
self.svnTargets["master"] = "https://invent.kde.org/youruser/kirigami-tutorial.git|master"
self.defaultTarget = "master"
```

So that you can simply run:

```bash
craft --ignoreInstalled kirigami-tutorial
craft --run kirigami-hello
```

Or build a work branch as is:

```bash
git branch work/yourname/newbranch
git switch work/yourname/newbranch
craft --compile --install --qmerge kirigami-tutorial
```

{{< alert title="" color="danger" >}}

If you rebuild the project with the default Craft build (`craft --ignoreInstalled kirigami-tutorial`), it will revert to the master branch.

{{< /alert >}}

## Making an installer {#installer}

By default, Craft will be able to make an executable package installer using [NSIS](https://nsis.sourceforge.io):

```bash
craft --package kirigami-tutorial
# Or the following to use the current source directory as is
craft --options kirigami-tutorial.srcDir=$(Get-Location) --package kirigami-tutorial
```

The package installer will be created in `C:\CraftRoot\tmp\kirigami-tutorial-latest-master-windows-cl-msvc2022-x86_64.exe`.

To make the installer create a Start menu launcher entry on Windows, we used this in the above blueprint:

```python
from Package.CMakePackageBase import CMakePackageBase

class Package(CMakePackageBase):
    def createPackage(self):
        self.defines["appname"] = "kirigami-hello"
        self.defines["shortcuts"] = [{"name": "Kirigami Tutorial", "target": "bin/kirigami-hello.exe"}]
        return super().createPackage()
```

The Kirigami tutorial is designed such that the project name and main directory is called `kirigami-tutorial` and the binary is called `kirigami-hello`, so we set the executable accordingly. Then we override its shortcut to point to the right place.

## Troubleshooting

If you get a message like this:

```
*** Handling package: libs/ffmpeg, action: all ***
*** Action: fetch-binary for libs/ffmpeg ***
SHA256 hash for file C:\CraftRoot\download\cache\25.01\windows\cl\msvc2022\x86_64\RelWithDebInfo\libs\ffmpeg\ffmpeg-7.1-3-796-20250203T195103-windows-cl-msvc2022-x86_64.7z (06d9f639d325d7dbb3c17959dc08bd5e191baebb406af28ff1c2d9711c9f9446) does not match (c3b1c25014c34af9063c2ae121bc63373f2c801fb905c2a4a7e9c09b90614561)

Hash did not match, C:\CraftRoot\download\cache\25.01\windows\cl\msvc2022\x86_64\RelWithDebInfo\libs\ffmpeg\ffmpeg-7.1-3-796-20250203T195103-windows-cl-msvc2022-x86_64.7z might be corrupted

Do you want to delete the files and redownload them?
[0] Yes, [1] No (Default is Yes):
```

All you need to do is to confirm `Yes` by pressing Enter.

---

If, when attempting to build a project from master, you get a message like this:

```
CMake Warning at CMakeLists.txt:7 (find_package):
  Could not find a configuration file for package "ECM" that is compatible
  with requested version "6.15.0".

  The following configuration files were considered but not accepted:

    C:/CraftRoot/share/ECM/cmake/ECMConfig.cmake, version: 6.14.0
```

This means a dependency of the project has a too low version.

You will need to set the dependency to use a valid version or set it to master:

```
craft --set version=6.15.0
# or
craft --set version=master extra-cmake-modules
```

If the version is invalid, Craft will tell you the available valid options:

```
You defined an invalid target 6.15.0 for kde/frameworks/extra-cmake-modules, available versions are ['6.10.0', '6.11.0', '6.12.0', '6.13.0', '6.14.0', 'master']
```
