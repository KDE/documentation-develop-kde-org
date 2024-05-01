---
title: Nightly Flatpaks and Flathub
description: How and where to publish your manifests
weight: 3
aliases:
  - /docs/flatpak/publishing/
---

## Publishing to KDE's nightly repositories 

While Flathub is a popular hub for flatpak'd software, it is possible to have multiple flatpak repositories due to its decentralized nature. A few other flatpak repositories are GNOME Nightly, Fedora for Silverblue/Kinoite, openSUSE for MicroOS, and Winepak. The KDE Community has its own [repositories for nightlies](https://userbase.kde.org/Tutorials/Flatpak) hosted on https://cdn.kde.org/flatpak. Every repository is dedicated to one application.

The nightly repositories are particularly convenient for users to test applications that are new and have yet to be released or are still being developed. The repository integrates with GitLab CI/CD.

The following steps are required to publish your app to a nightly repository:
1. Add your JSON manifests as `.flatpak-manifest.json` to the root of your application repository
2. [Include the flatpak CI template](https://community.kde.org/Infrastructure/Continuous_Integration_System#Including_CI_templates)
3. Finally request publishing by a merge request to https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/flatpaksigner-projects.yaml (See the [detailed description](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/README.md#flatpaksigner))

Even without the 3. step (publish your app) the CI job will create `.flatpak` files in the [GitLab job artifacts](https://community.kde.org/Infrastructure/Continuous_Integration_System#Special_cases_and_job_artifacts) that are anyway convenient e.g. to test a merge request.

If you are not a KDE Developer you can fork the repository, add the manifest (either via web interface or via git), and create a merge request (MR). This process is [described in the wiki](https://community.kde.org/Infrastructure/GitLab), and requires you to create an account over [Identity](https://identity.kde.org/) first. The MR will then undergo a straightforward review process before being added.

{{< alert title="Note" color="info" >}}
The old way of building nightly Flatpaks on Binary Factory (Jenkins) with manifests hosted in https://invent.kde.org/packaging/flatpak-kde-applications is deprecated and no longer supported. You should move your manifests to the application repository as descriped above.
{{< /alert >}}

## Publishing on Flathub

Once your application is properly packaged and is known to compile and run well, you might want to manage the packaging of your software releases. Being a nightly repository, kdeapps is not suited for this; you should prefer Flathub instead.

Release flatpaks differ from git flatpaks in some ways:

You should prefer sources of type `archive` and link to the official release tarball of the software, which is usually present in [download.kde.org](https://download.kde.org). It is preferable because it is made using our integrated tool, [releaseme](https://community.kde.org/ReleasingSoftware#Creating_a_Tarball), which includes translations in the tarball. You also need to specify its release `tag` as named on its repository, and its `sha256`, which can be found by clicking on "Details" to the right of the tarball on the [download.kde.org](https://download.kde.org) website.

If the above is impossible (like on the rare case a module doesn't have a release yet), prefer sources of type `git` and specify its `commit` in order to ensure the software compiles in a reproducible manner.

There is generally no need for `desktop-file-name-suffix`.

Flathub builds software for x86_64 and aarch64. If your software for some reason does not work with aarch64 yet, you may want to use `only-arches` to restrict your builds to x86_64.

If you have not yet minimized your use of flatpak permissions (from `finish-args`), you need to do so. During the review process, the Flathub maintainers should assist you with this.

After changing your package to a release, you should follow Flathub's [contributing guidelines](https://github.com/flathub/flathub/blob/master/CONTRIBUTING.md). Namely, you should verify that your package follows the [app requirements](https://github.com/flathub/flathub/wiki/App-Requirements), and read the [submission guidelines](https://github.com/flathub/flathub/wiki/App-Submission) before attempting to send a PR. Most notably, unlike kdeapps, your pull request (PR) should not be sent to the `master` branch of the Flathub repository, but rather the branch `new-pr`, which is empty on purpose to be a clean space so that only your files will be present.

Once you create the PR, it will undergo review. During this step, flathubbot is available to test your builds whenever you comment `bot, build org.kde.yourapphere`. It is useful to verify that your application compiles properly as though it were on Flathub; if it fails, it should link to its compile logs, and if it succeeds, you should get a command to test your new package and ensure it runs.

After your package gets accepted, the content of your PR will be added to a separate repository for your app and you will be granted collaborator permissions so you can upload the updates to your manifest in the future. Congratulations, you're now the official maintainer of the package over Flathub! You should read the [maintainer guidelines](https://github.com/flathub/flathub/wiki/App-Maintenance) to learn extra information about your repository and builds. You will also be able to login to the [Flathub builds](https://flathub.org/builds/) website in order to see your flatpak's build logs and control when your new update gets published. Be sure to follow the application's development cycle and update it every so often. If, later on, you're not able to keep maintaining the package anymore, warn the relevant KDE/Flathub developers, and the KDE team will be responsible for maintaining it.
