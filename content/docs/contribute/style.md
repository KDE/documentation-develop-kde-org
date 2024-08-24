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

## Provide a migration plan {#migration}

An extension of the "The reader is everything" guideline is that you should care not only about the people reading the new version of your tutorial, but also the people that have read the previous version. This is analogous to software development.

When writing a software library, the developer needs to mark no longer desirable functions or classes as deprecated so that the library users have a reasonable length of time to get acquainted with the change and switch to the new functions and classes. This is a migration plan.

You should provide a migration plan to the reader of your documentation whenever drastic changes are done to a tutorial. This amounts to four things:

1. Make the change obvious

The change needs to be made obvious so that the reader of the previous version of the tutorial does not get confused when they seek information about the old tool. You should assume that once your reader has already read it once, the next time they will *scan it* for what they seek and they might miss non-obvious changes.

You can do so by changing a page's title, editing the entrypoint section for that topic, adding [alerts]({{< ref "formatting.md#alert" >}}), or a combination of all of these.

It is not uncommon for a reader to follow a significant part of a tutorial only to find that it doesn't work the way they were expecting.

Similarly, if the tutorial has been changed to point to a different tool/tech or if the new tool/tech has more functionality, tell the user that the new instructions will not work with the old tool/tech.

This also has the side effect of better promoting the new tool, as its name will be mentioned more often and meaningfully.

2. Repeat the change with [alerts]({{< ref "formatting.md#alert" >}})

Unlike with code, repeating yourself (to a reasonable extent) is useful for documentation.

In this case, it serves as a fallback to ensure the reader will not encounter the frustrations described in point 1.

3. Avoid partial changes

Partial changes break documentation and result in mixed instructions that confuse readers.

When updating a tutorial, make sure to check that you have no (unintentional) lingering bits of old instructions that might catch the reader by surprise. More often than not, updating a tutorial requires more thought than a simple Find and Replace.

If a partial change needs to be done (for example, so changes are done atomically in multiple merge requests), the interval between that and the remaining changes must be short and planned.

4. Optionally, mention the old method

A change from an old tool/tech to a new one can result in different ways to achieve the same task. Depending on the importance of the change, you may use an [alert]({{< ref "formatting.md#alert" >}}), need to edit a section, or write a whole page with a detailed migration plan.

For example, a slightly different command might need an alert or it may be bundled together with the new method in a separate section, but a major breaking change in a library API will likely need a separate page.

Lastly, there are a few exceptions to this guideline and an immediate update with no migration plan can be done:

* If the change is not drastic enough to warrant a migration plan
* If a feature referred to in the tutorial is broken/does not exist anymore
* If the old method is outright broken or unsupported

## Mood and pronouns {#pronouns}

