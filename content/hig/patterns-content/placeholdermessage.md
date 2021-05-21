---
title: Placeholder Message
weight: 7
---

When a content view is empty, the user may wonder whether the software is broken.
To alleviate this, add a placeholder message into the view telling the user that
there is no content, ideally providing either instructions for how to add content,
or even a UI control that will allow them to do so (if appropriate).

When to use
-----------

Show a Placeholder Message when a view that sometimes shows content or user
interface controls happens to be empty right now.

How to use
----------

![](/hig/PlaceholderMesageFirewall.png)

-   Visually center the message in the view so that it cannot be mistaken for
    content (which is typically top-aligned).
-   Use 50% opacity for the message so that it is not too attention-getting.
-   If there is already a UI control visible elsewhere in the same window/page
    that will allow the user to somehow populate the view, add an explanatory
    message below the main one pointing the user to it.
-   If there is no such UI control already visible, add one directly beneath the
    message's text.
-   If the view is typically used to display content but not add it directly,
    do not add any controls to allow the user to add content to the view.
-   If the view is searchable, distinguish between the different conditions of
    "no content here" vs. "no search results".

Code
----

### Kirigami

- [Kirigami: PlaceholderMessage](docs:kirigami2;PlaceholderMessage)

{{< readfile file="/content/hig/examples/kirigami/PlaceholderMessage.qml" highlight="qml" >}}
