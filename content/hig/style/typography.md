---
title: Typography
weight: 7
---

The guideline helps ensure that typography is always in harmony with the
overall visual design. These guidelines apply to application and
widgets, but not to documents. It is fine to use a wider range of
different font sizes and formatings in documents.

Typeface Styles
---------------

KDE's default font is *Hack* for monospace and *Noto Sans* for
everything else. The default font size is 10pt. KDE Plasma and
Applications display seven variants of this typeface.

![The seven default typeface styles](/hig/Typography1.png)

Typeface settings can be adjusted by the user and have
great influence on sizing and spacing [Units and Measurements]({{< relref "units" >}})
in KDE's workspace and applications.

### Summary

-   The monospace typeface should be used for code content, filenames,
    file paths.
-   Typography is treated like any other visual element when considering
    [spacing]({{< relref "metrics" >}}) and [alignment]({{< relref "alignment" >}}).
-   Multi-line blocks of text should be either left or right aligned;
    avoid center alignment.
-   Limit the range of any dynamic type resizing to preserve the
    intended visual hierarchy. For example, don't resize body text to
    be bigger than the heading text. Or don't resize the section
    heading text to fit more words so that it is smaller than the body
    text. Or don't resize text of relatively lesser importance so that
    it is bigger than text or other visual elements that should be of
    relatively greater importance.

{{< alert color="warning" title="Warning" >}}
Never use `Text { }` in Kirigami or Plasma, because it does not follow
the system font settings. See [Typography](#code) for implementation.
{{< /alert >}}


{{< alert color="warning" title="Warning" >}}

Never use a hardcoded value of px or pt to define a font size. See the
entry about [units]({{< relref "units" >}}) for more information.
{{< /alert >}}

{{< alert color="info" title="Hint" >}}
The px values are only for design and mockup; don't use them for
development.

-   Header 1: Noto Sans 18px
-   Header 2: Noto Sans 13px
-   Header 3: Noto Sans 12px
-   Header 4: Noto Sans 11px
-   Body: Noto Sans 10px
-   Code: Hack 10px
-   Small: Noto Sans 8px
{{< /alert >}}

Guidelines
----------

### Components

Most [components]({{< relref "components" >}}) have
a recommended typeface style. If you create a new component you should
give it the same typeface style as similar existing components.

### Content

You can use any typeface styles to structure your content, but try not
to overuse the larger headings.

When the visual design calls for an area of exceptional focus, a larger
typeface size may be used. In this case use a Light typeface weight to
keep the stroke width similar to other styles throughout the interface.
All other typeface characteristics for the typographic category should
be maintained. For such exceptions to be effective, they must be very
rare.

{{< compare >}}
{{< dont src="/hig/Typography-Heading-Dont.png" >}}
 Don't use the same type scale for everything in your applications.
{{< /dont >}}
{{< do src="/hig/Typography-Heading-Do.png" >}}
Vary the type scale appropriately in your application.
{{< /do >}}
{{< /compare >}}

### Text Color and Contrast

The [text color and background color]({{< relref "color/" >}}) can be
varied to provide additional hierarchical hints (e.g. selected text).
However, the contrast between the text and background color must be
sufficient to preserve legibility of the text.

### Words per Line

Unless the content is long-form text like a book or a report, try to
keep line lengths to no more than about eight to ten words per line. For
styles requiring the use of an all-caps typeface, try to keep line
lengths to no more than about three to four words per line.

Code
----

### Kirigami

{{< readfile highlight="qml" file="/content/hig/examples/kirigami/Typography.qml" >}}

### Plasma

{{< readfile highlight="qml" file="/content/hig/examples/plasma/Typography.qml" >}}
