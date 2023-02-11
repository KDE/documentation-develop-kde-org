---
title: KRunner Metadata Format
SPDX-FileCopyrightText: 2023 Alexander Lohnau <alexander.lohnau@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

# Abstract

Metadata is important in KRunner for user-visible properties like the name, description and default values for the category.
They can also affect the runtime behavior and allow for more features and optimizations.
Due to some properties being only relevant for DBus runners, the explanation is spit into separate sections.

## Universal Properties

This includes the user-visible keys like `Name`, `Icon`, `Description`, `EnabledByDefault`, `Email` and `Website` which are defined by [KPluginMetaData](docs:kcoreaddons;KPluginMetaData).

**De-Duplication**: KRunner is able to de-duplicate matches based on their ID. However, this behavior is not on by default to avoid unwanted side effects for plugins that do not define their IDs explifitely.
To tell KRunner that results from your plugin should be de-duplicated, the `X-Plasma-Runner-Unique-Results` property should be set to `true`.
The ID should look like a URL, for example `file:///home/user/foo` or `exec:///bin/konsole`.

When de-duplicating entries, KRunner must decide which of the matches should be displayed to the user and which ones should be removed.
To give KRunner a hint that your matches are less relevant than matches from other runners, you can set the `X-Plasma-Runner-Weak-Results` property to `true`.
This is also off by default.
An usecase would be if your plugin does a file search and sets the file URL as the match's ID.
If the user enters the full file path like `/home/user/foo` both your plugin and KDE's locations runner could produce a match for opening the same URL.
Using the `X-Plasma-Runner-Weak-Results` property, you allow the locations runner to take preference over yours, because this KDE plugin only provides exact matches.

## DBus Runner Properties

For DBus runners, the metadata is written in a desktop file. At runtime, KRunner parses this and converts it to a JSON representation to simplify the internals.

The most important key is `X-Plasma-API`. This can have the value `DBus` or `DBus2`.
With `DBus2` the `Config` method of the DBus interface will be called, which allows for runtime configuration.
In addition to that, `X-Plasma-DBusRunner-Service` must be defined.
This tells KRunner what DBus service name it should query.
In case there are multiple ones, the service can end with a `*` at the end, for example `org.kde.testrunner.*`.
Also, KRunner needs to know under which path in the service the runner is registered. This is defined using `X-Plasma-DBusRunner-Path`.

**Providing Usage Help**: Because for DBus runners can not directly use the [RunnerSyntax](docs:krunner;RunnerSyntax), it is possible to define syntaxes in the metadata.
To utilize this, you can define `X-Plasma-Runner-Syntaxes` and `X-Plasma-Runner-Syntax-Descriptions`, both of which are comma separated lists.
Those lists must be of the same size and each syntax description is mapped to the syntax of the corresponding list index.

**Reduce unneeded querying and DBus activation**: Normally, your runner would get queried for each letter typed and in case it is DBus activated, it would be activated when the first letter is typed.
Hoever, many runners have a prefix or pattern that must match.
A minimal length is common too, because some runners can not provide meaningful results for very short queries.
To allow DBus runners to utilize the existing KRunner API, `X-Plasma-Runner-Min-Letter-Count` and `X-Plasma-Runner-Match-Regex` can be defined.
These properties are equivalent to [minLetterCount](docs:krunner;AbstractRunner::minLetterCount) or [matchRegex](docs:krunner;AbstractRunner::matchRegex) and thus prevents unnecessary queries.  
Another useful property is `X-Plasma-Request-Actions-Once`, which causes KRunner to only query the actions once before the runner is queries.
This is prevents lots of unneeded DBus calls and object creations, if the actions stay the same during the lifetime of your runner.
