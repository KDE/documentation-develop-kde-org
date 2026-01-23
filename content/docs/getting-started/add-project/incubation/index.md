---
title: "Incubating a project into KDE"
weight: 2
description: >
  Do this if you want to move an outside project
  to KDE infrastructure
---

## Incubator

For projects which started outside of KDE.

There are plenty of benefits to becoming a part of KDE, many of which are listed under [Benefits of a KDE Project](https://manifesto.kde.org/benefits/) and [Adding a new KDE project]({{< ref "add-project" >}}).

For an external project to fully become part of KDE, it needs to go through the Incubation process detailed in this page as well as pass [KDE Review]({{< ref "review" >}}).

### Requirements
```
**KDE Incubator checklist**
- [ ] Incubation Sponsor is...
- [ ] E-mailed kde-devel@ and other relevant lists on YYYY-MM-DD
- [ ] Compliance with the [KDE Manifesto](https://manifesto.kde.org)
- [ ] Governance similar to the other KDE projects
- [ ] Clear product vision
- [ ] Healthy team (healthy proportion of volunteers, inclusive towards new contributors, ideally more than one developer)
- [ ] Uses English for code and communication
- [ ] Agree to a continuity plan with KDE e.V. for domains and trademarks if the authors disappear
- [ ] Recommended to attend [Akademy](https://akademy.kde.org) or other local KDE events
- [ ] Code in [KDE Invent](https://invent.kde.org)
- [ ] Code has license set following the [KDE Licensing Policy](https://community.kde.org/Policies/Licensing_Policy)
- [ ] [Passing CI job for reuse linting](https://community.kde.org/Infrastructure/Continuous_Integration_System) as well as JSON, XML and YAML where applicable
```

You can learn how to create CI jobs for REUSE compliance following the [Continuous Integration wiki page](https://community.kde.org/Infrastructure/Continuous_Integration_System).

## Process
### "Candidate" phase

The project must be hosted or moved to KDE infrastructure and have an action plan that ensures continuity in case the project team ceases activity. In other words, code should be in [KDE Invent](https://invent.kde.org) instead of Github, the issue tracker should be in the [KDE Bugzilla](https://bugs.kde.org) instead of Github Issues, etc.

Create a project on [KDE Invent](https://invent.kde.org) and import the existing code.  This can be in a personal space.  You might need to ask sysadmin to import the code. Then:

* Create an issue on the KDE Invent project with a label of "Incubation Request"
* Copy the checklist above and paste it into the issue without checking anything
* Include background on the project:
  * Describe the project to be incubated
  * List the people committing to the project
  * Agree to follow the [KDE manifesto](https://manifesto.kde.org/index.html)

Request a sponsor by sending an email to kde-devel@kde.org and other relevant lists pointing to the issue and include the same background description.

Agree with the sponsor on which of the boxes in the checklist are already complete and put `X` in those.

### "Incubating" phase
During this phase, the sponsor actively works toward getting the project set up by doing the following:
- Making sure the project developers have developer accounts
- Contacting sysadmin to get git repos set up for the developers
- Following the process to make sure it's going in the right direction and not getting stalled

At this point, the project cannot yet use the KDE brand or have a top level website on kde.org. If the project becomes stalled or does not conform to the manifesto, it gets archived (see [Stalled and Archived Projects]({{< ref "#stalled-projects" >}})).

Either the owner or the sponsor can edit the checklist as the items get completed.

### "Active" phase

During the Active phase, the project is considered to be in "playground" and may create unstable releases (alpha, beta, release candidate) as mentioned in [Understanding the software lifecycle]({{< ref "lifecycle" >}}). In practice this means being marked as `lifecycle: playground` in [repo-metadata](https://invent.kde.org/sysadmin/repo-metadata), signaling the project is not yet allowed to make stable releases.

It can then request [KDE Review]({{< ref "review" >}}) at any point, but it is most commonly done when preparing a beta. After passing KDE Review, the project team is free to work independently like other KDE teams as well as collaborate with them, following the [KDE Manifesto](https://manifesto.kde.org/) and the [Code of Conduct](https://kde.org/code-of-conduct/).

## Stalled and archived projects {#stalled-projects}
A project is considered stalled when for one year, there is no release, no commits, and no mailing-list activity. Current maintainers are contacted to check what's happening. If there is no activity or no reply from existing maintainers, after a month then a call to new maintainers is done. If a new maintainer shows up he or she gets a six month trial. If after a month no new maintainer showed up, the project gets archived.

When a project gets archived, the source repo gets closed, the mailing list disabled, and only the last download is available. If someone wants to pick it up, it goes back to the "Candidate" phase.

#### Notes
Here are notes which led to the current process:

* [Notes taken during the Akademy 2013 BoF](https://community.kde.org/Incubator/Notes/Akademy_2013_BoF)
* [Notes taken while looking at the Apache Incubator](https://community.kde.org/Incubator/Notes/Apache_Incubator)
* [Notes taken while looking at the Eclipse Incubator](https://community.kde.org/Incubator/Notes/Eclipse_Incubator)
* [Notes taken while looking at the Wikimedia Incubator](https://community.kde.org/Incubator/Notes/Wikimedia_Incubator)
