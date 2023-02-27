---
title: Distributing KDE Software as Snap
author:
  - SPDX-FileCopyrightText: 2023 Thiago Masato Costa Sueto <thiago.sueto@kde.org>
weight: 4
description: Package your application as a Snap.
---

# Put Your App in the Snap Store

{{< figure src="snapstore-kde.png" caption="Snap Store KDE Page" >}}

It is a KDE goal to be [All About the Apps](https://kde.org/goals/) to deliver our apps directly to our users. Snaps are one of the ways to do this. Snaps are Linux app packages that can run on pretty much any Linux distro. There is a single centralised Snap store that delivers them to users. Take a look at the [KDE page on the Snap Store](https://snapcraft.io/publisher/kde) to see what's available.

## Snap intro {#snap_intro}

A Snap package typically contains all the files, including libraries and data files, to run the app. There are also Content Snaps which contain reuseble libraries. In KDE land we have the [KDE Frameworks Content Snap](https://snapcraft.io/kde-frameworks-5-qt-5-15-core20) which includes recent Qt and KDE Frameworks and this is shared between all KDE apps so we do not have to waste disk space and build resources.

Give it a try by installing a package or two on your system `snap install kcalc`. And run kcalc from your apps menu.

This will have downloaded the kcalc Snap package from the Snap store into e.g. `/var/lib/snapd/snaps/kcalc_73.snap` and mounted it into e.g. `/snap/kcalc/current/`. You can also just download it to a local directory with `snap download kcalc`, use `lesspipe kcalc*snap` to see what it inside it.

`snap list` will show your currently installed snaps and it will now show that you have `kcalc` and the content snap `kde-frameworks-5-qt-5-15-core20` as well as the `core20` content snap installed.

Snaps are containers, similar to Docker. From inside the Snap container access to the file system and system resources are limited. This is good for inter-app security but means the app sees your system quite differently from how it might expect. You can "log" into the container with `snap run --shell kcalc` to have a look at how the Snapped kcalc app sees your system.

To give the app controlled permissions to the system it plugs connections into resources such as the network or container snaps. Run `snap connections kcalc` to see what it gets given access to. The connections are controlled by the store and app maintainers need to ask the store to apply the auto-connections. They can also be overridden locally.

You can take a look at the snap package with `snap download kcalc` which will download files such as `kcalc_73.assert` and `kcalc_73.snap`. The .assert has the checksums and signatures for the package. The .snap has the (non-store) metadata and all the files of the package. `lesspipe kcalc_73.snap` to take a look.

## Concepts

Snaps are usually one app per Snap package. The Snap package contains all the libraries and resources it needs to run except those in the shared content kde-frameworks Snap.

In practice this means all of Qt and KF5 including Breeze icons and themes are in the kde-frameworks content Snap and your app Snap only needs to compile its own sources. If you apps needs other libraries it can either install these as Apt packages from the Ubuntu or KDE neon or other repository, or it can compile them from source as well. You will need to manually list the build-packages (all the -dev packages) and the stage-packages used in the final package, it'll warn you if any final libraries it expects are missing.

**Snapcraft** is used to build snaps. It can be installed as a snap with
`snap install snapcraft --classic`. Snap packages are defined with
snapcraft.yaml files. Snapcraft will build them inside a virtual
machine, we use LXD to build the KDE ones (the default is to use
Multipass another virtual machine manager but that has problems on cloud
machines). Using a virtual machine makes it reliable to build the Snaps
on any system with identical results.

snapcraft.yaml files are kept in [snapcraft-kde-applications Git
repo](https://invent.kde.org/packaging/snapcraft-kde-applications). They
can be built on the [KDE Invent
CI](https://invent.kde.org/packaging/snapcraft-kde-applications/-/pipelines).
[.gitlab-ci.yml](https://invent.kde.org/packaging/snapcraft-kde-applications/-/blob/Neon/release/.gitlab-ci.yml)
has one entry for each snap. The CI sends it off to [KDE's Launchpad
account](https://launchpad.net/~kde-community/+snaps) to build them on
amd64 and arm64. If successful it downloads them then uploads them to
the Snap store in the Candidate channel ready for testing.

Our Snaps read metadata from AppStream metadata files so it is important
the metadata is up to date including current release versions.

The [Snap Store](https://snapcraft.io/) is the centralised app store by
Canonical. There is no practical way to use other stores or repositories
with Snaps. It is what Snapcraft uploads built snaps to and what your
local snapd will download and install snaps from. It also says what
permissions those snaps should have. As an app developer if you want
your app to have extra permissions (for example
[kdf](https://invent.kde.org/packaging/snapcraft-kde-applications/-/blob/Neon/release/snapcraft.yaml)
uses mount-observe) then you need to ask for it on the [snapcraft
forum](https://forum.snapcraft.io/t/request-for-connection-kdf-mount-observe/10953).

A Classic containment Snap has no restrictions on what files it can see
on your system or what external executable can be run. This is useful
for IDEs and similar apps such as
[Kate](https://forum.snapcraft.io/t/kate-as-classic-snap/23514) which
runs external programs. Again this needs to be set in your
[snapcraft.yaml](https://invent.kde.org/packaging/snapcraft-kde-applications/-/blob/Neon/release/snapcraft.yaml#L3)
then you need to ask on the Snap forum for the store to set it to
classic. The Store will then tell snapd for anyone installing the Snap
to have it installed as a Classic confinement Snap.

The KDE account on the Snap store is run by the Snap team developers
Jonathan Esk-Riddell and Harald Sitter and Scarlett Moore and ppd. One
Snap on the store can be shared between more than one account so app
maintainers can also create a separate account if they want to have more
control over when their app is released and what the store says about
it.

The store has four channels for different levels of stability. Our
stable branch builds get uploaded to the Candidate channel and can be
moved to the Stable channel once tested.

## Example

[Blinken](https://apps.kde.org/blinken/) is an exciting memory game from
KDE. It's [available on the Snap store](https://snapcraft.io/blinken).
The Snap package is defined by a `snapcraft.yaml` file which is in the
`Neon/release` branch of [KDE neon's Blinken
packging](https://invent.kde.org/neon/kde/blinken/-/blob/Neon/release/snapcraft.yaml).
Any update to that branch triggest a build of the [Blinken Snap
job](https://build.neon.kde.org/view/Snaps/job/focal_stable_kde_blinken_snap_amd64/)
in KDE neon's Jenkins builder. If the build is successful it will be
uploaded to the `Candidate channel` of the Snap store ready for review.



The `snapcraft.yaml` file looks like this:

```yaml
---
name: blinken
confinement: strict
grade: stable
base: core20
adopt-info: blinken
apps:
    blinken:
        extensions:
        - kde-neon
        common-id: org.kde.blinken.desktop
        command: usr/bin/blinken
        plugs:
        - home
        - network
        - network-bind
        - audio-playback
        - removable-media
slots:
    session-dbus-interface:
        interface: dbus
        name: org.kde.blinken
        bus: session
package-repositories:
-   type: apt
    components:
    - main
    suites:
    - focal
    key-id: 444DABCF3667D0283F894EDDE6D4736255751E5D
    url: http://origin.archive.neon.kde.org/user
    key-server: keyserver.ubuntu.com
parts:
    blinken:
        plugin: cmake
        build-packages:
        - libkf5doctools-dev
        - libphonon4qt5-dev
        - libphonon4qt5experimental-dev
        source: http://download.kde.org/stable/release-service/20.12.3/src/blinken-20.12.3.tar.xz
        cmake-parameters:
        - "-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
        - "-DCMAKE_INSTALL_PREFIX=/usr"
        - "-DCMAKE_BUILD_TYPE=Release"
        - "-DENABLE_TESTING=OFF"
        - "-DBUILD_TESTING=OFF"
        - "-DKDE_SKIP_TEST_SETTINGS=ON"
        - "-DCMAKE_FIND_ROOT_PATH=/usr\\;/root/stage\\;/snap/kde-frameworks-5-qt-5-15-core20-sdk/current"
        parse-info:
        - usr/share/metainfo/org.kde.blinken.appdata.xml
        filesets:
            exclusion:
            - "-usr/lib/*/cmake/*"
            - "-usr/include/*"
            - "-usr/share/ECM/*"
            - "-usr/share/doc/*"
            - "-usr/share/man/*"
            - "-usr/share/icons/breeze-dark*"
            - "-usr/bin/X11"
            - "-usr/lib/gcc/x86_64-linux-gnu/6.0.0"
            - "-usr/lib/aspell/*"
        prime:
        - "$exclusion"
```
Check [Snapcraft YAML
reference](https://snapcraft.io/docs/snapcraft-yaml-reference) if
unsure.

### Top Level

-   name: blinken ← the snap name registered on the snap store
-   confinement: strict ← Snaps are a containerised format and can't
    see the outside system from inside their container. Strict is the
    normal container method. Classic is also possible which allows it to
    see the outside system and is used by e.g. Kate because Kate needs
    to run external programs like Git. It can only be Classic on
    request. Can also be devmode for testing.
-   grade: stable ← It must be stable to be in a released channel, can
    also be devel.
-   base: core20 ← which base system to build on, core20 means Ubuntu
    20.04 and is the current recommended.
-   adopt-info: blinken ← Which Snap part to get the appstream info
    from. This sets version, icon, description.

You might also need to add `version` if it is not in the appstream file.
This is just a version read by users it does not affect the revision
number which is tracked by the store.

### apps

```yaml

apps:
    blinken:
        extensions:
        - kde-neon
        common-id: org.kde.blinken.desktop
        command: usr/bin/blinken
        plugs:
        - home
        - network
        - network-bind
        - audio-playback
        - removable-media
```
`apps` are the programs which the snap includes for users to run.
Usually there is only one in a Snap but sometimes e.g.
[Calligra](https://invent.kde.org/neon/extras/calligra/-/blob/Neon/release/snapcraft.yaml)
there are more than one.

The [KDE neon extension](https://snapcraft.io/docs/kde-neon-extension)
adds some commonly used features to the KDE snaps including using the
[KDE Frameworks 5 content
Snap](https://snapcraft.io/kde-frameworks-5-qt-5-15-core20).

The `common-id` comes from the Appstream file. You *must* check what it
is in the appstream file. `org.kde.blinken.appdata.xml` contains
`org.kde.blinken.desktop` so we use that.
Sometimes apps use the .desktop and sometimes they don't, this is at
random.

The command to run is listed. The KDE neon extension will run a script
first which sets many necessary environment variables.

The plugs give access to the outside system, see [Supported
interfaces](https://snapcraft.io/docs/supported-interfaces) for
descriptions. When a Snap is installed from the Store it is up to the
Store to say which plugs get used. Thost listed as auto connect in the
docs are permitted. Otherwise you must ask on the Snap forum for
permission to have the Snap connected. (Locally installed snaps with
`--devmode` have access to everything, you can also manually connect
snaps to interfaces on your local system.)

`slots` are the complement to plugs, they allow the outside system to
access our Snap app. In this case we are allowing a dbus interface into
the Snap. All KDE apps have a dbus interface and you can check what it
is called by running the app and using `qdbus`.

`package-repositories` add the KDE neon apt repo to build against, this
will give you the latest libraries to compile with.

The source of a Snap is the `parts` and some snaps have several parts
made of different sources e.g.
[KTorrent](https://invent.kde.org/packaging/snapcraft-kde-applications/-/tree/Neon/release/ktorrent/snapcraft.yaml)
has both libktorrent and ktorrent parts. Blinken is not complex so it
has only one part made of the compiles Blinken source.

### Parts

-   plugin ← which [Snap build
    plugin](https://snapcraft.io/docs/supported-plugins) to use
-   build-packages ← most build packages are in the KDE Frameworks
    content snap but some need added explicitly and some are not in
    there. They will be downloaded from the neon and ubuntu apt repos.
    [KTorrent](https://invent.kde.org/neon/extras/ktorrent/-/blob/Neon/release/snapcraft.yaml#L40)
    uses non-KDE libraries and it needs to list the -dev packages in the
    `build-packages` then the library itself in the `stage-packages`.
-   source ← link to the tar
-   cmake-parameters ← copy and paste this, it sets the right paths.
-   parse-info ← where the appstream file is to be installed
-   filesets and prime ← snap parts get build then copied into a `stage`
    area, when all the parts are built they are copied into the `prime`
    area which is converted into the Snap package. This lists a common
    set of excluded files we do not want copied. You can add more here
    if you end up with unnecessary files in your snap.

## Building

Install snapcraft with `snap install snapcraft --classic`.

In the directory with the `snapcraft.yaml` run:
`snapcraft --enable-experimental-extensions --use-lxd`

This will start a virtual machine and build the package. If all is well
you will have `blinken_20.12.3_amd64.snap` or similar created.

Install with `snap install --devmode blinken_20.12.3_amd64.snap`

Run with `snap run blinken` or check it is in the app menu and run from
there (remove any versions of blink you have installed from your normal
distro packages just to be sure).

## Quirks

### alsa

Some KDEGames use libkdegames's KgSound class which uses libopenal
which uses libsnd which uses alsa. (Most other KDE software uses
QtMultimedia or Phonon which uses Pulseaudio.) See
[KBlocks](https://invent.kde.org/neon/kde/kblocks/-/blob/Neon/release/snapcraft.yaml)
for one way to make this work. Use the alsa extension, use layers to
move files around, exclude the pulse alsa file.

### Qt Only

You may want to simplify your Snap by using Qt directly instead of the
KDE neon extension and KDE Frameworks content Snap. Good luck :)

### Patches

If you need to update some code in the release you can patch it in the
Snap package. But please get the patch upstream into the Git archive
first.

[Falkon does
this](https://invent.kde.org/neon/neon-packaging/falkon/-/blob/70fb51728cc9c9f6da4d417bca96e2c34c96c52c/snapcraft.yaml#L45).

## Help

[Snapcraft docs](https://snapcraft.io/docs) including tutorials on using
and building [snapcraft.yaml
format](https://snapcraft.io/docs/snap-format) [Snap
forum](https://forum.snapcraft.io/) for asking for help or asking to get
the store to allow your Snaps to auto connect. [KDE neon
devs](https://webchat.kde.org/#/room/#kde-neon:kde.org) talk to Riddell
or Sitter for help getting your app into KDE neons builds and into the
Store.

## Glossary

Words you'll hear and not know what they mean:

-   **snap**: The actual package format.
-   **snapd**: The daemon that manages snap on a system.
-   **snapcraft**: The build tool for building a snap.
-   **app**: In the context of snapcraft/snapd this is the (portable)
    description of an 'executable' exposed to the outside (i.e.
    something snapd knows how to run).
-   **parts**: In the context of snapcraft a part refers to one build
    entity. They describe where to get the source of the entity, how to
    build it, how to stage it into the final snap and which other parts
    are a dependency and need to be built first. A part is much like a
    "makefile" target.
-   **interfaces**: A way for a snap to talk to the outside world (or
    another snaps). Split into slots and plugs. Each of which has their
    own security permissions as a client may need to be able to do
    different things from a server.
    <https://docs.snapcraft.io/interface-management>
-   **slot**: The provider part of an interface. e.g. a kwin snap might
    have a wayland-client slot which exposes a way for clients to talk
    to kwin.
-   **plug**: The client part of an interface. e.g. an application may
    plug into the wayland-client slot of kwin to talk to it.
-   **Core**: A special snap containing the core aspects of any Linux OS
    (libc/libpthread/...). All snaps depend on exactly one core which
    provides the snap's understanding of what will be in "/" from the
    snap's POV. The core does not include a kernel! Kernels may be
    snaps.
-   **Content Snap**: Special kind of snap that implements the
    "content" interface. It's kind of like a shared dependency
    between snaps allowing one snap to be bound into the scope of
    another snap. For example the KF5 content snap may be used to share
    all of KF5 across multiple snaps.
-   **Build Snap**: Also a special kind of snap, it's the build-time
    variant of the Content Snap and contains header files etc. necessary
    to build against a Content Snap.
-   **stage**, **staging**: As part of snapcrafting parts get
    "staged". This kind of means the same as make install, but it's
    actually a separate step after make install. For the process of
    staging, snapcraft will copy all files created by make install into
    a stage directory. You may also exclude certain files or reorganize
    the files (e.g. rename, or move to different directory). The stage
    is available for parts ordered after the current one, meaning that
    they for example can link against a newly built library.
-   **prime**, **priming**: Is similar to staging but happens once all
    parts are built and staged. Priming is the process by which the snap
    tree is actually constructed. Priming, like staging, allows for
    excluding files (e.g. dev headers may be staged so other parts can
    build using them but later excluded from priming and thus left out
    of the final bundle).
