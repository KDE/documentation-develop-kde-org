---
title: KRunner C++ plugin
---

##  Abstract 


The Plasma workspace provides an application called KRunner which, among other things, allows one to type into a text area which causes various actions and information that match the text appear as the text is being typed.

This functionality is provided via plugins loaded at runtime called "Runners". These plugins can be used by any application using the KRunner library, like the normal Application Launcher or the Plasma-Mobile search applet. This tutorial explores how to create a runner plugin.

##  Basic Anatomy of a Runner 


[Plasma::AbstractRunner](docs:krunner;AbstractRunner)
is the base class of all Runners. It provides the basic structure for Runner plugins to:

* Perform one-time setup upon creation
* Perform setup and teardown before and after matching starts
* Create and register matches for a given search term
* Define secondary actions for a given match
* Take action on a given match registered by the runner
* Show configuration options

In addition to [Plasma::AbstractRunner](docs:krunner;AbstractRunner) there are three other important classes that we will be using from the Plasma library: 

* [Plasma::RunnerContext](docs:krunner;RunnerContext) which gives our plugin information about the current query
* [Plasma::QueryMatch](docs:krunner;QueryMatch) which represents a single match for a given query
* [Plasma::RunnerSyntax](docs:krunner;RunnerSyntax) which is used to advertise the query syntax understood by the plugin. 

Each of these classes will be covered in more detail as we encounter them in the Runner plugin implementation.

##  Creating a Runner Plugin Project 


In this tutorial we will be creating a Runner plugin that finds files in the user's home directory that match the query and offers to open them. We begin by setting up the basic project files including a CMakeLists.txt file for building and installing the plugin, a class definition in a header file and a source code file containing the class implementation.

### The CMakeLists.txt File 


CMake makes it very easy to set up the build system for our plugin:

```cmake
cmake_minimum_required(VERSION 3.16)
project(runnerexample)

set(KF5_MIN_VERSION "5.90")

# Include the Extra-CMake-Modules project
find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(FeatureSummary)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Runner)

# This takes care of building and installing the plugin
kcoreaddoons_add_plugin(plasma_runner_example_homefiles SOURCES homefilesrunner.cpp INSTALL_NAMESPACE "kf5/krunner")
# We need to link the KRunner and other used libraryies  to it
target_link_libraries(plasma_runner_example_homefiles KF5::Runner)
```

### The .json Metadata File


When KRunner queries the available plugins, it reads the embedded metadata. in order to provide this, we have to embed a json mteadata file. In this case we call it `homefilesrunner.json`. This name is referenced in the `K_PLUGIN_CLASS_WITH_JSON` macro futher below.

The contents of this file, as seen below, contain the name, description and technical details about the plugin.

```json
{
    "KPlugin": {
        "Authors": [
            {
                "Email": "aseigo@kde.org",
                "Name": "Aaron Seigo"
            }
        ],
        "Description": "Part of a tutorial demonstrating how to create Runner plugins",
        "EnabledByDefault": true,
        "License": "GPL",
        "Name": "Home Files",
        "Version": "0.1",
        "Website": "http://plasma.kde.org/"
    }
```

In this example the plugin id gets derived from the plugin file name, in this case "plasma_runner_example_homefiles"
The entries such as `Name`, Description, `License and `Authors` are information and are shown in the user interface but have no other technical importance. Try to avoid using jargon in the Name and Description entries, however, to make it easy for people to understand what your plugin does.

### The Class Definition (Header file) 


Our class definition for this project looks as follows:

```cpp
#pragma once

#include <KRunner/AbstractRunner>

#include <QHash>

#include <KIcon>

class HomeFilesRunner : public Plasma::AbstractRunner
{
    Q_OBJECT

public:
    HomeFilesRunner(QObject *parent, const QVariantList &args);

    void match(Plasma::RunnerContext &context);
    void run(const Plasma::RunnerContext &context, const Plasma::QueryMatch &match);
    void createRunOptions(QWidget *widget);
    void reloadConfiguration();

protected Q_SLOTS:
    void init();
    void prepareForMatchSession();
    void matchSessionFinished();

private:
    QHash<QString, KIcon> m_iconCache;
    QString m_path;
    QString m_triggerWord;
};
```

Even though it is a full featured Runner plugin it is just a handful of methods, each of which will be examined.

##  Initializing the Runner 


In typical usage, a Runner plugin is instantiated once and then reused multiple times for different queries. Each time a Runner is launched with a query to match against, it is called from a new thread so some parts of our plugin will need to be thread safe.

Initialization of the Runner is done in four parts: the plugin declaration macro, the constructor, init() and in prepareForMatchSession(), none of which need to be thread safe as they are all guaranteed to be called from the main application thread prior to any query matching activity. 


### The Plugin Declaration Macro 


At the end of our implementation (.cpp) file we have this:

```cpp
K_EXPORT_PLASMA_RUNNER(example-homefiles, HomeFilesRunner)

