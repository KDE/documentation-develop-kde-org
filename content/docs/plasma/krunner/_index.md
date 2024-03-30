---
title: KRunner C++ plugin
SPDX-FileCopyrightText: 2022 Alexander Lohnau <alexander.lohnau@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

##  Abstract 


The Plasma workspace provides an application called KRunner which, among other things, allows one to type into a text area that causes various actions and information that match the text appear as the text is being typed.

This functionality is provided via plugins loaded at runtime called "Runners". These plugins can be used by any application using the KRunner library, like the default Application Launcher or the Plasma Mobile search applet. This tutorial explores how to create a runner plugin.

##  Basic Anatomy of a Runner 


[Plasma::AbstractRunner](docs:krunner;AbstractRunner)
is the base class of all Runners. It provides the basic structure for Runner plugins to:

* Perform one-time setup upon creation
* Perform setup and teardown before and after matching starts
* Create and register matches for a given search term
* Define secondary actions for a given match
* Take action on a given match registered by the runner
* Show configuration options

In addition to [Plasma::AbstractRunner](docs:krunner;AbstractRunner) there are three other important classes from the Plasma library that we will be using: 

* [Plasma::RunnerContext](docs:krunner;RunnerContext) which gives our plugin information about the current query
* [Plasma::QueryMatch](docs:krunner;QueryMatch) which represents a single match for a given query
* [Plasma::RunnerSyntax](docs:krunner;RunnerSyntax) which is used to advertise the query syntax understood by the plugin

Each of these classes will be covered in more detail as we encounter them in the Runner plugin implementation.

##  Creating a Runner Plugin Project 


In this tutorial we will be creating a Runner plugin that finds files in the user's home directory that match the query and offers to open them. We begin by setting up the basic project files including a `CMakeLists.txt` file for building and installing the plugin, a class definition in a header file, and a source code file containing the class implementation.

### The CMakeLists.txt File 


CMake makes it very easy to set up the build system for our plugin:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/CMakeLists.txt" highlight="cmake" lines=26 >}}

### The .json Metadata File


When KRunner queries the available plugins, it reads the embedded metadata. In order to provide this, we have to embed a JSON metadata file. In this case we call it `homefilesrunner.json`. This name is referenced in the `K_PLUGIN_CLASS_WITH_JSON` macro further below.

The contents of this file, as seen below, contain the name, description and technical details about the plugin.

```json
{
    "KPlugin": {
        "Authors": [
            {
                "Email": "your.name@mail.com",
                "Name": "Your Name"
            }
        ],
        "Description": "Part of a tutorial demonstrating how to create Runner plugins",
        "EnabledByDefault": true,
        "Icon": "user-home",
        "License": "GPL",
        "Name": "Home Files",
        "Version": "0.1",
        "Website": "https://kde.org/plasma-desktop"
    }
}
```

In this example the plugin ID gets derived from the plugin file name, in this case `runner_example_homefiles`.
Entries such as `Name`, `Description`, `License` and `Authors` are information shown in the user interface that have no other technical importance. Try to avoid using jargon in the `Name` and `Description` entries, however, to make it easy for people to understand what your plugin does.
For further reading, refer to the [KRunner Metadata Format]({{< ref "metadata.md" >}}) documentation.

### The Class Definition (Header file) 


Our class definition for this project looks as follows:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.h" highlight="cpp" >}}

Even though it is a full featured Runner plugin it is just a handful of methods, each of which will be examined.

##  Initializing the Runner 


In typical usage, a Runner plugin is instantiated once and then reused multiple times for different queries. Each time a Runner is launched with a query to match against, it is called from a new thread, so some parts of our plugin will need to be thread safe.

Initialization of the Runner is done in four parts: the plugin declaration macro, the constructor, `init()`, and in `prepareForMatchSession()`, none of which need to be thread safe as they are all guaranteed to be called from the main application thread prior to any query matching activity. 


