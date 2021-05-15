---
title: Responsiveness
weight: 4
---


Introduction
------------

Responsiveness means that the user interface adjusts to changes in
screen or window size. While Plasma and especially Kirigami are highly
responsive, this is not a replacement for
[optimized convergence](../convergence). It
is not supposed to be used as a replacement for different UI and UX for
different interaction methods (mouse, touch, pointer, remote, \...) or
different form factors like mobiles and televisions. Instead, it means
to adapt to different screen sizes in the same form factor class, like
different window sizes and screen resolutions in desktops and laptops.

<video src="https://cdn.kde.org/hig/video/20180620-1/CardLayout1.webm" 
loop="true" playsinline="true" width="536" controls="true" 
onended="this.play()" class="border"></video>

Examples of responsive behavior:

-   Components can display more or less content, depending on the
    available space.
-   Margins between elements can shrink and grow
-   Multi-column navigation layouts, grids and grid-like layouts can
    change the number of displayed columns
-   Images can resize

Although elements can resize vertically, horizontal or in both
directions, it is recommended that row-like elements such as menu bars
only shrink or grow horizontally.

<video src="https://cdn.kde.org/hig/video/20180620-1/Responsive1.webm" 
loop="true" playsinline="true" width="536" controls="true" 
onended="this.play()" class="border"></video>

Action bar shrinking only in the horizontal direction.

Keep in mind that not all controls or parts of a layout can and should
be responsive. Often it is more important to retain the size for
usability, familiarity and alignment and aim for `optimized convergence 
<convergence>` by selecting different
`navigation <../patterns/navigation/index>`{.interpreted-text
role="doc"}, `command </patterns/command/index>`{.interpreted-text
role="doc"} and `content </patterns/content/index>`{.interpreted-text
role="doc"} patterns for different formfactors.

It is recommended to test your user interface against the most common
screen sizes of the targeted form factor.

Folding points
--------------

An application's window size can change because of screen rotation on mobile 
devices, activating a split view feature, or manual resizing. It is recommended 
to react to the window these changes at specific widths, called "folding 
points".

Depending on the application, it might make sense to change the user interface 
on one or on multiple folding points.

| FP | Window size | Kirigami columns | Examples                                                        |
|----|-------------|------------------|-----------------------------------------------------------------|
| xs | <= 360 px   | 1                | A typical mobile phone, application in small split screen       |
| s  | <= 720 px   | 2                | A large mobile phone, TVs, Phablet, a mobile phone in landscape |
| m  | <= 1080 px  | 3                | Most tablets or laptops                                         |
| l  | <= 1440 px  | 4                | Nearly maximised windows on desktops                            |
| xl | > 1440 px   | 5                | Full screen windows on desktops                                 |


{{< alert color="warning" >}}
These are not physical pixels of a device or window, but DPI independent 
pixels, see [Units](/hig/layout/units) for more information.
{{< /alert >}}

