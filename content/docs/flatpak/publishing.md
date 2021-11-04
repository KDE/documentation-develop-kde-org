---
title: Your app on kdeapps
description: How to publish your manifests on KDE infrastructure
weight: 3
---

## Publishing on kdeapps

While flathub is a popular hub for flatpak'd software, it is possible to have multiple flatpak repositories due to its decentralized nature with the help of [flat-manager](https://github.com/flatpak/flat-manager). A few other flatpak repositories are GNOME Nightly, Fedora for Silverblue/Kinoite, openSUSE for MicroOS, and Winepak. The KDE Community has its own repository for nightlies, [kdeapps](https://community.kde.org/Guidelines_and_HOWTOs/Flatpak), which is [hosted on Invent](https://invent.kde.org/packaging/flatpak-kde-applications).

Kdeapps is particularly convenient for users to test applications that are new and have yet to be released or are still being developed. The repository integrates with a Jenkins instance hosted over [binary factory](https://binary-factory.kde.org/view/Flatpak/), requiring only that you submit your JSON manifests to the git repository one way or another.

One way is to fork the repository, add your manifest (either via web interface or via git), and create a merge request (MR). This process is [very extensively described in the wiki](https://community.kde.org/Infrastructure/GitLab), and requires you to create an account over [Identity](https://identity.kde.org/) first. The MR will then undergo a straightforward review process before being added.

If you are the application developer and want to take control of your flatpak package, you can instead host the JSON manifest in your application repository and make an MR to submit a fairly simple pointer file to the kdeapps repository instead, called a remoteapp. It consists of three lines:

```
ID=org.kde.yourapphere
JSON=org.kde.yourapphere.json
GITURL=https://invent.kde.org/application-group/application-repo.git
```

Your remoteapp needs to be named using your application ID + ".remoteapp", so "org.kde.yourapphere.remoteapp". You can see an example for Audiotube [here](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.audiotube.remoteapp).

If you are submitting your manifest to kdeapps, there might be situations in which your packaged application has a dependency that is used by other applications. To minimize redundancy, it may make sense to create a different file where to host that dependency, which will work exactly as a module. This has been done for [boost](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/boost.json) which is used by [kdevelop](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.kdevelop.json) and [kdiff3](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.kdiff3.json), for instance; [libkdegames](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/libkdegames.json), which is used by most KDE games; [poppler](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/poppler.json) which is used for [okular_dependencies](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/okular_dependencies.json), which in turn is used for both [okular](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.okular.json) and [kile](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.kile.json), and so on.

## Publishing on flathub

Once your application is properly packaged and is known to compile and run well, you might want to manage the packaging of your software releases. Being a nightly repository, kdeapps is not suited for this; you should prefer flathub instead.

Release flatpaks differ from git flatpaks in some ways:

You should prefer sources of type `archive` and link to the official release tarball of the software, which is usually present in https://download.kde.org. It is preferable because it is made using our integrated tool, [releaseme](https://community.kde.org/ReleasingSoftware#Creating_a_Tarball), which includes translations in the tarball. You also need to specify its release `tag` as named on its repository, and its `sha256`, which can be found by clicking on "Details" to the right of the tarball in https://download.kde.org.

If the above is impossible (like on the rare case a module doesn't have a release yet), prefer sources of type `git` and specify its `commit` in order to ensure the software compiles in reproducible manner.

There is generally no need for `desktop-file-name-suffix`.

Flathub builds software for x86_64 and aarch64. If your software for some reason does not work with aarch64 yet, you may want to use `only-arches` to restrict your builds to x86_64.

If you have not yet minimized your use of flatpak permissions (from `finish-args`), you need to do so. During the review process, the flathub maintainers should assist you with this.

After changing your package to a release, you should follow flathub's [contributing guidelines](https://github.com/flathub/flathub/blob/master/CONTRIBUTING.md). Namely, you should verify that your package follows the [app requirements](https://github.com/flathub/flathub/wiki/App-Requirements), and read the [submission guidelines](https://github.com/flathub/flathub/wiki/App-Submission) before attempting to send a PR. Most notably, unlike kdeapps, your pull request (PR) should not be sent to the `master` branch of the flathub repository, but rather the branch `new-pr`, which is empty on purpose to be a clean space so that only your files will be present.

Once you create the PR, it will undergo review. During this step, flathubbot is available to test your builds whenever you comment `bot, build org.kde.yourapphere`. It is useful to verify that your application compiles properly as though it were on flathub; if it fails, it should link to its compile logs, and if it succeeds, you should get a command to test your new package and ensure it runs.

After your package gets accepted, the content of your PR will be added to a separate repository for your app and you will be granted collaborator permissions so you can upload the updates to your manifest in the future. You should read the [maintainer guidelines](https://github.com/flathub/flathub/wiki/App-Maintenance) to learn extra information about your repository and builds. You will also be able to login to the [flathub builds](https://flathub.org/builds/) website in order to see your flatpak's build logs and control when your new update gets published.
