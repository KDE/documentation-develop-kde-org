---
title: KRunner
titleLink: KRunner
description:
   Tutorials related to KRunner
weight: 1
group: "applications"
---

## Introduction

The Plasma Workspace provides an application called KRunner which, allows one to type
into a text area which causes various actions and information that match the
text appear as the text is being typed.

This application can be triggered with Alt+Space or Alt+F2.

The results are produced by plugins that are loaded at runtime, the same plugins are
used to generate the results for the Application Launcher. Also there is a plasmoid called
"Search" which allows one to filter all KRunner plugins.

These plugins can be written with different technologies: The traditional C++ runner that or D-Bus Runners.
The last ones are the go to solution, because you can write them in any language that support D-Bus. You will see
a tutorial on how to write such a Runner in Python. Also these runners run in separate processes, meaning that they
can't crash the application that is querying them.