#include "homefilesrunner.moc"
```

The <tt>.moc</tt> file include looks familiar enough from other Qt code, but the macro right above it probably does not. This macro creates the factory functions needed to load the plugin at runtime. The first parameter, <tt>example-homefiles</tt>, is the same value as the <tt>X-KDE-PluginInfo-Name=</tt> entry in the <tt>.desktop</tt> file. The second parameter is the name of the <tt>AbstractRunner</tt> subclass.

### The Constructor 


The constructor look like this:

```cpp
HomeFilesRunner::HomeFilesRunner(QObject *parent, const QVariantList &args)
    : AbstractRunner(parent, args)
{
    setIgnoredTypes(Plasma::RunnerContext::NetworkLocation |
                    Plasma::RunnerContext::Executable |
                    Plasma::RunnerContext::ShellCommand);
    setSpeed(SlowSpeed);
    setPriority(LowPriority);
    setHasRunOptions(true);
}
```

The parent and args parameters are critical to the proper loading of the plugin and are passed into the AbstractRunner superclass in the initialization list. In the body of the constructor a number of properties are set, all of which are optional. Often the defaults are good enough, but in some cases it can make quite a difference to performance to have the right properties set.

The first property set, on line 4, is the type of matches to ignore. Before a Runner is passed a query some analysis is performed to determine whether the query might refer to a Directory, File, NetworkLocation, Executable,         ShellCommand, or Help request as define {{class|Plasma::RunnerContext}} in the Type enumeration. There are two special values in that enumeration: UnknownType which signifies a match which does not seem to fit any of the other categories and FileSystem which is a synonym for "Directory | File | Executable | ShellCommand". In our particular case, we only care for files and so skip those types which are probably not files at all. This will prevent our Runner from being launched unnecessarily.

Next we set the expected speed and priority of the runner. These properties affect the scheduling of the Runner when there is a pool of plugins to choose from during query matching. Slower runners are given limited access to the thread pool and lower priority runners are run after higher priority ones have been launched. Speed may be adjusted dynamically at runtime based on real performance, so marking a runner as "slow" will not create a penalty on machines that are faster and likewise setting a runner to "normal" speed may still result in it being demoted to "slow" if it performs poorly.

Finally, setHasRunOptions is called with the true value. This signifies that the matches generated by this Runner plugin can be configured. This is used, for instance, by the shell command runner to allow the user to define a different user to run the command as.

### init() 


The init() method is a protected slot. That it is a slot is critical due to an API oddity in AbstractRunner that will be addressed in a future release of the Plasma library (probably KDE5, since it requires a binary incompatible change). The init() method should contain any set up that needs to happen prior to matching queries that should be done exactly once during the lifespan of the plugin.

In the Home Files Runner the init() method is very simple:

```cpp
void HomeFilesRunner::init()
{
    reloadConfiguration();
    connect(this, SIGNAL(prepare()), this, SLOT(prepareForMatchSession()));
    connect(this, SIGNAL(teardown()), this, SLOT(matchSessionFinished()));
}
```

It loads the configuration for the runner (see below) and connects up two critical signals: prepare() and teardown().

init() should <b>not</b> load large amounts of data if unneeded or connect to external sources of information that may wake up the process. A common mistake is to connect to signals in the D-Bus interface of an external application. This results in the application using the Runner plugin to wake up whenever the application it is connected to also wakes up. A better way to do this is to use the prepare() signal.

### prepare() and teardown() 


The final place that initialization may occur is in a slot connected to the prepare() signal. This signal is emitted whenever matches for queries are going to commence. Zero, one or more query match requests may then be made after which the teardown() signal will be emitted. These are perfect places to connect to external signals or update data sets as these signals are emitted precisely when the Runner is about to be (or cease being) active.

In our example, we have connected to both signals for example purposes though only the matchSessionFinished() slot does anything actually useful in this case:

```cpp
void HomeFilesRunner::matchSessionFinished()
{
    m_iconCache.clear();
}
```

By clearing the icons that we have cached, the Runner is not holding on to memory allocations unnecessarily between queries. Since there may be numerous Runner plugins instantiated, hours or even days between queries and the applications that use Runner plugins such as KRunner are often long-lived this is an important kind of optimization.

##  The Main Event: Matching Queries 


The primary purpose of a Runner plugin is to return potential matches for a given query string. These matches are then presented in some fashion to the user who may select one or more of the matches.

In the KRunner application, when its main window is shown a query session is started (resulting in a prepare() signal) and whenever a letter is typed a query is started. This gives the impression of "as you type" searching to the user. Threads ensure the user interface remains fluid and old query matches can run to their completion even though ignored.

Whenever a Runner is asked to perform a match, the match(Plasma::RunnerContext &context) method is called. This method <b>must</b> be thread safe as it can be called simultaneously in different threads. Ensure that all data used is read-only (and thread safe when reading), local to the match method or protected by a mutex.

The {{class|Plasma::RunnerContext}} passed into match offers all the information we'll need about the query being made. Besides the query itself, we can check what (if any) type the query was determined to be during initial analysis and the mimetype (if any) of a file that the query may be referencing. The {{class|Plasma::RunnerContext}} will also take care of accepting matches our Runner generates and collating them with the matches produced by other Runners that may also be in use.

Let's examine the match method in our example Runner, line by line:

```cpp
void HomeFilesRunner::match(Plasma::RunnerContext &context)
{
    QString query = context.query();
    if (query == QCharLatin1('.') || query == QStringLiteral("..")) {
        return;
    }

    if (!m_triggerWord.isEmpty()) {
        if (!query.startsWith(m_triggerWord)) {
            return;
        }

        query.remove(0, m_triggerWord.length());
    }

    if (query.length() > 2) {
        query.prepend('*').append('*');
    }
```

So far it is quite straight orward, though we can already see a few common techniques. Before doing any more complex processing, if the query matches certain criteria, the match method returns quickly. This frees up that thread in the pool for use by another Runner or for another query.

We can also see the use of a "trigger word". A trigger word is used to mark a specific query so that the user can, through the use of keywords, better control the results. For example, the spell checker Runner uses "spell" (translated to the current user's language, of course) as its trigger word; this allows one to type "spell plasma" and have it checked in the dictionary. This concept does not map well to all Runners, but can be a very effective technique in the right circumstances.

A third technique is to modify the query (or even accept it) based on a minimal size. In this case, we turn any query that has 3 or more letters in it into a glob with a * on each end. To preserve efficiency and make the results more useful, we limit globbing to only queries of at least 2 characters. This isn't done for queries of only one or two letters since that would likely generate far more matches than desired on any query text. Skipping some or all processing of such small queries is a common practice.

```cpp
    QDir dir(m_path);
```

Next, a {{class|QDir}} object is created. According to the Qt documentation, QDir is reentrant but not thread safe. Because of this it is safe to use a QDir object in a thread, but not to share one between different threads. So we are forced to create a local object to use in the match method. If QDir was thread safe, we could create one in the slot connected to the prepare() signal, for instance, and potentially gain some additional efficiencies.

```cpp
    QList<KRunner::QueryMatch> matches;
```

Next, a list is defined to hold the matches the Runner creates. This will allow the matches to be queued up and then added all at once at the end. This is slightly more efficient than the alternative of adding matches one at a time as they are created.

```cpp
    for (const QString &file : dir.entryList(QStringList(query))) {
        const QString path = dir.absoluteFilePath(file);
        if (!path.startsWith(m_path)) {
            // this file isn't in our directory; looks like we got a query with some
            // ..'s in it!
            continue;
        }
```

Now to the heart of the matter! We ask the QDir object for a list of files in our target directory that match the query. We do some basic sanity checking on the result before moving on and checking if the context itself is still valid:

```cpp
        if (!context.isValid()) {
            return;
        }
```

Since the query may change while the Runner is processing in another thread, the user may not longer care about the results the Runner in this thread is currently generating. In this case, the context object we received will be marked as invalid. By checking this, particularly before doing expensive processing or spinning in a potentially large loop, the Runner can avoid using more CPU and thread pool time than necessary. This makes the user interface feel more snappy.

Next, we create a {{class|Plasma::QueryMatch}} object and add it to our list of matches:

```cpp
        KRunner::QueryMatch match(this);
        match.setText(i18n("Open %1", path));
        match.setData(path);
        match.setId(path);
        if (m_iconCache.contains(path)) {
            match.setIcon(m_iconCache.value(path));
        } else {
            KIcon icon(KMimeType::iconNameForUrl(path));
            m_iconCache.insert(path, icon);
            match.setIcon(icon);
        }

        if (file.compare(query, Qt::CaseInsensitive)) {
            match.setRelevance(1.0);
            match.setType(Plasma::QueryMatch::ExactMatch);
        } else {
            match.setRelevance(0.8);
        }

        matches.append(match);
    }
```

{{class|Plasma::QueryMatch}} objects are small data containers, little more than glorified structs really. As such, they are generally created on the stack, thread safe and can be copied and assigned without worry.

We set several of the properties on the match, including the text and icon that will be shown in the user interface. The id that is set is specific to our Runner and can be used for later saving, ranking and even re-creation of the match. The data associated with the match is also specific to the runner; any QVariant may be associated with the match, making later execution of the match easier. 

Finally, a relevance between 0.0 and 1.0 is assigned according to how "close" a match is to the query according to the Runner. In the case of the Home Files runner, if the query matches a file exactly the type of the match is set to "ExactMatch". Other possible match types of interest to Runner plugins include PossibleMatch (the default) and InformationalMatch. InformationMatch is an interesting variation: it is a match which offers information but no further action to be taken; an example might be the answer to a mathematical equation. Not only are InformationalMatch matches shown with higher ranking than PossibleMatch matches, but when selected the data value is copied to the clipboard and put into the query text edit.

Also note how the icons are cached in a QHash so that the relatively expensive call to KMimeType for the icon need only be made once per matching file. This can really add up if the query grows in length (e.g. "p", "pl", "pla", "plas", etc) but continues to match the same file repeatedly. Since the QHash is cleared when the teardown() signal is called, the added memory overhead does not become a concern.

Finally, once the foreach loop is completed, we add any matches created to the context that was passed in:

```cpp
    context.addMatches(context.query(), matches);
}
```

That's it! The runner does not need to worry if the matches are still valid for the current query and can create any number of matches as it goes. It can even offer them up in batches by either calling context.addMatch(match) for each match created or calling context.addMatches every so often. Generally Runners match quickly and so batch up their finds and submit them all at once.

##  "Running" a Match 


If a match is selected by the user and it is not an InformationalMatch, the Runner is once again called into action and the run method is invoked. This method does not need to be thread safe, so we can code with a bit more ease here. Our example Runner has this for its implementation:

```cpp
void HomeFilesRunner::run(const Plasma::RunnerContext &context, const Plasma::QueryMatch &match)
{
    Q_UNUSED(context)
    // KRun autodeletes itself, so we can just create it and forget it!
    auto opener = new KRun(match.data().toString(), 0);
    opener->setRunExecutables(false);
}
```

As can be seen, the match that was selected was passed back to the Runner again along with the relevant context (though this object is rarely needed). What the Runner does at this point is completely up to the given implementation; in this case the Home Files Runner just uses KRun to open up the file it found earlier.

There is no limitation as to what the Runner can do, but this method is run from the main thread so blocking in the run method is considered poor form. If the process will take any considerable amount of time, consider making it asynchronous.

##  Configuration 


Runners can offer two kinds of configuration: configuration of the Runner itself (such as what the trigger word is) and configuration that controls what (or how) action is taken on a given match when it is selected.

### Runner Options 


Configuration options for a Runner can be read and written to the KConfigGroup returned by the AbstractRunner::config() method. The best place to read configuration values is in the reloadConfiguration() method; this is a virtual method in AbstractRunner that gets called when the configuration changes on disk.

In the Home Files Runner, configuration values are read in this fashion:

```cpp
void HomeFilesRunner::reloadConfiguration()
{
    KConfigGroup c = config();
    m_triggerWord = c.readEntry("trigger", QString());
    if (!m_triggerWord.isEmpty()) {
        m_triggerWord.append(' ');
    }

    m_path = c.readPathEntry("path", QDir::homePath());
    QFileInfo pathInfo(m_path);
    if (!pathInfo.isDir()) {
        m_path = QDir::homePath();
    }

    QList<Plasma::RunnerSyntax> syntaxes;
    Plasma::RunnerSyntax syntax(QString("%1:q:").arg(m_triggerWord),
                                i18n("Finds files matching :q: in the %1 folder"));
    syntaxes.append(syntax);
    setSyntaxes(syntaxes);
}
```

Both the trigger word and the path of the directory to look in are read from the configuration group and this method is called from Home File Runner's init() implementation. 

Note that if there was a trigger word provided by default that it should be marked for translation with i18nc("Note this is a KRunner keyword", "trigger"). This will both ensure that translators know how to translate it properly (thanks to the comment) and that users will be able to use the runner in their own language.

What you may also notice in the above code snippet is the use of a new class: {{class|Plasma::RunnerSyntax}}.

### Publishing Recognized Syntax 


Runners may advertise what sorts of queries they understand by creating {{class|Plasma::RunnerSyntax}} objects. This information can be requested by the user as a form or run-time documentation and may even be used by some applications to decide which Runners to launch or not. Therefore, while creating {{class|Plasma::RunnerSyntax}} objects is optional it is also highly recommended.

Let's examine the code in HomeFilesRunner::reloadConfiguration() concerning syntax definition a bit closer:

```cpp
    QList<Plasma::RunnerSyntax> syntaxes;
    KRunner::RunnerSyntax syntax(QString("%1:q:").arg(m_triggerWord),
                                i18n("Finds files matching :q: in the %1 folder"));
    syntaxes.append(syntax);
    setSyntaxes(syntaxes);
}
```

On the first line, we create a {{class|QList}} object to put our syntax objects into. We can add syntax objects one at a time, but using a QList, even if there is only one syntax, is usually more convenient.

The syntax object is created on lines 2-3 with the first parameter being an example of the query and the second parameter being a description of what such a query will result in. In the case of the HomeFilesRunner the syntax is created when the configuration is read in because the syntax depends on the trigger word (if any) that is set.

One special string in both the query example and the explanatory text is ":q:". This is stands for "the variable query text entered by the user" and will be replaced in the user interface with something more meaningful when shown as documentation or as a delimiter to look for when analyzing Runner appropriateness.

If a Runner understands multiple query formulations that result in the same matches being generated (or "query synonyms"), such synonymous queries can be added to the syntax object using Plasma::RunnerSyntax::addExampleQuery(const QString &exampleQuery).

### Runner Configuration User Interface 


Providing a configuration interface for a Runner is accomplished by create a KCModule plugin and putting X-KDE-ParentComponents=pluginName in its associated .desktop file. The pluginName must be the same as the X-KDE-PluginInfo-Name entry in the Runner's configuration file.

{{improve|An example of how to write a KCModule plugin is in order, but that should probably be a tutorial of its own.}}

### Match Result Options 


If setHasRunOptions(true) has been called, matches from this Runner will be marked as configurable. When the user requests to configure a match, the `createRunOptions(QWidget *)` method in the Runner will be called. This method should create a configuration interface suited to its needs with the QWidget passed in as the parent.

The Home Files Runner has this as its implementation:

```cpp
void HomeFilesRunner::createRunOptions(QWidget *widget)
{
    QVBoxLayout *layout = new QVBoxLayout(widget);
    QCheckBox *cb = new QCheckBox(widget);
    cb->setText(i18n("This is just for show"));
    layout->addWidget(cb);
}
```

Very straight forward, if not very useful. In typical usage, the widgets are connected to slots in the Runner using the traditional Qt signal/slots mechanism.

This method is always called from the GUI thread, so threading is not an issue.

## Single Runner Mode


For many Runners, it can make sense to support being the only Runner being used. Usually an application will use multiple runners at once via Plasma::RunnerManager, but it can also use just one runner or put Plasma::RunnerManager into a special "single runner" mode.

For Runners to support this mode effectively, two simple things should be done. First, add a <tt>X-Plasma-SingleRunnerQueryMode=true</tt> entry to the .desktop file for the plugin. Second, create a Plasma::QuerySyntax but instead of passing it in using addSyntax, pass it into setDefaultSyntax:

```cpp
setDefaultSyntax(Plasma::RunnerSyntax(i18n("Sessions"), i18n("Lists all sessions")));
```

This will cause that syntax to be used as the default query, instead of an empty string, by default. Runners without a default syntax can still be used in single runner mode, but this may make writing the Runner's match method a bit simpler.

A Runner can, if desired, detect when it is being used as the sole runner by calling <tt>Plasma::RunnerContext::singleRunnerQueryMode()</tt> on the context object passed into the match method. If the return value is true, then the runner may decide to alter its behavior (such as showing a default list of matches in response to an empty query string).