### The Plugin Declaration Macro 


At the end of our implementation (.cpp) file we have this:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=113 lines=3 >}}

The `.moc` file include is an [optimization](https://youtu.be/Cx_m-qVnEjo) that should look familiar enough from other Qt code, but the macro right above it probably does not. This is the macro that generates the plugin factory that the plugin is created from. Its first parameter is the respective class it belongs to, and its second parameter is the JSON metadata file.

### The Constructor 


The constructor looks like this:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=11 lines=5 >}}

The `parent` and `data` parameters are critical to the proper loading of the plugin and are passed into the `AbstractRunner` superclass in the initialization list. The args can optionally contain additional information for loading the plugin, in the case of KRunner we should just pass this to the superclass.

Next we set the expected priority of the runner. This property affects the scheduling of the Runner when there is a pool of plugins to choose from during query matching. 

### init() 

The `init()` method should contain any set up that needs to happen prior to matching queries that should be done exactly once during the lifespan of the plugin.
In our class, the `init()` method is very simple:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=17 lines=11 >}}

It loads the configuration for the Runner (see below) and [connects](https://doc.qt.io/qt-6/signalsandslots.html) two critical signals: `prepare` and `teardown`.

You should try to avoid load large amounts of data in `init()` if unneeded, because it blocks the main thread.
The final place that initialization may occur is in the lambda connected to the `prepare()` signal. This signal is emitted whenever matches for queries are going to start. Zero, one or more query match requests may then be made after which the `teardown()` signal will be emitted. In the connected slots, data that is used during the match session can be initialized. These methods are also called from the main thread.

##  The Main Event: Matching Queries 


The primary purpose of a Runner plugin is to return potential matches for a given query string. These matches are then presented in some fashion to the user who may select one or more of the matches.

For each letter typed, the plugin's `match()` method gets called in a new thread. This ensures the user interface remains fluid. Old `match()` method calls can run to their completion even when ignored.

Whenever a Runner is asked to perform a match, the `match(Plasma::RunnerContext &context)` method is called. This method **must** be thread safe as it can be called simultaneously from different threads. Ensure that all data used is read only (and thread safe when reading), local to the match method, or protected by a mutex.

The [Plasma::RunnerContext](docs:krunner;RunnerContext) passed into match offers all the information we'll need about the query being made. The [Plasma::RunnerContext](docs:krunner;RunnerContext) will also take care of accepting matches our Runner generates and collating them with the matches produced by other Runners that may also be in use.

Let's examine the match method in our example Runner, line by line:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=48 lines=22 >}}

So far it is quite straightforward, though we can already see a few common techniques. Before doing any more complex processing, if the query matches certain criteria, the match method returns quickly. This frees up that thread in the pool for use by another Runner or for another query.

We can also see the use of a "trigger word". A trigger word is used to mark a specific query so that the user can better control the results through the use of keywords. For example, the Spell Checker Runner uses "spell" as its trigger word (translated to the current user's language, of course); this allows one to type "spell plasma" and have it checked in the dictionary. This concept does not map well to all Runners, but can be a very effective technique in the right circumstances.

A third technique is to modify the query (or even accept it) based on a minimal size. In this case, we turn any query that has 3 or more letters into a glob with a `*` on each end. To preserve efficiency and make the results more useful, we limit globbing to only queries of at least 2 characters. This isn't done for queries of only one or two letters since that would likely generate far more matches than desired on any query text. Skipping some or all processing of such small queries is a common practice.

```cpp
    QDir dir(m_path);
```

Next, a `QDir` object is created. According to the Qt documentation, `QDir` is reentrant but not thread safe. Because of this it is safe to use a `QDir` object in a thread, but not to share one between different threads. So we are forced to create a local object to use in the match method. If `QDir` was thread safe, we could create one in the slot connected to the `prepare` signal, for instance, and potentially gain some extra efficiency.

```cpp
    QList<Plasma::QueryMatch> matches;
```

Next, a list is defined to hold the matches the Runner creates. This will allow the matches to be queued up and then added all at once at the end. This is slightly more efficient than the alternative of adding matches one at a time as they are created.

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=73 lines=9 >}}

