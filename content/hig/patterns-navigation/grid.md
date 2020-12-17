---
title: Grid
weight: 4
available:
  - desktop
  - mobile
---


Pattern for a flat content structure.

![Grid of items](/hig/Grid.png)

When to Use
-----------

Use a grid to show a set of elements which can best be represented
graphically (as images with or without text), such as a gallery of
pictures or video thumbnails, or the content of a store.

For elements that are better represented by text, use a
[list](/components/editing/list).

How to Use
----------

-   Make sure that the grid items are big enough and/or there is enough
    padding between them for users to easily tap items
-   Accompany images with a textual label if there is a chance that
    certain elements may be easier to recognize by their text than their
    graphical representation
-   If a grid is populated from an online source, use the "Pull to
    refresh" feature that allows users to update it simply by pulling
    it down beyond the first (i.e. newest) grid item

Implementation
--------------

-   Use a GridView within a Page or ScrollablePage (if the grid can
    contain more elements than fit on the screen) to implement this
    pattern
-   Set supportsRefreshing: true on the ScrollablePage to allow "Pull
    to refresh"
