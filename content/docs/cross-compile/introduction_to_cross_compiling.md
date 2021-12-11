---
title: Introduction to Cross Compiling
linkTitle: Introduction to Cross Compiling
weight: 2
description: >
    Why cross compiling and what do you need?
---

## Why
When writing programs for embedded platforms, development often happens on host platform and testing on target platforms. However, it is not desirable to compiling project directly on the deployment target. If you happenede to writing programs for Plasma Mobile, then you will be likely to testing on PinePhone or PinePhone Pro. Compared to PC, PinePhone has weak computing power. It will be much faster to produce the binary packages on Desktop machine then deploy to PinePhone than compiling on PinePhone itself.

## What do you need
To compile binary in the format other than host platform's is called cross compile. You will need a cross compiler, libraries in the target platform's format for linking. This artile assume that you are cross compiling a KDE Qt CMake projects to PinePhone. Because the overall complexity of cross compiling, only ArchLinux and PostmarketOS based target platforms cross compiling instructions are mentioned in this article. Please refer to each platform's specific chapters.

## PostmarketOS


## ArchLinux