---
title: "Flake shape creation"
weight: 2
description: Write a Flake shape plugin that can be loaded by any Calligra application
---

This tutorial will guide you step by step through the creation of a
[Flake](https://invent.kde.org/office/calligra/-/tree/master/libs/flake) shape. At the end you
will be able to write a shape that is loadable by any Calligra application.

For a technical introduction to how plugins in general are structured in Calligra, see
[Generic Calligra plugin creation](generic-plugin) — this tutorial reuses that plugin/factory
pattern for the shape-specific parts.

{{< alert title="Note" color="info" >}}
This tutorial builds the shape as a standalone plugin against an installed Calligra, via
`find_package(CalligraQt6)`. That means you need a Calligra built and installed with devel
headers enabled (`-DSHOULD_BUILD_DEVEL_HEADERS=ON`; check for `CalligraQt6Config.cmake` under
`<prefix>/lib64/cmake/CalligraQt6`).
{{< /alert >}}

## Do the groundwork: create a shape

First of all you need a class derived from the
[`KoShape`](https://invent.kde.org/office/calligra/-/blob/master/libs/flake/KoShape.h) class.
This will be the actual shape class, so you have to ensure that all the data you need for
painting is accessible from this `KoShape`-derived class.

The only method you **have** to reimplement is
[`paint()`](https://invent.kde.org/office/calligra/-/blob/master/libs/flake/KoShape.h), which is
responsible for painting your shape. `loadOdf()` and `saveOdf()` are also pure virtual, so your
shape needs to implement ODF loading and saving as well, even if that just means storing and
restoring your shape's data in a private namespace.

You might also be interested in the `setSize()` and `size()` methods, which control the size
available to the shape. Some shapes know the size they need on their own, so they reimplement
`size()` to return that fixed size instead of the size set on them — `KoFormulaShape` does this,
because a formula's size is dictated by its contents.

If your shape has a special outline, reimplement `outline()` to return your shape's outline
correctly. Rotation, scaling and skewing are handled through a transformation matrix, so you
don't need to worry about them yourself.

Here is roughly how your shape's header might look:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/KoFooShape.h" highlight="c++" >}}

Note that `paint()` now takes a `KoShapePaintingContext` in addition to the `QPainter` and
`KoViewConverter` — this carries extra state (such as whether the shape is being painted for
on-screen display or for a thumbnail) that used to be threaded through in other ways in older
versions of Calligra.

## Make your shape loadable: create a factory and a plugin

Once you have created your shape class and implemented everything necessary to make it at least
compile, you can think about how it gets loaded.

Calligra apps use
[`KoShapeFactoryBase`](https://invent.kde.org/office/calligra/-/blob/master/libs/flake/KoShapeFactoryBase.h)
to obtain instances of shapes in a generic way — an application of the
[abstract factory pattern](https://en.wikipedia.org/wiki/Abstract_factory_pattern). You should
implement a `KoShapeFactoryBase`-derived class that makes creating new instances of your shape
possible. There's one method you **must** override, since it's pure virtual:

- `bool supports(const KoXmlElement &element, KoShapeLoadingContext &context) const` — return
  `true` if the given ODF/SVG element is one your shape knows how to load. This is how Calligra
  picks the right shape factory while loading a document.

And two more you will usually want to override too:

- `KoShape *createDefaultShape(KoDocumentResourceManager *documentResources = nullptr) const`
- `KoShape *createShape(const KoProperties *params, KoDocumentResourceManager *documentResources = nullptr) const`

Both take an optional `KoDocumentResourceManager`, which gives you access to resources shared by
the whole document (such as an image collection), and both have sensible default implementations
in `KoShapeFactoryBase` — `createShape()` by default just ignores `params` and calls
`createDefaultShape()` — so you only need to reimplement the ones your shape actually needs.

An example factory header:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/FooShapeFactory.h" highlight="c++" >}}

And the corresponding implementation:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/FooShapeFactory.cpp" highlight="c++" >}}

With the factory, there is now a generic way to obtain an instance of your shape. But somehow you
still have to publish your shape as a plugin, so a Calligra application knows there is something
to load. The flake library provides
[`KoShapeRegistry`](https://invent.kde.org/office/calligra/-/blob/master/libs/flake/KoShapeRegistry.h)
for this: each application has access to the registry, and to let the application know about your
shape you register it there:

```c++
KoShapeRegistry::instance()->add(new FooShapeFactory());
```

This call has to happen somewhere, and that somewhere is the plugin class described in
[Generic Calligra plugin creation](generic-plugin) — a small `QObject`-derived class that is
instantiated once by the plugin loader purely so its constructor can perform this registration.

Example plugin header:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/FooShapePlugin.h" highlight="c++" >}}

Example plugin implementation:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/FooShapePlugin.cpp" highlight="c++" >}}

The `K_PLUGIN_FACTORY_WITH_JSON` macro (from `<KPluginFactory>`) is what makes `FooShapePlugin`
loadable as a KDE plugin, and ties it to the JSON metadata file described next.

The last piece is the JSON metadata file that describes your plugin and makes it findable by
Calligra. Example `calligra_shape_foo.json`:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/calligra_shape_foo.json" highlight="json" >}}

Finally, here is a `CMakeLists.txt` that builds and installs the plugin. Note that it installs
into `calligra/shapes` under the Qt plugin directory; that is what makes `KoShapeRegistry` find
it, since shape plugins are located by directory rather than by their `ServiceTypes` entry:

{{< readfile file="/content/docs/apps/calligra/flake-plugin/CMakeLists.txt" highlight="cmake" >}}

Once this is configured and built, your plugin is known system-wide and can be loaded by any
Calligra application. See [Generic Calligra plugin creation](generic-plugin) for more detail on
each of these pieces.

## Make your shape editable: create a tool

To edit your shape in the GUI, the user needs a tool to select and manipulate it. For this you
provide a
[`KoToolBase`](https://invent.kde.org/office/calligra/-/blob/master/libs/flake/KoToolBase.h)-derived
class, together with a
[`KoToolFactoryBase`](https://invent.kde.org/office/calligra/-/blob/master/libs/flake/KoToolFactoryBase.h)
that Calligra uses to instantiate your tool for each canvas — much like `KoShapeFactoryBase` is
used to instantiate shapes. A tool class implements all the edit actions that can be performed on
your shape, and it is possible to register more than one tool for the same shape (for example, a
dedicated tool that only edits your shape's text, in addition to a general-purpose one).

The factory is registered the same way a shape factory is, from your plugin's constructor:

```c++
KoToolRegistry::instance()->add(new FooToolFactory());
```

For a complete, real-world example of a shape and its accompanying tool, see the
[picture shape plugin](https://invent.kde.org/office/calligra/-/tree/master/plugins/pictureshape)
in the Calligra source tree, which pairs `PictureShape`/`PictureShapeFactory` with
`PictureTool`/`PictureToolFactory`.
