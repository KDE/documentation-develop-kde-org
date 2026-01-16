---
title: "Incubating a project into KDE"
weight: 2
description: >
  Do this if you want to move an outside project
  to KDE infrastructure
---

## Incubator
For projects which started outside of KDE.

### Requirements
```
**KDE Incubator checklist**
- [ ] Incubation Sponsor is..
- [ ] E-mailed kde-devel@ and other relevant lists on YYYY-MM-DD
- [ ] Compliance with the [https://manifesto.kde.org KDE Manifesto]
- [ ] Governance similar to the other KDE projects
- [ ] Clear product vision
- [ ] Healthy team (healthy proportion of volunteers, inclusive towards new contributors, ideally more than one developer)
- [ ] Uses English for code and communication
- [ ] Continuity agreement must be in place with KDE e.V. for domains and trademarks if the authors disappear
- [ ] Recommended to attend [Akademy](https://akademy.kde.org) or other local KDE events
- [ ] Code in [KDE Invent](https://invent.kde.org)
- [ ] Code has license set following the [KDE licensing Policy](https://community.kde.org/Policies/Licensing_Policy)
- [ ] Passing CI job for reuse linting as well as JSON, XML and YAML where applicable
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
