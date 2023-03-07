---
title: Styling your tutorial
description: Now that you know what tools to use, learn when to use them.
weight: 2
authors:
 - SPDX-FileCopyrightText: 2023 Thiago Masato Costa Sueto <thiago.sueto@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
group: contribute
---

## The reader is everything {#reader}

The purpose of documentation is to be read by users. Ultimately, the goal is for the documentation to be useful to the reader.

To achieve this, no matter your level of expertise on the topic, you should read the tutorial you're working on as if you were the target reader. While doing so, you should ask yourself the following questions:

* Can the user finish the tutorial with just the provided steps?
* Is the explanation accurate?
* What does the user need to know to understand this tutorial?
* Does this tutorial make the tech attractive to the user?
* Is there any term that needs clarification?
* Is the text well formatted?
* Can the reader find what they need without a search field?
* Are things being said more than once?
* Can the users learn more by themselves?

These are not rules, just a compilation of matters found in technical documentation books. These should be addressed to the best of your abilities, *where they apply*.

Simply by keeping these questions in mind while writing your tutorial, your content will naturally lean towards high quality documentation.

## Use tree {#tree}

The `tree --dirs-first` command is great to show the project structure to the reader.

## Use monospaced text for files, directories, code references, and short code snippets {#monospace}

Use backticks before and after things like: `~/.config/examplerc`, `~/kde/usr/`, `setContext()`, `cmake -B build -DCMAKE_INSTALL_PREFIX=$HOME/kde/usr`.

If your code snippet has more than one line, use a code block instead.

## Use () to signal functions {#functions}

This applies to both links and monospaced text. `setContext()` or [KXmlGuiWIndow::setupGUI()](#).

Don't use parameters inside the (). The only exception is when you need to differentiate between function overloads.

## Use descriptive anchors {#anchors}

You generally don't really need to define anchors yourself since Hugo does this for you, but sometimes this can simplify your workflow.

Anchors can be useful to multiple people: the reader, the current writer, the future writer, and the future tester.

Make your anchors descriptive so linking to sections can be checked more easily. For instance:

```markdown
You can read more about anchors in {{</* ref "markdown#step5" */>}}.
```

This will be useful to the reader and to you, but it will be less legible for the future writer and less checkable by the future tester. Prefer the following instead:

```markdown
You can read more about anchors in {{</* ref "markdown#howtoanchors" */>}}.
```

## Don't use monospaced text in links {#linksmonospaced}

Monospaced links like [`monospacedLink`](#), when paired with plain [hyperlinks](#) or plain `monospaced text`, can look too busy when the Hugo Markdown is rendered on the website. It's best to simply use plain links for links and plain monospaced text for monospaced text.

## Cross-reference most things {#links}

This binds with the question of "Can the reader find what they need without a search field?". The tutorial should be entirely navigable by hyperlinks and it should provide easy links to the related resources used.

If you need to link to a class/type and to a property/function/variable belonging to that class/type, link both.

The clearest exception is anchors: you should only link to anchors that are distant from the text that references them, such as two or three sections apart in the same text, or sections in a different page or tutorial.

## Cross-referencing QML API the first time {#qmllinks}

If you are linking to QML API for the first time, mention its namespace. If you are talking about a QtQuick Controls Button, call it "Controls.Button" the first time, then you can start using "Controls Button" or simply "Button" without links.

## Avoid cross-referencing more than once... {#linkonce}

You should never provide more than one hyperlink to the same content in the same paragraph. If there is more than one, 90% of the time the paragraph can either be rephrased or split.

This can be extended to multiple paragraphs if the name of the linked thing allows it:

```markdown
A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action. We can use these to provide our applications with easy-to-reach actions that are essential to their functionality. [Kirigami.Actions](docs:kirigami2;Action) inherit from [QtQuick Controls Action](docs:qtquickcontrols;QtQuick.Controls.Action) and
can be assigned shortcuts. One feature offered by [Kirigami.Actions](docs:kirigami2;Action) on top of [QtQuick Actions](docs:qtquickcontrols;QtQuick.Controls.Action) is the possibility to nest actions.
```

Turns into:

```markdown
A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action. We can use these to provide our applications with easy-to-reach actions that are essential to their functionality.

Kirigami Actions inherit from [QtQuick Controls Action](docs:qtquickcontrols;QtQuick.Controls.Action) and
can be assigned shortcuts.

One feature offered by Kirigami Actions on top of QtQuick Actions is the possibility to nest actions.
```

## ...but do cross-reference again where convenient {#linkconvenient}

If the text transitions to a new section, the latest reference to that link was long ago, or linking to the API would suddenly be convenient for the reader, do link again.

## Provide a full example {#fullexample}

If the reader has no reference of what the code is supposed to look like, they likely won't know if they are following the tutorial correctly.

If your tutorial consists of creating a small project, provide the full example where needed so the user has a reference to compare the work they've done following through the tutorial.

## Do not abuse alerts {#alerts}

The `{{</* alert */>}}` shortcode is great for talking about optional content without interrupting the reading of the main tutorial. But that's precisely it: if the number of alerts is high enough to interrupt the reading of the main tutorial, then there are too many.

Moreover, if you can see no practical difference between the text being inside and outside of an alert, then chances are it is required as part of the tutorial and you should not use an alert at all.

## Use collapsible boxes only with optional long lists {#collapsible}

Collapsible boxes like the following:

```markdown
<details>
  <summary>Click here to open this collapsible box</summary>
  Contents of the collapsible box
</details>
```

Can be used for optional content that really should not be taking space from the page and from the main content, which might be the case for really long lists. Use this rarely.

## Follow standard documentation practices where it makes sense

Here are a few free resources to learn about technical documentation:

* [Google Developer Documentation Style Guide: Highlights](https://developers.google.com/style/highlights)

* [Red Hat Supplementary Style Guide](https://redhat-documentation.github.io/supplementary-style-guide/)

* [Microsoft Style Guide: Top 10 Tips](https://learn.microsoft.com/en-us/style-guide/top-10-tips-style-voice)









