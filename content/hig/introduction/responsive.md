---
title: Responsiveness
weight: 4
---


Introduction
------------

Responsiveness means that the user interface adjusts to changes in
screen or window size. While Plasma and especially Kirigami are highly
responsive, this is not a replacement for
[optimized convegence](../convergence). It
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
<convergence>`{.interpreted-text role="doc"} by selecting different
`navigation <../patterns/navigation/index>`{.interpreted-text
role="doc"}, `command </patterns/command/index>`{.interpreted-text
role="doc"} and `content </patterns/content/index>`{.interpreted-text
role="doc"} patterns for different formfactors.

It is recommended to test your user interface against the most common
screen sizes of the targeted form factor.
