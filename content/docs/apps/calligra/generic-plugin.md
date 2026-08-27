---
title: "Generic Calligra plugin creation"
weight: 1
description: A technical introduction to how plugins are structured in Calligra
---

Writing a plugin for Calligra technically means that you create the following things:

- A **plugin class**, as an entry point to everything below. This is really a plugin-loader
  object, and it is created only so that it can register the plugin's factories with the
  relevant Calligra registries.
- An implementation of one of the base classes (interfaces) from the Calligra libraries, for the
  functionality that is unique to your plugin. Examples of these interfaces are `KoShape`,
  `KoToolBase` and `KoColorSpace`.
- A **factory class**. The factory design pattern allows the plugin to create as many instances
  of the plugin's object as required by the user. For example, when a new view is opened,
  Calligra asks shape plugins to create a new tool for that view. Each Calligra plugin type has
  its own factory base class that your factory should inherit from.
- A **plugin library** that contains all classes that make up the plugin.
- A **JSON metadata file** installed alongside the plugin, with information about the plugin such
  as its name and the service types it provides.

This tutorial assumes that you have a basic understanding of C++ and Qt/KDE Frameworks concepts,
and that you have the development packages for Qt and KDE Frameworks 6 installed, as well as
`extra-cmake-modules`.

## The concept of a plugin

The concept is based on what object-oriented design calls a programming interface: you can define
an interface and encapsulate it in a class without saying much about how it is implemented. You
can then supply several classes that actually contain the implementation of that interface, each
in their own way. Plugins are a way to provide a different implementation for a known interface,
without the application that uses the interface needing to know about it at compile time.

Calligra has defined several classes as base classes and has made the interfaces of those base
classes generic enough that a wide range of functionality can be accomplished by shipping a
plugin with a new implementation of such a base class.

For example, one plugin type that Calligra supports is a docker widget: a widget shown on screen,
like a `QDockWidget` in any other Qt application. A plugin can ship a new implementation of
`QDockWidget`, providing whatever text, buttons and functionality it needs using the full API of
Qt and the Calligra libraries. This means you could write a plugin that ships a docker that shows
the time of day. Once the plugin is installed, Calligra applications find it and the docker is
created and shown on screen.

One unique property of a plugin is that it is self-contained: the end result is one library that
exports just the 'plugin object'. This means that code and classes changed in one plugin cannot
affect code in another plugin, or in the Calligra applications themselves. This keeps development
more separated, so changes in one place do not cause problems in another. You are therefore free
to use whatever number of classes fit your design and programming style, and to avoid namespaces
or class name prefixes if you wish — your plugin is walled off, so nobody is bothered by what you
do or how you do it.

## Components

The **first component** is the class that implements the interface this plugin represents. Each
plugin type goes into detail on this elsewhere, as each interface has different features and
requirements — see [Flake shape creation](flake-plugin) for the `KoShape` case.

The **factory component** is also unique per plugin type, but generic in setup and idea. The
reason a factory exists is that it makes it possible to create any number of instances of the
plugin's object, whenever the host application (probably at the request of the user) wants to do
so. The general workflow is:

1. A plugin is loaded and a factory is created (see the plugin component below).
2. The factory is registered in a registry (`KoShapeRegistry`, `KoToolRegistry`,
   `KoDockRegistry`, ...).
3. Applications query the registry for all available plugins, and use, for example, the name and
   icon from the factory to show buttons on screen.
4. The user clicks a button, or otherwise selects the plugin.
5. The plugin factory is asked to create a new instance of the thing it is meant to create.
6. That new shape, tool, widget or other object is used in the document or the GUI, depending on
   the plugin type.

This means that a factory is your plugin's main advertisement to the outside world, since it is
used to show the user what your plugin can do. Each plugin type has its own factory base class,
with at minimum a `create()`-like method that returns a new instance. These factory base classes
typically expose a number of properties you can set to describe your plugin, such as a name or an
icon — it is worth filling in as many of these as are relevant.

The next component is the **plugin component**: a `QObject`-derived class with a specific
constructor signature that is instantiated once, immediately used to register its factories, and
then deleted again. The trick is therefore to do all the work of creating and registering
factories in the constructor. The code for this class is simple, and you copy-paste it with only
a few modifications.

