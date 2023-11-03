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
* Does this tutorial make the technology attractive to the user?
* Is there any term that needs clarification?
* Is the text well formatted?
* Can the reader find what they need without a search field?
* Are things being said more than once?
* Can the users learn more by themselves?

These are not rules, just a compilation of matters found in technical documentation books. These should be addressed to the best of your abilities, *where they apply*.

Simply by keeping these questions in mind while writing your tutorial, your content will naturally lean towards high quality documentation.

## Use tree to show the project structure {#tree}

The `tree` command is great to show the project structure to the reader.

To select how many levels in a directory tree you want to expose, you can use the `-L` flag. To achieve three levels, for example:

`tree -L 3`

## Use monospaced text for files, directories, code references, and short code snippets {#monospace}

Use backticks before and after things like:
* `~/.config/examplerc`
* `~/kde/usr/`
* `setContext()`
* `cmake -B build -DCMAKE_INSTALL_PREFIX=$HOME/kde/usr`.

If your code snippet has more than one line, use a code block instead.

## Use () to signal functions {#functions}

This applies to both links and monospaced text: `setContext()` or [KXmlGuiWIndow::setupGUI()](#).

Don't use parameters inside the (). The only exception is when you need to differentiate between function overloads. For example:

* QString()
* QString(const char *str)
* QString(const QByteArray &ba)

## Use / to signal directories {#directories}

It is not always clear whenever a file name is pointing to a directory or a plain file, especially on Linux, where file extensions are not mandatory.

To avoid ambiguity, refer to directories by ending them with a slash:

* Do: `content/docs/tutorial/`
* Don't: `content/docs/tutorial`

## Use descriptive anchors {#anchors}

You generally don't really need to define anchors yourself since Hugo does this for you, but sometimes section names can be too long, making links to them equally long.

Anchors can be useful to multiple people: the reader, the current writer, the future writer, and the future tester.

Make your anchors descriptive so linking to sections can be checked more easily. For instance:

```markdown
You can read more about anchors in {{</* ref "markdown#step5" */>}}.
```

This will be useful to the reader and to you, but it will be less legible for the future writer and less checkable by the future tester. Prefer something similar to the following instead:

```markdown
You can read more about anchors in {{</* ref "markdown#howtoanchors" */>}}.
```

## Don't use monospaced text in links {#linksmonospaced}

Monospaced links like [`monospacedLink`](#), when paired with plain [hyperlinks](#) or plain `monospaced text`, can look too busy when the Hugo Markdown is rendered on the website. It's best to simply use plain links for links and plain monospaced text for monospaced text.

Do: [hyperlink](#)

Do: `monospaced text`

Don't: [`monospacedLink`](#)

## Cross-reference most things {#links}

This binds with the question of "Can the reader find what they need without a search field?".

The tutorial should be entirely navigable by hyperlinks and it should provide easy links to the related resources used.

If you need to link to a class/type and to a property/function/variable belonging to that class/type, link both.

* Do: "You should learn [Kirigami](#). It provides convenient properties, such as [Kirigami.Units](#), human readable units for sizing elements in your QML application."

The clearest exception is anchors: you should prefer link to anchors that are distant from the text that references them, such as two or three sections apart in the same text, or sections in a different page or tutorial. Follow this at your discretion.

* Avoid: See the section [Cross-referencing QML API the first time](#qmllinks).
* Prefer: See the section "Cross-referencing QML API the first time" just below. You should take a look at the [standard documentation practices](#standard-documentation-practices) to learn more about technical writing.

## Cross-referencing QML API the first time {#qmllinks}

If you are linking to QML API for the first time, mention its namespace.

If you are talking about a QtQuick Controls Button, call it "QtQuick.Controls.Button" the first time.

If it's well understood that the text is talking about QtQuick, you can just say "Controls.Button" instead.

After that you can start using "Controls Button" or simply "Button" without links, but only if there is no ambiguity. For example, if you have a QtQuick.Controls.Button and a Kirigami.Button, saying "Button" will be ambiguous and the user won't know whether you are talking about Controls or Kirigami.

## Avoid cross-referencing more than once... {#linkonce}

You should avoid providing more than one hyperlink to the same content in the same paragraph. If there is more than one, 90% of the time the paragraph can either be rephrased or split.

This can be extended to multiple paragraphs if the name of the linked thing allows it:

```markdown
A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action.
We can use these to provide our applications with easy-to-reach actions that are essential to their functionality.
[Kirigami.Actions](docs:kirigami2;Action) inherit from [QtQuick Controls Action](docs:qtquickcontrols;QtQuick.Controls.Action) and
can be assigned shortcuts.
One feature offered by [Kirigami.Actions](docs:kirigami2;Action) on top of [QtQuick Actions](docs:qtquickcontrols;QtQuick.Controls.Action) is the possibility to nest actions.
```

Turns into:

```markdown
A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action.
We can use these to provide our applications with easy-to-reach actions that are
essential to their functionality.
Kirigami Actions inherit from [QtQuick Controls Action](docs:qtquickcontrols;QtQuick.Controls.Action) and
can be assigned shortcuts.
One feature offered by Kirigami Actions on top of QtQuick Actions is the possibility to nest actions.
```

## ...but do cross-reference again where convenient {#linkconvenient}

If the text transitions to a new section, the latest reference to that link was long ago, or linking to the API would suddenly be convenient for the reader, do link again.

```markdown
A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action.
We can use these to provide our applications with easy-to-reach actions that are
essential to their functionality.

...
...
...

## Kirigami Pages

...

You can attach a [Kirigami.Action](docs:kirigami2;Action) to the `actions:` of a [Kirigami.Page](docs:kirigami2;Page).

...
```

## Provide a full example {#fullexample}

If the reader has no reference of what the code is supposed to look like, they likely won't know if they are following the tutorial correctly.

If your tutorial consists of creating a small project, provide the full example where needed so the user has a reference to compare the work they've done following through the tutorial.

Use the [readfile]({{< ref "formatting.md#readfile" >}}) and [snippet]({{< ref "formatting.md#snippet" >}}) shortcodes as well as [code blocks]({{< ref "formatting.md#code-blocks" >}}) to achieve this.

## Do not abuse alerts {#alerts}

The [{{</* alert */>}}]({{< ref "formatting.md#alert" >}}) shortcode is great for talking about optional content without interrupting the reading of the main tutorial. But that's precisely it: if the number of alerts is high enough to interrupt the reading of the main tutorial, then there are too many.

Moreover, if you can see no practical difference between the text being inside and outside of an alert, then chances are it is required as part of the tutorial and you should not use an alert at all.

## Use collapsible boxes for long lists or content {#collapsible}

[Collapsible boxes](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-collapsed-sections) like the following:

```markdown
<details>
  <summary>Click here to open this collapsible box</summary>
  Contents of the collapsible box
</details>
```

Can be used for optional content that really should not be taking space from the page and from the main content, which might be the case for really long lists or [alerts]({{< ref "formatting.md#alert" >}}). Use this rarely.

## Follow standard documentation practices where it makes sense {#standard-documentation-practices}

Here are a few free resources to learn about technical documentation:

* [Google Developer Documentation Style Guide: Highlights](https://developers.google.com/style/highlights)

* [Red Hat Supplementary Style Guide](https://redhat-documentation.github.io/supplementary-style-guide/)

Here are a few highlights from the Google Technical Writing Guide that effectively summarize content seen in most technical writing books:

* [Define new or unfamiliar terms](https://developers.google.com/tech-writing/one/words#define_new_or_unfamiliar_terms)

* [Use terms consistently](https://developers.google.com/tech-writing/one/words#use_terms_consistently)

* [Recognize ambiguous pronouns](https://developers.google.com/tech-writing/one/words#recognize_ambiguous_pronouns)

* [Prefer active voice to passive voice](https://developers.google.com/tech-writing/one/active-voice#prefer_active_voice_to_passive_voice)

* [Choose strong verbs](https://developers.google.com/tech-writing/one/clear-sentences#choose_strong_verbs)

* [Convert some long sentences to lists](https://developers.google.com/tech-writing/one/short-sentences#convert_some_long_sentences_to_lists)

* [Distinguish that from which](https://developers.google.com/tech-writing/one/short-sentences#distinguish_that_from_which)

* [Answer what, why and how](https://developers.google.com/tech-writing/one/paragraphs#answer_what_why_and_how)

* [Think like your audience](https://developers.google.com/tech-writing/two/editing#think_like_your_audience)

* [Prefer task-based headings](https://developers.google.com/tech-writing/two/large-docs#prefer_task-based_headings)

* [Disclose information progressively](https://developers.google.com/tech-writing/two/large-docs#disclose_information_progressively)

[Write The Docs](https://www.writethedocs.org/) is a global community of technical writers, and they provide lots of content that you can use to improve your technical writing skills:

* [General list of learning resources](https://www.writethedocs.org/about/learning-resources/)
* [A huge guide on technical writing made by the WriteTheDocs community itself](https://www.writethedocs.org/guide/)
* [A list of books about technical writing](https://www.writethedocs.org/books/)
* [A YouTube channel containing numerous talks about technical writing](https://www.youtube.com/@writethedocs)

Here is a list of recommended Write The Docs talks that you should see:

* [Happy Contributors, High Standards pick two! Balancing quality and community](https://youtu.be/emgFALmCyrY)
* [Is it (layer) cake: Thinking in content levels](https://youtu.be/0OKRNQvZbL4)
* [The power of product screenshots in your documentation](https://youtu.be/eoJh5cu91pw)
* [The descriptivist manifesto](https://youtu.be/RbFxwuNJjWo)
* [Don't shoot yourself in the foot with content reuse](https://youtu.be/dxEhvjz3eEY)



