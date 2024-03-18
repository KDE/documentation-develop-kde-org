---
title: "Adding a new KDE project"
linkTitle: "New project"
weight: 6
description: >
  How to make your project be a part of the KDE community
group: "getting-started"
aliases:
  - /docs/getting-started/new-project/
---

To add a new application or library to the KDE ecosystem,
follow the Incubator and/or KDE Review processes as described
below.

You will need a [KDE Identity](https://identity.kde.org/index.php?r=registration/index) to use [KDE Invent](https://invent.kde.org).

## Incubator
For projects which started outside of KDE.

### Requirements
```
**KDE Incubator checklist**
- [ ] Incubation Sponsor is..
- [ ] E-mailed kde-devel@ and other relevant lists on YYYY-MM-DD
- [ ] Compliance with the [http://manifesto.kde.org KDE Manifesto]
- [ ] Governance similar to the other KDE projects
- [ ] Clear product vision
- [ ] Healthy team (healthy proportion of volunteers, inclusive towards new contributors, ideally more than one developer)
- [ ] Uses English for code and communication
- [ ] Continuity agreement must be in place with KDE e.V. for domains and trademarks if the authors disappear
- [ ] Recommended to attend [Akademy](https://akademy.kde.org) or other local KDE events
- [ ] Code in [KDE Invent](https://invent.kde.org)
- [ ] Passing CI job for reuse linting
```

You can learn how to create CI jobs for REUSE compliance following the [Continuous Integration wiki page](https://community.kde.org/Infrastructure/Continuous_Integration_System).

### Process
#### "Candidate" Phase
Create a project on [KDE Invent](https://invent.kde.org) and import the existing code.  This can be in a personal space on KDE Invent.  You might need to ask sysadmin to import the code.

Create an issue on the KDE Invent project with a label of "Incubation Request". Copy the checklist above and paste it into the issue without checking anything first, then include background on the project: a description of the project to be incubated, a list of the people committing to the project, and a plan to be in compliance with the [KDE manifesto](https://manifesto.kde.org/index.html). The project must be hosted or moved to KDE infrastructure (or have an action plan that ensures continuity). In other words, code should be in KDE Invent instead of Github, the issue tracker should be in the [KDE Bugzilla](https://bugs.kde.org) instead of Github Issues, etc.

Send an email to kde-devel@kde.org and other relevant lists requesting a sponsor pointing to the issue and including the same background description.

Agree with the sponsor which of the boxes in the checklist is already complete and put X in those.

#### "Incubating" Phase
During this phase, the sponsor actively works toward getting the project set up by doing the following:
- Making sure the project developers have developer accounts
- Contacting sysadmin to get Git repos (in the playground area) set up for the developers
- Following the process to make sure it's going in the right direction and not getting stalled

At this point, the project cannot yet use the KDE brand or have a top level website on kde.org. If the project becomes stalled or does not conform to the manifesto, it gets archived (see below).

Either the owner or the sponsor can edit the checklist as the items get completed.

#### "Active" Phase
During the Active phase, the project enters Playground.  When it is nearing a beta release it can be moved to KDE Review. The project team is assumed and expected to behave like other KDE teams and respect the KDE manifesto.

### Stalled and Archived Projects
A project is considered stalled when for one year, there is no release, no commits, and no mailing-list activity. Current maintainers are contacted to check what's happening. If there is no activity or no reply from existing maintainers, after a month then a call to new maintainers is done. If a new maintainer shows up he or she gets a six month trial. If after a month no new maintainer showed up, the project gets archived.

When a project gets archived, the source repo gets closed, the mailing list disabled, and only the last download is available. If someone wants to pick it up, it goes back to the "Candidate" phase.

#### Notes
Here are [notes](https://community.kde.org/Incubator/Notes) which led to the current process.

## KDE Review
For any project to become an official part of KDE.

### Requirements
```
**KDE Review checklist**
- [ ] If from outside KDE, has completed the [Incubator](https://community.kde.org/Incubator) process
- [ ] The [REUSE Specification - Version 3.0](https://reuse.software/spec/) is applied when stating licenses and when adding license files to a project. Each source file either must contain SPDX identifiers or license headers to state under which terms the software may be used, modified and redistributed. See [Licensing Policy](https://community.kde.org/Policies/Licensing_Policy#License_Statements)
- [ ] Passing CI job for Reuse linting
- [ ] A [Messages.sh file](https://techbase.kde.org/Development/Tutorials/Localization/i18n_Build_Systems#Writing_a_Messages.sh_script) which extracts all the i18n() translations
- [ ] A metainfo.xml file (previously appdata.xml) with AppStream data [AppStream Guidelines](https://community.kde.org/Guidelines_and_HOWTOs/AppStream )
- [ ] A screenshot in [product-screenshots](https://invent.kde.org/websites/product-screenshots)
- [ ] Check the code with some sanity tools like [clazy](https://kde.org/applications/development/org.kde.clazy) or [clang-tidy](https://clang.llvm.org/extra/clang-tidy), if not already done as part of CI runs.
- [ ] Documentation appropriate to the project: if a library, API documentation (such as [Doxygen](https://www.doxygen.nl/) for C++), if an application, user documentation (such as a README detailing what the application does or is for, how to install/build, and other such useful information)
- [ ] A [bugs.kde.org](https://bugs.kde.org) product (file a [sysadmin ticket](https://community.kde.org/Sysadmin))
- [ ] Passing [Gitlab CI build jobs](https://mail.kde.org/pipermail/kde-devel/2021-September/000717.html)
- [ ] Passing [KDE neon](http://build.neon.kde.org/) build
- [ ] App packages in [Flatpak](https://develop.kde.org/docs/packaging/flatpak/), [Snap](https://community.kde.org/Guidelines_and_HOWTOs/Snap), [AppImages and Windows](https://community.kde.org/Craft) etc. as appropriate
```

### Process
Projects move into KDE Review when they are ready to start making beta or stable releases. It allows for the KDE community to check over for minimum standards.  If you have any translations notify the [kde-i18n-doc mailing list](https://mail.kde.org/mailman/listinfo/kde-i18n-doc) to move the translations.
- File an issue in your [KDE Invent](https://invent.kde.org) project and Label it "KDE Review Request" and paste the requirements list above into it without checking anything on it
- You can change the `projectpath` in [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata) by editing `metadata.yaml` for the project. See [repo-metadata README](https://invent.kde.org/sysadmin/repo-metadata/-/blob/master/README.md) or file a [Sysadmin ticket asking for the move](https://go.kde.org/systickets)
- E-mail [kde-core-devel](https://mail.kde.org/mailman/listinfo/kde-core-devel) and other relevant mailing lists with details of your project and what the expected destination is for the repo
- Make fixes to issues people bring up or provide explanation why they are not (yet) fixed
- Wait at least two weeks in KDE Review
- After two months in KDE Review the repo should be moved back to playground or moved to unmaintained
