---
title: "Building KDE software with distrobox and podman"
description: "The best solution for immutable distributions"
weight: 51
group: "containers"
---

If you use a really old Linux distribution that does not have the base system dependencies needed for kdesrc-build like an older long term support distribution such as [RHEL](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux), or use an immutable distribution like [openSUSE Kalpa](https://en.opensuse.org/Portal:Kalpa), [Fedora Kinoite](https://fedoraproject.org/atomic-desktops/kinoite/) or the [SteamOS on the Steam Deck](https://store.steampowered.com/steamdeck), you will not be able to build KDE software directly with kdesrc-build or manually with CMake.

Instead, you can build KDE software inside a container. Distrobox eases the container development workflow by letting you run commands inside the container while still able to see your home directory by default.

Additionally, distrobox has the ability to run graphical applications from within the container.

You will be able to run [kdesrc-build inside a container]({{< ref "#with-kdesrc-build" >}}) just fine, with the caveat that you won’t be able to run a Plasma Desktop session from the login screen.

You can also build KDE software by [running CMake commands inside the container]({{< ref "cmake-build" >}}) just like you would outside the container.

## Setting up distrobox {#setup}

If your Linux distribution is *not* immutable, install distrobox and podman from your distribution repositories:

* Debian/Ubuntu: `sudo apt install distrobox podman`
* openSUSE: `sudo zypper install distrobox podman`
* Fedora: `sudo dnf install distrobox podman`
* Arch: `sudo pacman --sync distrobox podman`

On immutable distributions like openSUSE Kalpa, Fedora Kinoite, and SteamOS on the Steam Deck) you should already have both podman and distrobox available by default.

