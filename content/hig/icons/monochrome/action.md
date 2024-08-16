---
title: Action Icons
weight: 2
aliases:
- /hig/style/icons/monochrome/action
---

Action icons are used to depict actions. They come in two sizes: 16px
and 22px, and always use the [monochrome style]({{< relref "monochrome" >}}).

Purpose
-------

Action icons indicate actions that a user is able to take on on-screen
elements. They allow a user to intuit the behavior of controls.

Design
------

### Color

Action icons should use a base color of Shade Black. Additional colors
can indicate information about an action to a user.

{{< compare >}}
{{< do src="/hig/action-colour-do.png" >}}
Use Shade Black as your icon's base — this color is neutral and has the
most contrast against a white background.
{{< /do >}}
{{< dont src="/hig/action-colour-dont.png" >}}
Don’t use a bright color for your icon’s base — this distracts the user
without adding extra information to your icon.
{{< /dont >}}
{{< /compare >}}

{{< compare >}}
{{< do src="/hig/action-colour-destructive-do.png" >}}
Use red to indicate destructive actions.
{{< /do >}}
{{< dont src="/hig/action-colour-destructive-dont.png" >}}
Don't use red to indicate other types of actions — this will confuse the
user as to what the actions do.
{{< /dont >}}
{{< /compare >}}

![Action icons are able to dynamically change their color based on context.](/hig/action-colour-adaptable.png)

Implementation details can be found at [community.kde.org](https://community.kde.org/Guidelines_and_HOWTOs/Icon_Workflow_Tips#Embedding_stylesheets_in_SVGs).

### Metaphor

Appropriate and consistent metaphors should be used to inform a user
about the action an icon represents.

{{< compare >}}
{{< do src="/hig/action-metaphor-do.png" >}}
Use appropriate metaphors to indicate what an action does.
{{< /do >}}
{{< dont src="/hig/action-metaphor-dont.png" >}}
Don't use inaccurate or conflicting metaphors — this will mislead your
user and lead to frustration.
{{< /dont >}}
{{< /compare >}}

Accessibility
-------------

When using actions icons to indicate an action, a textual name and
description of the action should be provided for accessibility purposes.
Screen readers can take advantage of this information to allow more
people to use your application. Your local jurisdiction may also require
that your application meet accessibility standards. Care should also be
taken to reinforce information conveyed by an icon in multiple
ways — not everyone is able to distinguish between all colors.

{{< compare >}}
{{< do src="/hig/action-accessibility-do.png" >}}
Provide a name and description that describe what an icon's action
does.
{{< /do >}}
{{< dont src="/hig/action-accessibility-dont.png" >}}
Don't describe the icon's appearance — this is useless information that
will make your application harder to use.
{{< /dont >}}
{{< /compare >}}

{{< compare >}}
{{< do src="/hig/action-accessibility-color-do.png" >}}
Reinforce information in multiple ways to allow users with conditions
such as colorblindness to get the message.
{{< /do >}}
{{< dont src="/hig/action-accessibility-color-dont.png" >}}
Don't only rely on color to convey information — this makes it harder
for users with colorblindness to distinguish two like icons apart.
{{< /dont >}}
{{< /compare >}}