We use the first person plural (we) for general explanations in tutorials, imperative for reference instructions, and the second person singular (you/[generic you](https://en.wikipedia.org/wiki/Generic_you)) for special cases.

The use of "we" is known to lower the distance between writer and reader, feeling more welcoming, while the use of imperative is standard in reference documentation and technical texts whose point is to give instructions, and the use of "you" allows to address the reader directly.

* In this section **we'll** be focusing on layouts.
* **Compile** the application again. **You** can then run the application with:

The use of "we" is especially useful to bring a sense of unity with the KDE community or accomplishment in following the tutorial. For instance:

* In the previous tutorial, **we** have managed to create the interface of **our** application.
* **Let's** take a look at this file again:
* In this section, **we** will expose a C++ property to QML.

The pronoun "we" can also be used for the opposite purpose, to distance the writer from the reader. The beginning of this guideline is an example of that:

* **We** use the first person plural for […] and the second person singular for […].
* **We** recommend you to check the Kirigami Gallery, **our** showcase application for Kirigami controls.

When providing reference instructions, the imperative is preferred and oftentimes shorter and clearer. Typical imperative phrases that work well are:

* To achieve X, **do** Y.
* **Type** the following command:
* If X, then **do** Y.
* **Prefer** using X instead.
* A new dialog will appear. **Click** on X and **write**:

The use of "you" is useful to talk about the user's experiences, hypotheticals, instructions, and for avoiding passive voice. For instance:

* If **you** have ever used Plasma System Settings, **you** will have come across a ListView.
* **Your** installation path may differ depending on the platform.
* **You** will also need to change the following in **your** CMakeLists.txt:
* A dialog can be added using this API. → **You** can add a dialog using this API.

However, note that in many cases where "you" is used you may shorten the text with the imperative:

* **You** can then run the application with: → **Run** the application with:

All of the other style guidelines use imperative or "you" as they are meant to provide simple, direct, prescriptive instructions with the same tone as general rules.

Lastly, never use "I", "he" or "she".

## Use tree to show the project structure {#tree}

The `tree` command is great to show the project structure to the reader.

To select how many levels in a directory tree you want to expose, you can use the `-L` flag. To achieve three levels, for example:

`tree -L 3`

To showcase the project structure inside a code block, use the `tree` highlight indicator after the three backticks <code>```</code>:

````
```tree
app-tutorial/
├── CMakeLists.txt
├── org.kde.tutorial.desktop
└── src/
    ├── CMakeLists.txt
    ├── main.cpp
    └── Main.qml
```
````

The general preference for `tree` project structures is:

* project folder at the top, not `.` as in the default output of `tree`
* directories last
* CMakeLists.txt first among the list of files in a directory

## Use sentence case for titles {#titles}

Prefer sentence case where possible:

* Contribute to the documentation

Use Title Case only for project names, compound nouns that are known to be in Title Case, or words that come from acronyms:

* Plasma Mobile
* Hello World!
* Personal Information Management

## Use monospaced text for files, directories, code references, and short code snippets {#monospace}

Use backticks before and after things like:

* `~/.config/examplerc`
* `~/kde/usr/`
* `setContext()`
* `cmake -B build -DCMAKE_INSTALL_PREFIX=$HOME/kde/usr`

If your code snippet has more than one line, use a code block instead.

If you code snippet has only one line, but it needs to be emphasized as a separate step, use a code block instead.

## Use () to signal functions {#functions}

This applies to both links and monospaced text: `setContext()` or [KXmlGuiWIndow::setupGUI()](#).

Don't use parameters inside the (). The only exception is when you need to differentiate between function overloads or when the parameter itself should be the focus. For example:

* QString()
* QString(const char *str)
* QString(const QByteArray &ba)

## Use / to signal directories {#directories}

It is not always clear whenever a file name is pointing to a directory or a plain file, especially on Linux, where file extensions are not mandatory.

To avoid ambiguity, refer to directories by ending them with a slash:

* Avoid: `content/docs/tutorial`
* Do: `content/docs/tutorial/`

## Use two or three levels for section titles in Markdown {#section-levels}

Try to section the tutorial content within three heading levels.

Section titles (which start with a select number of `#` characters) should preferably use heading level two (`##`) or three (`###`).

This is for three reasons:

* The first level (`#`) is already in use for the page title.
* The KDE Developer website currently has a limitation for showing sidebar content. Using four levels (`####`) or more will now show up on the right sidebar.
* This forces the tutorial writer to not go overboard with content levels.

Use heading level four (`####`) only if strictly necessary. Never use five (`#####`) or more.

## Use descriptive links {#descriptive-links}

Descriptive links are a [part of the Web Content Accessibility Guidelines (WCAG)](https://www.w3.org/TR/WCAG20/#navigation-mechanisms).
They provide several benefits:

* They are more readable by screen readers, used by blind or vision-impaired users
* They are easier to identify and discern among several links
* They provide better click targets

Don't:

* We recommend the Google Technical Writing course: https://developers.google.com/tech-writing/overview
* Using kdesrc-build with a custom built Qt is an advanced topic. See the [wiki](#).
* You need to know about QML property bindings to be able to follow this tutorial. You can read more about it in [this article](#).

Do:

* We recommend the [Google Technical Writing course](https://developers.google.com/tech-writing/overview).
* Using kdesrc-build with a custom built Qt is an advanced topic. See [Using kdesrc-build with a custom Qt installation](#).
* You need to know about [QML property bindings](#) to be able to follow this tutorial.

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

* Avoid: [`monospacedLink`](#)

* Do: [hyperlink](#)

* Do: `monospaced text`


## Use arrows to indicate menu structures or GUI steps {#arrows}

To indicate any menu actions (such as those in an application's menubar, context menu, or hamburger menu) or a certain number of steps to accomplish an action in the application's graphical interface, use arrows:

* File → Export → Export as PDF…
* Select any text → Copy its contents with Ctrl+C → Open Dolphin → Navigate to this folder → Paste with Ctrl+V

## Prefer Unicode symbols over handmade approximations {#symbols}

Use the following:

* … (U+2026) instead of ...
* → (U+2192) instead of ->
* “ (U+201C) and ” (U+201D) instead of " for quotations
* ’ (U+2019) instead of ' for apostrophes
* — (U+2014) instead of -, -, or -- for [interjections](https://www.merriam-webster.com/grammar/em-dash-en-dash-how-to-use)

While this will not count as a blocker for a merge request contribution to the KDE Developer website, following this guideline will result in more professional text that is more comprehensible for a screen reader.

This guideline is based on, but does not strictly follow, the [KDE Human Interface Guidelines]({{< ref "hig/text_and_labels#symbols" >}}).

## Avoid abbreviations (e.g., i.e., &, tech terms) {#abbreviations}

Common Latin-based abbreviations might be tempting to use in documentation due to how short they are, but avoiding them makes the text sound more natural in English and removes any potential language barrier for the reader. They also tend to become overused.

Use:

* "for example" / "for instance" instead of e.g.
* "that is / in other words" instead of i.e.

The abbreviation for et cetera (etc.) can be used.

While not technically an abbreviation, the symbol & used as an abbreviated replacement for "and" should also be avoided.

Most technology terms that are used as abbreviations have simpler English counterparts that should be used instead:

* PC → Computer
* OS → Operating system

However, terms that are more well known by their abbreviations than their spelled-out counterpart should be written as is. For example:

* USB is more well known than Universal Serial Bus
* URL is more well known than Uniform Resource Locator
* HTML is more well known than HyperText Markup Language

This guideline is based on the [KDE Human Interface Guidelines]({{< ref "hig/text_and_labels#acronyms" >}}).

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

## Avoid cross-referencing more than once… {#linkonce}

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

## …but do cross-reference again where convenient {#linkconvenient}

If the text transitions to a new section, the latest reference to that link was long ago, or linking to the API would suddenly be convenient for the reader, do link again.

```markdown
A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action.
We can use these to provide our applications with easy-to-reach actions that are
essential to their functionality.

…
…
…

## Kirigami Pages

…

You can attach a [Kirigami.Action](docs:kirigami2;Action) to the `actions:` of a [Kirigami.Page](docs:kirigami2;Page).

…
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

Note that [alerts can also be made collapsible]({{< ref "docs/contribute/formatting#alert" >}}).

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