If you experience any problems, need a more up-to-date version, or your chosen distribution lacks distrobox, you can use an [official alternative method](https://distrobox.it/#alternative-methods) to install distrobox:

```bash
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local
```

On the Steam Deck, you will additionally need to add `~/.local/bin` to the `$PATH` in your `.bashrc` (or equivalent in your preferred shell):

```bash
export PATH=$PATH:~/.local/bin
```

And add the following to a new file `~/.config/distrobox/distrobox.conf`. It will allow to run graphical applications directly from the distrobox:

```bash
xhost +si:localuser:deck
```

## Building KDE software with distrobox + kdesrc-build {#with-kdesrc-build}

Since kdesrc-build allows to build the most bleeding edge KDE software and its dependencies, all you need to build is a sufficiently up-to-date distribution. In this case it is sufficient to use standard [openSUSE Tumbleweed](https://hub.docker.com/r/opensuse/tumbleweed/), [Fedora](https://hub.docker.com/_/fedora/), or [Arch Linux](https://hub.docker.com/_/archlinux) containers.

After having installed distrobox, run *only one* of the following commands to create a new distrobox image:

* openSUSE Tumbleweed: `distrobox create --image docker.io/opensuse/tumbleweed --name opensuse`
* Fedora: `distrobox create --image docker.io/fedora --name fedora`
* Arch Linux: `distrobox create --image docker.io/archlinux --name arch`

Distrobox will tell podman to pull the images from Dockerhub, create an appropriate container, and name it as specified in the command.

After it is finished, run the following:

```bash
distrobox enter <containername>
```

Distrobox will take some time to configure the container the first time, and then you will automatically enter the container.

Inside the container you will now have access to development packages like git, CMake, KDE frameworks libraries and other such things.

Follow the [tutorial for setting up kdesrc-build]({{< ref "kdesrc-build-setup" >}}), including the installation commands that require `sudo`, and the experience should be the same as if you were following the kdesrc-build tutorial in a non-immutable Linux distribution. 

Whenever you want to get back to developing with kdesrc-build inside the container, remember to use the above `distrobox enter <containername>` command to enter the container before building or running the application.

From this point on, the kdesrc-build tutorial should be followed instead.

Note that the container size will stay relatively tiny, but kdesrc-build will require as much disk space as necessary to build the software you specify and all its dependencies.

## Building KDE software with distrobox + manual compilation {#with-cmake}

In certain cases you may find kdesrc-build to be overkill for what you want to do, for example if you just intend on working on a specific desktop application. You might otherwise be restricted by storage space and cannot afford to compile dozens of projects just to build the one project you want.

While containers also require a significant amount of storage, they often require much less than kdesrc-build.

### For non-bleeding edge software

You can use sufficiently up-to-date containers like [openSUSE Tumbleweed](https://hub.docker.com/r/opensuse/tumbleweed/), [Fedora](https://hub.docker.com/_/fedora/), or [Arch Linux](https://hub.docker.com/_/archlinux) to develop KDE software, as long as the software does not have bleeding edge dependencies.

After having installed distrobox, run *only one* of the following commands to create a new distrobox image:

* openSUSE Tumbleweed: `distrobox create --image docker.io/opensuse/tumbleweed --name opensuse`
* Fedora: `distrobox create --image docker.io/fedora --name fedora`
* Arch Linux: `distrobox create --image docker.io/archlinux --name arch`

Distrobox will tell podman to pull the images from Dockerhub, create an appropriate container, and name it as specified in the command.

After it is finished, run the following:

```bash
distrobox enter <containername>
```

Then you can proceed to start building KDE software using our guide on [building KDE software manually with CMake]({{< ref "cmake-build" >}}).

### For bleeding edge software

Some KDE software, such as [Itinerary](https://apps.kde.org/itinerary/) or [Neochat](https://apps.kde.org/neochat/), has *very* rapid development and will require bleeding edge dependencies, in which case the above distribution containers will not suffice. To avoid having to compile and manage dependencies yourself, you can use containers that already come with KDE libraries built from the latest master branch.

There are two main ones:

* [KDE neon Unstable](https://community.kde.org/Neon/Containers), which already comes ready to use
* [openSUSE Krypton](https://en.opensuse.org/SDB:KDE_repositories), which needs to be manually added to an existing openSUSE Tumbleweed container

KDE neon Unstable is more straightforward to use since there is a container built for it already. At the time of writing, openSUSE Krypton has no such container, but it can be easily created by using an openSUSE Tumbleweed base.

For KDE neon Unstable, run the following:

```bash
distrobox create --image invent-registry.kde.org/neon/docker-images/plasma:unstable
distrobox enter plasma-unstable
```

This will automatically create a distrobox container named `plasma-unstable` and enter it. You can then start building KDE software using our guide on [building KDE software manually with CMake]({{< ref "cmake-build" >}}).

Note that the plasma-unstable image size is 5.6 GiB and it can grow over time, so plan your disk space accordingly.

For openSUSE Krypton, first create and enter an openSUSE Tumbleweed container. It will be called `krypton` since that will be the end result.

```bash
distrobox create --image docker.io/opensuse/tumbleweed --name krypton
distrobox enter krypton
```

After that, follow [openSUSE’s instructions on adding builds from git master on Tumbleweed](https://en.opensuse.org/SDB:KDE_repositories#Adding_these_repos_to_an_existing_installation), using `sudo`:

```bash
sudo zypper addrepo --refresh --priority 75 https://download.opensuse.org/repositories/KDE:/Unstable:/Qt/openSUSE_Tumbleweed/ KDE:Unstable:Qt
sudo zypper addrepo --refresh --priority 75 https://download.opensuse.org/repositories/KDE:/Unstable:/Frameworks/openSUSE_Factory/ KDE:Unstable:Frameworks
sudo zypper addrepo --refresh --priority 75 https://download.opensuse.org/repositories/KDE:/Unstable:/Applications/KDE_Unstable_Frameworks_openSUSE_Factory/ KDE:Unstable:Applications
sudo zypper addrepo --refresh --priority 75 https://download.opensuse.org/repositories/KDE:/Unstable:/Extra/KDE_Unstable_Frameworks_openSUSE_Factory/ KDE:Unstable:Extra
sudo zypper --verbose dist-upgrade --allow-vendor-change
```

The prepended `sudo` is necessary to make sure the packages get installed in the container. The instructions above are the same as the openSUSE ones, but with long flags to make the command clearer.

After the distribution upgrade inside the container, Tumbleweed will have turned into Krypton.

If the distribution upgrade process asks you too many questions to resolve, you can press `Ctrl + C` to cancel it and repeat the last command with an added `--force-resolution`:

```bash
sudo zypper --verbose dist-upgrade --allow-vendor-change --force-resolution
```

You can now finally start building KDE software using our [guide on building KDE software manually with CMake]({{< ref "cmake-build" >}}).

## Limitations of using containers

Containers are typically designed to be lean, not to provide a full desktop experience. As such, they usually do not come with software that would otherwise come preinstalled in typical desktop systems, and so you will often need to search manually for the missing software.

For that, we have a [tutorial on installing missing build dependencies]({{< ref "help-dependencies" >}}).

In addition to this, there are a few pieces of software with very common use cases that can be missing from containers by default:

* qqc2-desktop-style, for QtQuick/Kirigami applications to use the correct Breeze theme
* breeze and breeze-icons, for theme support
* the QtWayland development library, for applications inside the container to run as native Wayland windows

Another limitation is the inability to [run a full Plasma session built with kdesrc-build]({{< ref "kdesrc-build-compile#plasma" >}}) from inside containers. While this is [theoretically possible](https://distrobox.it/posts/run_latest_gnome_kde_on_distrobox/), it has not been tested or documented and it is unlikely to be supported.
