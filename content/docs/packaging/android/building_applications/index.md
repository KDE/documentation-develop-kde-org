---
title: "Building applications for Android"
linkTitle: "Building applications for Android"
weight: 1
description: >
  Learn how to build your applications for Android
---

We assume that the application is already ported to Android. If not then read the tutorial on [porting applications to Android]({{< ref "porting_applications" >}}).

Building .apk files from Qt Applications requires a cross-compiling toolchain, which is hard to setup. To simplify this, there is a ready-to-use Docker container for building KDE applications.

This only applies to applications that have a Craft blueprint in the [craft-blueprints-kde](https://invent.kde.org/packaging/craft-blueprints-kde) repository. If the application you want does not have such a blueprint yet, have a look at [the documentation](https://community.kde.org/Craft/Blueprints).


## Setting up the image

First create a mountable folder used for the image:

```bash
mkdir craft-kde-android
```

If you want to build Qt6 applications, download the `qt68` image:

```bash
docker run -ti --rm -v $PWD/craft-kde-android:/home/user/CraftRoot invent-registry.kde.org/sysadmin/ci-images/android-qt68 bash
# or with podman
podman run -ti --rm -v $PWD/craft-kde-android:/home/user/CraftRoot:Z --userns keep-id invent-registry.kde.org/sysadmin/ci-images/android-qt68 bash
```

{{< alert color="info" title="Note" >}}
If this fails with an error similar to "Permission denied", you may need to disable SELinux while using craft by running `sudo setenforce 0`.
{{< /alert >}}

After the image is done downloading, you should be in a new shell which is running inside of the container. Now it's time to initialize Craft:

```
python3 -c "$(curl https://raw.githubusercontent.com/KDE/craft/master/setup/CraftBootstrap.py)" --prefix ~/CraftRoot
```

It will ask several questions such as which Qt version to use, and the target architecture. Once that's complete, enter the Craft environment:

```bash
source ~/CraftRoot/craft/craftenv.sh
```

Your shell prompt should now look something like this:

```bash
CRAFT: user@830068cd8dca:~/CraftRoot$ 
```

## Building applications

To build an application and it's dependencies, simply run the craft command with the application as the sole argument. For example, to build [KDE Itinerary](https://apps.kde.org/itinerary/):

```bash
craft itinerary
```

{{< alert color="info" title="Note" >}}
To build with a local source folder: `craft --options itinerary.srcDir=/path/to/source itinerary` (also for `--package`).
{{< /alert >}}

You can search for blueprints using the `--search` command:

```bash
CRAFT: user@830068cd8dca:~/CraftRoot$ craft --search kongress
Craft               : /home/user/CraftRoot
Version             : master
ABI                 : android-clang-arm64
Download directory  : /home/user/CraftRoot/download
Cache repository    : https://files.kde.org/craft/Qt6/23.11/android/clang/arm64
Package kongress found:
kde/applications/kongress
    Name: Kongress
    BlueprintPath: /home/user/CraftRoot/etc/blueprints/locations/craft-blueprints-kde/kde/applications/kongress/kongress.py
    Homepage: https://www.kde.org/
    Description: Conference companion app
    Tags: 
    Options: args=, branch=(str), buildStatic=(bool), buildTests=True, buildType=MinSizeRel, featureArguments=, ignored=(bool), patchLevel=(int), revision=(str), srcDir=(str), version=(str)
    Latest version: 23.08.3
    Installed versions: None
    Installed revision: None

    Available versions: master, kf6, release/23.04, release/23.08, 23.04.3, 23.08.0, 23.08.1, 23.08.2, 23.08.3, 24.01.75
```

When compilation is finished, the APK packaging step is not run automatically. Invoke it manually using `--package`:

```bash
craft --package itinerary
```

## Signing APKs


The `.apk` file can be found at `/home/user/CraftRoot/tmp`. This folder is also available as `craft-kde-android/tmp` on the host system. Craft does not sign the apks, so you need to do that yourself before being able to install it onto a device. For signing an apk, you need to create a signing key first, which can be done using

```bash
keytool -genkey -noprompt -keystore key.keystore -keypass 123456  -dname "CN=None, OU=None, O=None, L=None, S=None, C=XY" -alias mykey -keyalg RSA -keysize 2048 -validity 10000 -storepass 123456
```

This key can be reused to sign all of your development apks.

Before signing the apk, it might be needed to align it.  This can be done using

```bash
zipalign -p -f -v 4 <app>.apk <app>.signed.apk
```

You can finally sign the aligned apk with your key using

```bash
apksigner sign -verbose -ks key.keystore <app>.signed.apk
```

{{< alert color="info" title="Note" >}}
The `zipalign` and `apksigner` binaries can be found at `/opt/android-sdk/build-tools/<version>/` inside the Craft container environment.
{{< /alert >}}

## Iterating on blueprints

Inside the Craft environment, the blueprints can be found by running `cs craft-blueprints-kde` and can be edited there to quickly test changes.

The source folder for an application or library can be found the same way by running `cs <projectname>`; the build folder can be found by running `cb <projectname>`.

You can quickly iterate on patches for a project by editing it in the source folder, followed by calling `ninja install` in the build folder and creating an apk file using `craft --package <appname>`.

There are much more Craft commands, take a look at the [Craft documentation](https://community.kde.org/Craft) to learn about them.

### Debugging

Use [Logcat](https://developer.android.com/tools/logcat) to view logs on Android:
1. Open Settings > "About", tap on “Build number” seven times to enable developer mode.
2. Go back > “Developer options”, check “Android debugging” or “USB debugging” under “Debugging”.
3. Connect Android device to computer.
4. Install adb (from your distribution or [Google](https://dl.google.com/android/repository/platform-tools-latest-linux.zip)).
5. Run `adb logcat`.
