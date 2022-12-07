---
title: "Building applications for Android"
linkTitle: "Building applications for Android"
weight: 2
description: >
  Learn how to build your applications for Android
---

## Building Applications

Building .apk files from Qt Applications requires a cross-compiling toolchain, which is hard to setup. To simplify this, there is a ready-to-use Docker container for building KDE applications.

This documentation only applies to applications that have a craft blueprint in the [craft-blueprints-kde](https://invent.kde.org/packaging/craft-blueprints-kde) repository. If the application you want does not have such a blueprint yet, have a look at [the documentation](https://community.kde.org/Craft/Blueprints).

The container can be initialized with
```bash
mkdir craft-kde-android
docker run -ti --rm -v $PWD/craft-kde-android:/home/user/CraftRoot kdeorg/android-sdk craft-bootstrap
```

{{< alert color="info" title="Note" >}}
If this fails with an error similar to "Permission denied", you may need to disable SELinux while using craft by running `sudo setenforce 0`
{{< /alert >}}

The container will prompt you for the desired target architecture (arm32, arm64, x86_32 or x86_64) and possible other prompts.

You can then build an application by running

```bash
docker run -ti --rm -v $PWD/craft-kde-android:/home/user/CraftRoot kdeorg/android-sdk craft <appname>
```

and package it using

```bash
docker run -ti --rm -v $PWD/craft-kde-android:/home/user/CraftRoot kdeorg/android-sdk craft --package <appname>
```

Alternatively, you can enter the container using

```bash
docker run -ti --rm -v $PWD/craft-kde-android:/home/user/CraftRoot kdeorg/android-sdk bash
```

and run the craft commands locally (e.g. `craft <appname>`, `craft --package <appname>`).

Inside the container, the blueprints can be found by running `cs craft-blueprints-kde` and can be edited there to quickly test changes.

The source folder for an application or library can be found the same way by running `cs <projectname>`; the build folder can be found by running `cb <projectname>`.

You can quickly iterate on patches for a project by editing it in the source folder, followed by calling `ninja install` in the build folder and creating an apk file using `craft --package <appname>`.

The `.apk` file can be found at `/home/user/CraftRoot/tmp`. This folder is also available as `craft-kde-android/tmp` on the host system. Craft does not sign the apks, so you need to do that yourself before being able to install it onto a device. For signing an apk, you need to create a signing key first, which can be done using

```bash
keytool -genkey -noprompt -keystore key.keystore -keypass 123456  -dname "CN=None, OU=None, O=None, L=None, S=None, C=XY" -alias mykey -keyalg RSA -keysize 2048 -validity 10000 -storepass 123456
```

This key can be reused to sign all of your development apks. You can sign an apk with it using

```bash
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.keystore <app>.apk mykey -keypass 123456 -storepass 123456
```
