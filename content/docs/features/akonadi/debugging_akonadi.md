---
title: Debugging Akonadi Resources
authors:
  - SPDX-FileCopyrightText: 2024 Carl Schwan <carlschwan@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

It is possible to debug a specific akonadi resource. This is done by restarting
akonadi with specific environment variables. For example to debug the EWS resource:

- [Heaptrack (memory profiler)](https://invent.kde.org/sdk/heaptrack) with
  `AKONADI_HEAPTRACK=akonadi_ews_resource akonadictl restart` to start the
  profiling and `akonadictl stop` to stop it.
- [Valgrid (dynamic memory analysis tool)](https://valgrind.org/) with the
  `AKONADI_VALGRIND` environment variable. By default, this uses the `memcheck`
  tool, but this can be changed with the `AKONADI_VALGRIND_SKIN` environment
  variable. More options can be passed with the `AKONADI_VALGRIND_OPTIONS`
  environment variable.
- [Perf (CPU profiler)](https://perf.wiki.kernel.org/index.php/Main_Page) with the `AKONADI_PERF`
  environment variable. This can then be visualized with
  [Hotspot](https://github.com/KDAB/hotspot).

This variables are defined in [akonadicontrol](https://invent.kde.org/pim/akonadi/-/blob/master/src/akonadicontrol/processcontrol.cpp?ref_type=heads#L164)

## Debugging the EWS resource

By using the following logging rules, Akonadi will dump the content of the
EWS responses to a temporary directory.

```bash
QT_LOGGING_RULES="*org.kde.pim.ews*=true" akonadictl restart
```