Now to the heart of the matter! We ask the `QDir` object for a list of files in our target directory that match the query. We do some basic sanity checking on the result before moving on and checking if the context itself is still valid:

```cpp
        if (!context.isValid()) {
            return;
        }
```

Since the query may change while the Runner is processing in another thread, the user may no longer care about the results the Runner in this thread is currently generating. In this case, the context object we received will be marked as invalid. By checking this, particularly before doing expensive processing or spinning in a potentially large loop, the Runner can avoid using more CPU and thread pool time than necessary. This makes the user interface feel snappier.

Next, we create a [Plasma::QueryMatch](docs:krunner;QueryMatch) object and add it to our list of matches:
{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=85 lines=16 >}}

[Plasma::QueryMatch](docs:krunner;QueryMatch) objects are small data containers, little more than glorified structs really. As such, they are generally created on the stack, are thread safe, and can be copied and assigned without worry.

We set several of the properties on the match, including the text and icon that will be shown in the user interface. The ID that is set is specific to our Runner and can be used for later saving, ranking and even re-creation of the match. The data associated with the match is also specific to the Runner; any `QVariant` may be associated with the match, making later execution of the match easier. 

Finally, a relevance between 0.0 and 1.0 is assigned according to how "close" a match is to the query according to the Runner. In the case of the Home Files Runner, if the query matches a file that has the exact type of the match, it is set to `ExactMatch`. Other possible match types of interest to Runner plugins include `PossibleMatch` (the default) and `InformationalMatch`. `InformationalMatch` is an interesting variation: it is a match that offers information but no further action to be taken; an example might be the answer to a mathematical equation. Not only are `InformationalMatch` matches shown with higher ranking than `PossibleMatch` matches, but when selected the data value is copied to the clipboard and put into the query text edit.

Also note how the icons are cached in a `QHash` so that the relatively expensive call to `KMimeType` for the icon need only be made once per matching file. This can really add up if the query grows in length (e.g., "p", "pl", "pla", "plas", etc.) but continues to match the same file repeatedly. Since the `QHash` is cleared when the `teardown` signal is called, the added memory overhead does not become a concern.

Finally, once the for loop is completed, we add any matches created to the context that was passed in:

```cpp
    context.addMatches(matches);
```

That's it! The Runner does not need to worry if the matches are still valid for the current query and can create any number of matches as it goes. It can even offer them up in batches by either calling `context.addMatch()` for each match created or calling `context.addMatches()` every so often. Generally Runners match quickly and so batch up their finds and submit them all at once.

##  "Running" a Match 


If a match is selected by the user and it is not a `Plasma::QueryMatch::InformationalMatch`, the Runner is once again called into action and the `run()` method is invoked. This method does not need to be thread safe, so we can code with a bit more ease here. Our example Runner has this for its implementation:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=104 lines=8 >}}

As can be seen, the match that was selected was passed back to the Runner again along with the relevant context (though this object is rarely needed). What the Runner does at this point is completely up to the given implementation; in this case the Home Files Runner just uses KRun to open up the file it found earlier.

There is no limitation as to what the Runner can do, but this method is run from the main thread so blocking in the `run()` method is considered poor form. If the process will take any considerable amount of time, consider making it asynchronous.

##  Configuration 


Runners can offer two kinds of configuration: configuration of the Runner itself (such as what the trigger word is), and configuration that controls what (or how) action is taken on a given match when it is selected.

### Runner Options 


Configuration options for a Runner can be read and written to the `KConfigGroup` returned by the `AbstractRunner::config()` method. The best place to read configuration values is in the `reloadConfiguration()` method; this is a virtual method in `AbstractRunner` that gets called when the configuration changes on disk.

