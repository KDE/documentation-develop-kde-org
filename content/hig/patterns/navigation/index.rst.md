Navigation Patterns
===================

::: {.toctree maxdepth="1" titlesonly="" hidden=""}
single list expandable grid master combination tab unique combination-3
breadcrumb column
:::

Navigation Patterns depend on the structure of the application content.
Navigation patterns can be combined with
`command patterns </patterns/command/index>`{.interpreted-text
role="doc"} and content patterns to design the complete layout for your
application.

Patterns for Desktop User Interfaces
------------------------------------

### Patterns for a Flat Content Structure

![Flat structure](/img/IS-flat.png)

When pieces of application content are not grouped, the content
structure is flat.

Examples include a playlist, a slideshow or a list of documents or
contacts.

-   `Single item <single>`{.interpreted-text role="doc"}
-   `List <list>`{.interpreted-text role="doc"}
-   `Expandable list <expandable>`{.interpreted-text role="doc"}
-   `Grid <grid>`{.interpreted-text role="doc"}
-   `Master detail <master>`{.interpreted-text role="doc"}

### Patterns for a 2-Deep Content Structure

![Patterns for a 2-deep content structure](/img/IS-2-deep.png)

When all application content are grouped into top-level categories, the
content structure is 2-deep.

Examples include picture albums, music albums, email folders or tags.

-   `Combination patterns <combination>`{.interpreted-text role="doc"}
-   `Tabs <tab>`{.interpreted-text role="doc"}
-   `Unique 2-deep patterns <unique>`{.interpreted-text role="doc"}

### Patterns for a 3-Deep Content Structure

![Patterns for a 3-deep content structure](/img/IS-3-deep.png)

When all application content are grouped into categories, which are
themselves be grouped into top-level categories, the content structure
is 3-deep.

::: {.caution}
::: {.title}
Caution
:::

Content structures this deep should generally be avoided.
:::

There are instances, however, where it may be difficult to avoid.
Examples include a full music or video library or system settings.

-   `Combination patterns <combination-3>`{.interpreted-text role="doc"}

### Patterns for N-Deep Content Structures

![Patterns for n-deep content structures](/img/IS-n-deep.png)

When content is infinitely groupable, the content is n-deep.

::: {.caution}
::: {.title}
Caution
:::

Content structures this deep should be avoided. It is very difficult for
the user to maintain awareness of their location in content structure
relative to other content.
:::

There are instances, however, where this structure cannot be avoided.
Examples include file systems and archives.

-   `Breadcrumbs <breadcrumb>`{.interpreted-text role="doc"}
-   `Column-based navigation <column>`{.interpreted-text role="doc"}
