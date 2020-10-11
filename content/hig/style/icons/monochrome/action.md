---
title: Action Icons
---
============

Action icons are used to depict actions. They come in two sizes: 16px
and 22px, and always use the [monochrome style](index.html).

Purpose
-------

Action icons indicate actions that a user is able to take on on-screen
elements. They allow a user to intuit the behavior of controls.

Design
------

### Color

Action icons should use a base color of Shade Black. Additional colors
can indicate information about an action to a user.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Use Shade Black as your
icon\'s base--- this color is neutral and has the most contrast against
a white background.](/hig/action-colour-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t use a bright color
for your icon\'s base---this distracts the user without adding extra
information to your icon.](/hig/action-colour-dont.png){.dont}
:::
:::

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Use red to indicate
destructive actions.](/hig/action-colour-destructive-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t use red to indicate
other types of actions--- this will confuse the user as to what the
actions do.](/hig/action-colour-destructive-dont.png){.dont}
:::
:::

![Action icons are able to dynamically change their color based on
context. Implementation details can be found at
[community.kde.org](https://community.kde.org/Guidelines_and_HOWTOs/Icon_Workflow_Tips#Embedding_stylesheets_in_SVGs).](/hig/action-colour-adaptable.png)

### Metaphor

Appropriate and consistent metaphors should be used to inform a user
about the action an icon represents.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Use appropriate metaphors to
indicate what an action does.](/hig/action-metaphor-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t use inaccurate or
conflicting metaphors--- this will mislead your user and lead to
frustration.](/hig/action-metaphor-dont.png){.dont}
:::
:::

Accessibility
-------------

When using actions icons to indicate an action, a textual name and
description of the action should be provided for accessibility purposes.
Screen readers can take advantage of this information to allow more
people to use your application. Your local jurisdiction may also require
that your application meet accessibility standards. Care should also be
taken to reinforce information conveyed by an icon in multiple
ways---not everyone is able to distinguish between all colors.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Provide a name and
description that describe what an icon\'s action
does.](/hig/action-accessibility-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t describe the icon\'s
appearance---this is useless information that will make your application
harder to use.](/hig/action-accessibility-dont.png){.dont}
:::
:::

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Reinforce information in
multiple ways to allow users with conditions such as colorblindness to
get the message.](/hig/action-accessibility-color-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t only rely on color
to convey information--- this makes it harder for users with
colorblindness to distinguish two like icons
apart.](/hig/action-accessibility-color-dont.png){.dont}
:::
:::