In the Home Files Runner, configuration values are read in this fashion:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=28 lines=19 >}}

Both the trigger word and the path of the directory to look in are read from the configuration group and this method is called from Home File Runner's `init()` implementation. 

Note that if there was a trigger word provided by default, it should be marked for translation with `i18nc("Note this is a KRunner keyword", "trigger")`. This will both ensure that translators know how to translate it properly (thanks to the comment) and that users will be able to use the runner in their own language.

What you may also notice in the above code snippet is the use of a new class: [Plasma::RunnerSyntax](docs:krunner;RunnerSyntax).

### Publishing Recognized Syntax 


Runners may advertise what sorts of queries they understand by creating [Plasma::RunnerSyntax](docs:krunner;RunnerSyntax). objects. This information can be requested by the user as a form of run-time documentation and may even be used by some applications to decide which Runners to launch or not. Therefore, while creating [Plasma::RunnerSyntax](docs:krunner;RunnerSyntax) objects is optional, it is also highly recommended.

Let's examine the code in `HomeFilesRunner::reloadConfiguration()` concerning syntax definition a bit closer:

{{< readfile file="/content/docs/plasma/krunner/homefilesrunner/homefilesrunner.cpp" highlight="cpp" start=42 lines=4 >}}

On the first line, we create a `QList` object to put our syntax objects into. We can add syntax objects one at a time, but using a QList, even if there is only one syntax, is usually more convenient.

The syntax object is created in lines 2-3 with the first parameter being an example of the query and the second parameter being a description of what such a query will result in. In the case of the Home Files Runner the syntax is created when the configuration is read because the syntax depends on the trigger word that is set (if any exists).

One special string in both the query example and the explanatory text is ":q:". This stands for "the variable query text entered by the user" and will be replaced in the user interface with something more meaningful when shown as documentation or as a delimiter to look for when analyzing Runner appropriateness.

If a Runner understands multiple query formulations that result in the same matches being generated (or "query synonyms"), these synonymous queries can be added to the syntax object using [Plasma::RunnerSyntax::addExampleQuery](docs:krunner;Plasma::RunnerSyntax::addExampleQuery).

### Runner Configuration


Providing a configuration interface for a Runner is accomplished by creating a `KCModule` plugin.
The path to the plugin should be registered in the JSON metadata:

```json
{
    "KPlugin": {
    },
    "X-KDE-ConfigModule": "kf5/krunner/kcms/kcm_homefilesrunner"
}
```

The installation of the plugin goes as follows:

```cmake
kcoreaddons_add_plugin(kcm_homefilesrunner SOURCES kcm_homefilesrunner.cpp INSTALL_NAMESPACE kf5/krunner/kcms)
```

The config module does not need embedded JSON metadata and can be exported using:   
```cpp
K_PLUGIN_CLASS(HomeFilesRunnerConfig)
```

This KCM can be launched from the KRunner configuration page or the Help Runner (the one that can be activated by typing `?`). When the settings are saved, `reloadConfiguration()` will be called.

## Single Runner Mode


For some Runners, it can make sense to support being the only Runner being used. Usually an application will use multiple runners at once via `Plasma::RunnerManager`, but it can also use just one runner or put `Plasma::RunnerManager` into a special "single runner" mode.
This feature is currently only exposed using the DBus interface. A common usecase is to bind a keyboard shortcut to a Runner. See https://github.com/alex1701c/EmojiRunner/blob/master/EmojiRunnerCommands.khotkeys#L26 for an example.

A Runner can, if desired, detect when it is being used as the sole Runner by calling [Plasma::RunnerContext::singleRunnerQueryMode](docs:krunner;RunnerContext::singleRunnerQueryMode) on the context object passed into the match method. If the return value is `true`, then the Runner may decide to alter its behavior (like not requiring a trigger word).
