---
title: "Passing KDE Review"
weight: 3
description: >
  Do this after incubating or if the project is already
  under KDE infrastructure
---

## KDE Review

For any project to become an official part of KDE.

There are plenty of benefits to becoming a part of KDE, many of which are listed under [Benefits of a KDE Project](https://manifesto.kde.org/benefits/) and [Adding a new KDE project]({{< ref "add-project" >}}).

### Requirements
```
**KDE Review checklist**
- [ ] If from outside KDE, has completed the [Incubation](https://develop.kde.org/docs/getting-started/add-project/incubation/) process
- [ ] Follows the [Android application ID naming rules](https://developer.android.com/build/configure-app-module?hl=en#set-application-id) (only alphanumeric characters and underscore, no hyphen)
- [ ] The [REUSE Specification - Version 3.0](https://reuse.software/spec/) is applied when stating licenses and when adding license files to a project. Each source file either must contain SPDX identifiers or license headers to state under which terms the software may be used, modified and redistributed. See [Licensing Policy](https://community.kde.org/Policies/Licensing_Policy#License_Statements)
- [ ] [Passing CI job for reuse linting](https://community.kde.org/Infrastructure/Continuous_Integration_System) as well as JSON, XML and YAML where applicable
- [ ] A [Messages.sh file](https://techbase.kde.org/Development/Tutorials/Localization/i18n_Build_Systems#Writing_a_Messages.sh_script) which extracts all the i18n() translations
- [ ] A metainfo.xml file (previously appdata.xml) following the [AppStream Guidelines](https://community.kde.org/Guidelines_and_HOWTOs/AppStream)
- [ ] A screenshot in [product-screenshots](https://invent.kde.org/websites/product-screenshots)
- [ ] Check the code with some sanity tools like [clazy](https://apps.kde.org/clazy/) or [clang-tidy](https://clang.llvm.org/extra/clang-tidy), if not already done as part of CI runs
- [ ] Documentation appropriate to the project: if a library, API documentation using [QDoc](https://doc.qt.io/qt-6/qdoc-index.html), if an application, user documentation (such as a README detailing what the application does or is for, how to install/build, and other such useful information)
- [ ] A [bugs.kde.org](https://bugs.kde.org) product (file a [sysadmin ticket](https://go.kde.org/systickets/))
- [ ] Passing [Gitlab CI build jobs](https://community.kde.org/Infrastructure/Continuous_Integration_System)
- [ ] Passing [KDE neon](https://build.neon.kde.org) build
- [ ] App packages in [Flatpak](https://develop.kde.org/docs/packaging/flatpak/), [Snap](https://community.kde.org/Guidelines_and_HOWTOs/Snap), [AppImages and Windows](https://community.kde.org/Craft) etc. as appropriate
```

### Process

Projects that have passed the [Incubation]({{< ref "incubation" >}}) process and go into KDE Review usually seek to make a stable release, while projects that start using KDE infrastructure from the get go usually seek to make unstable and stable releases.

The KDE Review process allows for the KDE community to check the project for minimum standards.

If you have any translations, notify the [kde-i18n-doc mailing list](https://mail.kde.org/mailman/listinfo/kde-i18n-doc) to move the translations.

To initiate KDE Review:

- File an issue in your [KDE Invent](https://invent.kde.org) project and Label it "KDE Review Request" and paste the requirements list above into it without checking anything on it
- Make a merge request to [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata) to set the `lifecycle` key to `lifecycle: in-review` (alternatively, file a [Sysadmin ticket asking for the move to be done for you](https://go.kde.org/systickets))
- E-mail [kde-core-devel](https://mail.kde.org/mailman/listinfo/kde-core-devel) and other relevant mailing lists with details of your project and what the expected destination is for the repo
- Make fixes to issues people bring up or provide explanations why they are not (yet) fixed
- Wait at least two weeks in KDE Review
- After two months in KDE Review the repo should be moved back to playground or moved to unmaintained
