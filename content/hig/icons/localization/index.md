---
title: Icon Localization
weight: 3
---

KDE apps support right-to-left languages such as Arabic and Hebrew.
Icons should be localized as needed in order to preserve meaning across locales.

## Icons Representing Forward Motion

{{< compare >}}

{{< img class="centered-figure figure-half" src="ltr-time-progression.png" caption="In LTR, time progresses left to right. The forward button is on the right." >}}
{{< img class="centered-figure figure-half" src="rtl-time-progression.png" caption="In RTL, time progresses right to left. The forward button is on the left." >}}

{{</ compare >}}

Navigational icons are the most important icons in your interface when localizing, as they communicate the basic structure of your user interface.
If an arrow is pointing in the same direction that people read, people usually interpret it as "fowards." If it points the opposite direction, people usually interpret it as "backwards."

{{< compare >}}

{{< img class="centered-figure figure-half" src="ltr-forwards-icons.png" caption="In LTR, forwards motion goes from left to right." >}}
{{< img class="centered-figure figure-half" src="rtl-forwards-icons.png" caption="In RTL, forwards motion goes from right to left." >}}

{{</ compare >}}

This sense of directionality also extends to icons depicting motion.
For example, in LTR, sound waves come from the left and move forwards to the right.
To localize a sound wave icon to RTL, depict sound waves coming from the right and moving forwards to the left.

<aside>

### Skeumorphism

{{< img src="media-playback.png" caption="Media playback icons do not change between LTR and RTL." >}}

Icons depicting real-world objects that do not change across cultures should not be mirrored, even if they normally would.

The most notable example of this are media playback icons, which depict the icons found on buttons of real-world objects that are not mirrored in RTL-writing countries.

Media playback icons (and progress bars) should be represented in the same direction in LTR and RTL.

</aside>

<aside>

### Icon Handedness

{{< compare >}}
{{< do src="handed-icons-do.png" >}}
Keep icons depicting right-handedness in their original direction.
{{< /do >}}
{{< dont src="handed-icons-do-not.png" >}}
Do not mirror right-handed icons in RTL.
{{< /dont >}}
{{< /compare >}}

Just as the majority of people in LTR-writing countries are right-handed, the majority of people in RTL-writing countries are also right-handed.
Icons depicting objects such as magnifying glasses and coffee mugs have their handles on the right due to the majority of people holding them with their right hands, not due to a sense of forwards motion.

Leave icons depicting handedness unmirrored when localizing them.

</aside>

<aside>

### Circular Time

{{< img src="circular-time.png" caption="Time goes forwards clockwise and backwards counterclockwise in both LTR and RTL." >}}

Even though people understand the linear direction of time differently between LTR and RTL, people understand the circular progression of time the same in both LTR and RTL.
Clocks always turn clockwise to represent the forward progression of time.

</aside>

## Icons Representing Writing

{{< compare >}}

{{< img class="centered-figure figure-half" src="writing-ltr.png" caption="Left-to-right variants of icons that indicate writing." >}}
{{< img class="centered-figure figure-half" src="writing-rtl.png" caption="Right-to-left variants of icons that indicate writing." >}}

{{</ compare >}}

In right-to-left languages, the start of the page is at the right, not the left.
People typically hold books with the spine at the right of the page, not the left of the page.
Depictions of text and writing in localized icons should reflect this, starting and being aligned at the right instead of the left.

{{< img class="centered-figure" src="latin-icons.png" caption="Latin writing icons." >}}
{{< img class="centered-figure" src="arabic-icons.png" caption="Arabic writing icons." >}}
{{< img class="centered-figure" src="hebrew-icons.png" caption="Hebrew writing icons." >}}

Sometimes icons may include letters or letter-like forms to communicate a script-related concept, such as spell checking, alphabetical sorting, or a document.
Consider localizing these icons into their respective writing systems.

If your icon represents a concept unrelated to writing, consider designing one that doesn't use text.

## Composite Icons

{{< compare >}}

{{< img class="centered-figure figure-half" src="composite-ltr.png" caption="LTR icons with tools or slashes overlaid." >}}
{{< img class="centered-figure figure-half" src="composite-rtl-do.png" caption="RTL icons with tools or slashes overlaid." >}}

{{</ compare >}}

If your icon has a component overlaid on the main object such as a slash to indicate a disabled state, a tool overlaid on top of the object, or an emblem indicating an action, attempt to mirror the main object and leave the overlay in the same orientation.

{{< compare >}}
{{< do src="composite-rtl-do.png" >}}
Preserve the orientation of overlays while redrawing the base object to be RTL.
{{< /do >}}
{{< dont src="composite-rtl-do-not.png" >}}
Avoid mirroring both the entire icon and its overlays.
{{< /dont >}}
{{< /compare >}}

These overlays may be applied to icons which do not get mirrored in RTL.
It is important to keep overlays in the same position between mirrored and non-mirrored icons for visual consistency.
