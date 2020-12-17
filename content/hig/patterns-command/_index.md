---
title: Command Patterns
weight: 5
---

Command patterns are determined by the command structure chosen for the
application. A command is any function performed by the application
based on user input. Commands that perform similar functions may be
grouped together. The collection of commands and command groups make up
the command structure of the application.

Command patterns can be combined with
[navigation patterns](/patterns/navigation/) and
[content patterns](/patterns/content/) to design the complete layout
for your application.

Guidelines
----------

When designing an application, it may be unclear what the command
structure should be.

-   Start by assuming a simple command structure and select an
    associated command pattern.
-   As the design evolves, if the selected pattern becomes inadequate
    for completing the primary tasks of the application, consider a
    pattern for a more complex command structure.

{{< alert color="info" title="Note" >}}

Considering the limited space available in mobile applications, there is
always a trade-off between accessibility of controls and space available
for the content.

{{< /alert >}}
