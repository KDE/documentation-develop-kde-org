---
title: Breadcrumbs
---
===========

::: {.container .intend}
:::

![Breadcrumb patterns](/hig/NP-n-deep.png)

The *breadcrumbs* pattern is a navigation aid for hierarchical content
structures (e.g. home \> documents \> business). It provides information
about the current position within the hierarchy, and offers shortcut
links to jump to previous positions without using the Back button.

```{=html}
<video autoplay src="https://cdn.kde.org/hig/video/20181026-1/Breadcrumb1.webm" 
loop="true" playsinline="true" width="320" controls="true" 
onended="this.play()" class="border"></video>
```
*Use of breadcrumb navigation in Plasma Mobile.*

When to Use
-----------

-   Use a breadcrumb control for orientation and navigation in strictly
    hierarchical content. Apply other controls like tags for flat or
    less organized content.
-   Make sure a breadcrumb control has only supportive functions. Don\'t
    use it as primary and exclusive navigation pattern.
-   Don\'t use a breadcrumb control to just identify or label the
    position; it must be interactive.
-   Don\'t make the breadcrumb control dynamic by showing the user\'s
    past interactions (known as \'path breadcrumbs\'). Breadcrumbs
    should show the hierarchy, not the user\'s history.

How to Use
----------

-   Link all breadcrumb steps to the appropriate page or position. Show
    the current position at the very end of the breadcrumb control.
-   Keep breadcrumbs plain and textual; don\'t use icons or other
    controls.
-   Place a breadcrumb control above the content area, but below other
    navigation controls.
-   Don\'t integrate a breadcrumb control into a toolbar or titlebar.

Implementation
--------------

-   Consider providing a dropdown context menu full of alternative
    options for each breadcrumb item. But always offer one-click access
    by default.
-   Think of ways to make the breadcrumb control interactive in other
    creative ways. For example, it might permit content to be
    dragged-and-dropped onto a breadcrumb item to quickly move it there.
