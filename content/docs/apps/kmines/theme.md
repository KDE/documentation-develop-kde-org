---
title: Making a KMines theme
description: How to add a theme to KMines.
weight: 1
authors:
  - SPDX-FileCopyrightText: 2023 Nathan Upchurch <nathan@upchur.ch>
SPDX-License-Identifier: CC-BY-SA-4.0
---
## Introduction
This short tutorial will show you how to add a theme to KMines. It is assumed that you already have a working dev environment, you are familiar with building KDE software using [kde-builder]({{< ref "kde-builder-setup" >}}), and you are able to use a vector editing program such as Inkscape and a raster editing program such as Krita to create and export images. You should already have a local copy of the KMines source via `kde-builder kmines`. By the end of this tutorial, you will know what is necessary to create a KMines theme, and how to include them in the KMines source code.

## Components of a KMines theme
A KMines theme requires the following components:

1. SVG theme - the actual SVG file.
2. Theme preview - a 210 x 210 px PNG file that will be shown in Settings > Configure KMines > Themes.
3. Theme .desktop file - a file containing information about your theme.


## Step one: Create your SVG theme file
The easiest way to begin is to edit a copy of an existing theme in the KMines source code. If you have followed the [kde-builder]({{< ref "kde-builder-setup" >}}) tutorial, the source code should be in `~/kde/src/kmines`. Existing themes can be found in the `themes/` directory.

Elements of your theme are identified using their IDs. If you are editing your SVG in Inkscape, you can set the ID of an element by right clicking on the element you want to change and then clicking on "Object Properties…".

To set an element ID:
* Select an element.
* Enter an ID
* Click "Set"

![A screenshot showing a selected element and the object properties panel in Inkscape.](ID.png)

### List of IDs
* Borders:
    * border.edge.north
    * border.edge.east
    * border.edge.south
    * border.edge.west
    * border.outsidecorner.nw
    * border.outsidecorner.ne
    * border.outsidecorner.se
    * border.outsidecorner.sw
* Numbers:
    * arabicOne
    * arabicTwo
    * arabicThree
    * arabicFour
    * arabicFive
    * arabicSix
    * arabicSeven
    * arabicEight
* Objects:
    * mine
    * flag
    * question
    * hint
    * error
* Cells:
    * cell_down
    * cell_up
    * explosion
* Background:
    * mainWidget


## Step two: Create a .desktop file
For your KMines theme to be detected and shown on the KMines settings, you will need to create a .desktop file containing information about your theme. It should contain the following fields:

```ini
[KGameTheme]
Author=
AuthorEmail=
Copyright=2023 Your Name
Description=
FileName=your-svg-theme-name.svgz
License=CC-BY-SA-4.0
Name=
Preview=theme-preview.png
Type=SVG
Version=1.0
```

After filling the required information, save the file in the `themes/` folder.


## Step three: Add your files to CMakelists
In `themes/CMakeLists.txt`, add your theme SVG and .desktop files.

## Step four: Create your preview image
Now you can build KMines and test your theme. When you're happy with it, create a 210 x 210px PNG preview image, and add this file to `themes/CMakeLists.txt`. Don't forget to update your theme's .desktop file with the new preview image.
