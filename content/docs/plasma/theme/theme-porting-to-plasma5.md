---
title: Porting theme to Plasma 5
weight: 3
description: A overview of all the changes needed for old themes to properly work on latest Plasma 5.
---

While the basic format of Plasma themes has not changed since the first version of Plasma, by the time in Plasma 5 some backward-incompatible changes happened for the range of elements expected in the themes. Here is a list of the changes, please supplement if changes are missing.

This is a living document, please add anything you encounter that is not yet listed here.

## KRunner

**dialogs/krunner** is no longer used by KRunner, instead **dialogs/background** is applied.

Changes to do:

* remove **dialogs/krunner** SVGs

##  Logout/Shutdown dialog

**dialogs/shutdowndialog** is no longer used. Instead the the implementation of "logoutmainscript" of the active Plasma LookAndFeel package defines the look of that dialog, with the default Breeze implementation not using any special theme elements.

Changes to do:
* remove **dialogs/shutdowndialog** SVGs

##  Panel background

The "*-mini-*" variants from the **widgets/panel-background** SVGs are no longer applied, instead always the normal "[prefix-]*" elements are used.

Changes to do:
* remove all "*-mini-*" variants
* ensure all the "[prefix-]*" elements include the potential borders (e.g. the "north-*" ones have the "*left*", "*bottom*" & "*right*" ones)
(often simply renaming the "*-mini-*" variants to their non-mini counterparts and removing the old ones before is all to do)

##  Analog clock

The rotation center of a hand (shadow) element now defaults to its "(width/2,width/2)" point from the top-left of the element, no longer is the the y-axis position of the elements with respect to the center of ClockFace taken into account. Since Plasma 5.16 the hints "hint-[hand(shadow)]-rotation-center-offset" (with "[hand(shadow)]" being "hourhand", "hourhandshadow", "minutehand", "minutehandshadow", "secondhand", "secondhandshadow") allow to define a custom relative point (can also be outside the element).

Also has the hard-coded relative offset of the optional shadow elements for the hands been changed a few times. Since Plasma 5.16 it defaults to (0,0) and can be overwritten by the "hint-hands-shadow-offset-to-west/hint-hands-shadows-offset-to-east" and "hint-hands-shadow-offset-to-north/hint-hands-shadow-offset-to-south" hints.

With the change to QtQuick the rendering of the hands also is subject to OpenGL-based rendering usually. Which also means that for rotated rendering of images (like done for the hands) there is no anti-aliasing for the borders of the images, resulting in a jagged outline of the hands in most angles.  As one workaround at least still with Qt 5.12/Plasma 5.16 one can add some transparent pixels as outline of the hand elements. The amount of padding needed depends on the size of the hand, as the padding will be scaled as well, so needs some try & error to find what is enough.

Changes to do:

* if the default "(width/2,width/2)" relative rotation center point of a hand does not match: either add transparent padding area to the hand as needed or, recommended for Plasma >= 5.16, define a "hint-[hand(shadow)]-rotation-center-offset" element, e.g. by adding a circle whose center marks the relative rotation center
* if there are shadows elements and the default (0,0) offset does not match the theme's light model: define ""hint-hands-shadow-offset-to-*" elements for the shadow offset
* add some transparent rectangle for padding around the visual hands to the hand element if there is no transparent padding yet

##  Notes

The notes applet no longer uses the complete **widgets/notes** SVG file as shape for a note. Instead it expects 10 elements in the **widgets/notes** SVG, one note shape element with name "[color]-notes" per each supported color: "white", "black", "red", "orange", "yellow", "green", "blue", "pink", "translucent", "translucent-light".

Changes to do:

* name the existing shape with a name for a matching color
* add 9 more variants for all the missing colors

