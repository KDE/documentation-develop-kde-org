---
title: Status Icons
aliases:
- /hig/style/icons/monochrome/status
---
============

Status icons are used to indicate the status of hardware and software.
They come in two sizes: 16px, 22px, and use the [monochrome
style](index.html).

Purpose
-------

Status icons allow a user to discern the current state of hardware and
software at a glance. They reassure users that software is functional,
and warn them when hardware is dysfunctional.

Design
------

### Anatomy

#### Base

The base of a status icon indicates to the user what item the state of
the icon represents.

{{< compare >}}
{{< do src="/hig/status-base-do.png" >}}
Use a simple and recognizable icon base that leaves room for additions to indicate
state.
{{< /do >}}
{{< dont src="/hig/status-base-dont.png" >}}
Don't use an overly simple
base---this makes it hard for the user to identify what an icon
represents. Additionally, don't use more details than you need to make
something recognizable--- this doesn't leave you room for indicating
states.
{{< /dont >}}
{{< /compare >}}

#### Overlay

The overlay of a status icon indicates to the user what status the item
the icon represents is in.

{{< compare >}}
{{< do src="/hig/status-overlay-do.png" >}}
Use a simple and recognizable
overlay with appropriately used color to clue in the user to an icon's
status.
{{< /do >}}
{{< dont src="/hig/status-caution.png" >}}
Some overlays can be hard to identify on their own---provide appropriate context to allow a
user to identify what a simple icon
represents.
{{< /dont >}}
{{< /compare >}}

{{< compare >}}
{{< do src="/hig/status-overlay-dont-color.png" >}}
Don't exclusively rely on
colour to indicate state---this is an accessibility problem and makes it
hard to discern state.
{{< /do >}}
{{< dont src="/hig/status-overlay-dont-detail.png" >}}
Don't use too-generic details to represent state---this makes it hard for a user to identify
what an icon's state represents.
{{< /dont >}}
{{< /compare >}}
