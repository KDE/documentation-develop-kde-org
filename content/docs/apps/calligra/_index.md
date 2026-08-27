---
title: Calligra
description:
   Tutorials related to writing plugins for the Calligra office suite
weight: 1
group: "applications"
---

## Introduction

Tutorials related to writing plugins for [Calligra](https://calligra.org), the KDE office and graphics
suite. Calligra's document model and canvas tooling (Flake) are shared between all of its
applications (Words, Sheets, Stage, Karbon, ...), so a plugin written against the Flake APIs works
in any of them.

- [Generic Calligra plugin creation](generic-plugin) explains the general plugin architecture that
  every Calligra plugin type (shapes, tools, dockers, ...) is built on.
- [Flake shape creation](flake-plugin) walks through writing a `KoShape` plugin from scratch.