In the header file:

{{< readfile file="/content/docs/apps/calligra/generic-plugin/MyPlugin.h" highlight="c++" >}}

In the cpp file:

{{< readfile file="/content/docs/apps/calligra/generic-plugin/MyPlugin.cpp" highlight="c++" >}}

This example registers two factories, but you can register any number in a single plugin. Note
how only the factories are created here, and nothing else is done — this keeps loading of the
plugin as fast as possible.

If you copy-paste this code, update `MyPlugin`, `MyPluginFactory` and the included headers to
match your own class names, and change `"myplugin.json"` to the name of your own metadata file.
The [`K_PLUGIN_FACTORY_WITH_JSON`](https://api.kde.org/kcoreaddons.html#K_PLUGIN_FACTORY_WITH_JSON)
macro, from `<KPluginFactory>`, is what turns your plugin class into a loadable KDE plugin; it
also takes care of exposing the JSON metadata to the plugin loader.

The **library** is what contains all the compiled classes of your plugin. A plugin is technically
implemented as a shared library, loaded by Calligra the first time something asks its registry
for plugins of the relevant type — not necessarily at application start. It is possible for your
plugin to depend on other shared libraries, apart from the Calligra and KDE Frameworks ones, but
you are then responsible for making sure they are installed alongside your plugin.

In CMake, building and installing the plugin library looks like this:

{{< readfile file="/content/docs/apps/calligra/generic-plugin/CMakeLists.txt" highlight="cmake" >}}

A few things worth noting:

- The plugin is built as a `MODULE` library, not a normal shared library — it is meant to be
  loaded dynamically at runtime, not linked against.
- Calligra's registries look for plugins in specific subdirectories of the Qt plugin path, under
  `calligra/`. Shape plugins go in `calligra/shapes`, tools in `calligra/tools`, and dockers in
  `calligra/dockers`. Installing into the right subdirectory is what makes your plugin
  discoverable — the `ServiceTypes` entry in the JSON metadata is only informational.
- `TRANSLATION_DOMAIN` should match the name you use for the plugin's `.po` files, so that strings
  wrapped in `i18n()` are translated correctly.
- `find_package(CalligraQt6 REQUIRED COMPONENTS flake)` is Calligra's CMake package config. It
  provides one imported target per library, namespaced as `CalligraQt6::<library>` — here
  `CalligraQt6::flake` — and each of those already carries the right include directories and
  public link dependencies with it, so you only need to link the one component you actually use.
  `CalligraQt6` currently provides these components: `flake`, `pigmentcms`, `koodf`,
  `kowidgetutils`, `kundo2`, `kostore` and `interfaces` — request whichever ones your plugin needs
  directly (e.g. `COMPONENTS flake pigmentcms` if you also touch color spaces), and
  `find_package()` fails with a clear error if a requested component isn't available.
- This only works once Calligra itself has been configured and installed with
  `-DSHOULD_BUILD_DEVEL_HEADERS=ON` — that's what makes `CalligraQt6Config.cmake` get installed
  in the first place (see the note above).

Last is the **JSON metadata component**, which is how the plugin is described to the plugin
loader. In older Calligra (and KDE Frameworks 4) versions this used to be a `.desktop` file, but
KDE Frameworks plugins are now described with an embedded JSON document instead. For our example,
here is `myplugin.json`:

{{< readfile file="/content/docs/apps/calligra/generic-plugin/myplugin.json" highlight="json" >}}

A couple of things are important:

- The `Name` is shown to the user in plugin listings.
- The `ServiceTypes` field records which kind of plugin this is (`Calligra/Shape`,
  `Calligra/Tool`, `Calligra/Dock`, ...). It is mostly documentation at this point, since
  Calligra locates plugins by scanning the plugin subdirectory described above, but it is good
  practice to keep it accurate.
- `X-Flake-MinVersion` and `X-Flake-PluginVersion` let Calligra pick the newest version of a
  plugin when the same plugin is found installed in more than one location; bump
  `X-Flake-PluginVersion` whenever you release an updated version of the plugin.

See [Flake shape creation](flake-plugin) for a full, concrete walk-through of writing a shape
plugin using these building blocks.
