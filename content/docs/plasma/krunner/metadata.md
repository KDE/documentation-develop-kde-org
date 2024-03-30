---
title: KRunner metadata format
SPDX-FileCopyrightText: 2023 Alexander Lohnau <alexander.lohnau@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Universal Properties

These include user-visible keys like `Name`, `Icon`, and `Description`, which will be shown in several places, like the list of Runners available under System Settings > Search > Plasma Search.

`EnabledByDefault` should be set to `true`, otherwise the plugin must be enabled manually by ticking its checkbox.

`Authors`, `License`, `Email`, and `Website` are displayed in the config module's About dialog for the Runner.

You can find a more extensive list of keys/values in [KPluginMetaData](docs:kcoreaddons;KPluginMetaData).

**Deduplication**: KRunner is able to deduplicate matches based on their ID. However, this behavior is not enabled by default to avoid unwanted side effects for plugins that do not define their IDs explicitly.
The ID, which in the previous example was defined using setId(), should look like a URL, for example `file:///home/user/foo` or `exec:///bin/konsole`.

To tell KRunner that results from your plugin should be deduplicated, the `X-Plasma-Runner-Unique-Results` property should be set to `true`.

When deduplicating entries, KRunner must decide which of the matches should be displayed to the user and which ones should be removed.
To give KRunner a hint that your matches are less relevant than matches from other runners, you can set the `X-Plasma-Runner-Weak-Results` property to `true`.
A possible use case for `X-Plasma-Runner-Weak-Results` would be if your plugin does a file search and sets the file URL as the match's ID.
If the user enters a full file path like `/home/user/foo`, both your plugin and KDE's Locations runner could produce a match for opening the same URL.
By using this property, the Locations runner will take preference over yours. This is desirable, because the Locations runner only provides exact matches.

```json
{
    "KPlugin": {
        "Authors": [
            {
                "Email": "your.name@mail.com",
                "Name": "Your Name",
            }
        ],
        "Description": "Example Description",
        "EnabledByDefault": true,
        "Icon": "user-home",
        "License": "GPL",
        "Name": "My Runner",
        "Version": "0.1",
        "Website": "https://kde.org/plasma-desktop"
    },
    "X-Plasma-Runner-Unique-Results": true,
    "X-Plasma-Runner-Weak-Results": true
}
```

## DBus Runner Properties

For DBus runners, the metadata is written in a `.desktop` file. At runtime, KRunner parses this and converts it to a JSON representation to simplify the internals.

The most important key for DBus runners is `X-Plasma-API`, which is used to internally identify DBus runners and determine their supported API.
This can have the value `DBus` or `DBus2`. With `DBus2`, the `Config` method of the DBus interface will be called, which allows for runtime configuration.
When only `DBus` is set, all explained features of DBus runners will be supported, except the `Config`-method.
In addition to that, `X-Plasma-DBusRunner-Service` must be defined. This tells KRunner what DBus service name it should query.
In case there are multiple service names, the value for `X-Plasma-DBusRunner-Service` can end with a `*` at the end, for example `org.kde.testrunner.*`.
Also, KRunner needs to know under which path in the service the runner is registered. This is defined using `X-Plasma-DBusRunner-Path`.

**Providing Usage Help**: Since DBus runners can not directly use the [RunnerSyntax](docs:krunner;RunnerSyntax), it is possible to define a list of supported syntaxes in the metadata.
These syntaxes will be displayed by KDE's [Help Runner](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/runners/helprunner).
To utilize this, you can define `X-Plasma-Runner-Syntaxes` and `X-Plasma-Runner-Syntax-Descriptions`, both of which are comma separated lists.
Those lists must be of the same size and each syntax description is mapped to the syntax of the corresponding list index.
`:q:` serves as a placeholder that will get expanded to "search term" or the translation. The expanded text will be put in angle brackets.
This way you do not need to duplicate the "\<search term\>" string and also do not need to take care of translating it.
If you want a more precise description than "search term", you should put the text in angle brackets too.
For example `myrunner <files to search for>`.

**Syntax overview of the example file below**:
![Syntax Overview](/krunner/syntaxoverview.png)
**KRunner input field when the last syntax is selected**:
![Example query with placeholder inserted in KRunner](/krunner/placeholderselected.png)

**Reduce unneeded querying and DBus activation**: Normally, your runner would get queried for each typed letter, and in case it is DBus activated, it would be activated when the first letter is typed.
However, many runners have a prefix or pattern that must match.
A minimal length is common too, because some runners cannot provide meaningful results for very short queries.
To allow DBus runners to utilize the existing KRunner API, `X-Plasma-Runner-Min-Letter-Count` and `X-Plasma-Runner-Match-Regex` can be defined.
These properties are equivalent to [minLetterCount](docs:krunner;AbstractRunner::minLetterCount) or [matchRegex](docs:krunner;AbstractRunner::matchRegex) and thus prevent unnecessary queries.  
Another useful property is `X-Plasma-Request-Actions-Once`, which causes KRunner to only query the actions once before the runner is queried.
This is prevents lots of unneeded DBus calls and object creations, if the actions stay the same during the lifetime of your runner.


```ini
[Desktop Entry]
Name=My Runner
Description=Example Description
Type=Service
Icon=user-home
X-KDE-PluginInfo-Author=YourName
X-KDE-PluginInfo-Email=your.name@mail.com
X-KDE-PluginInfo-Name=myrunner
X-KDE-PluginInfo-Version=1.0
X-KDE-PluginInfo-License=LGPL
X-KDE-PluginInfo-EnabledByDefault=true

X-Plasma-API=DBus
X-Plasma-DBusRunner-Service=org.kde.myrunner
X-Plasma-DBusRunner-Path=/runner

X-Plasma-Request-Actions-Once=true
X-Plasma-Runner-Min-Letter-Count=3
# This means that the query must start with one or more lowercase letters
# To simplify debugging/creating the regex, you can use https://regex101.com/
X-Plasma-Runner-Match-Regex=^[a-z]+

X-Plasma-Runner-Syntaxes=:q:,myrunner :q:,otherprefix <more specific query>
X-Plasma-Runner-Syntax-Descriptions=Description for example query,Description for example query with prefix,Description for other prefix
```
