---
title: Using separate files in a C++ project
group: introduction
weight: 6
description: >
  Separating unwieldy code into different files, and attach signals to your components.
aliases:
  - /docs/getting-started/kirigami/introduction-separatefiles/
---

## Why and how

For the first time, we will be separating some of our components into their own QML files. If we keep adding things to `Main.qml`, it's going to quickly become hard to tell what does what, and we risk muddying our code.

In this tutorial, we will be splitting the code in `Main.qml` into `Main.qml`, `AddDialog.qml` and `KountdownDelegate.qml`.

Additionally, even when spreading code between multiple QML files, the amount of files in real-life projects can get out of hand. A common solution to this problem is to logically separate files into different folders. We will take a brief look at three common approaches seen in real projects, and implement one of them:

* storing QML files together with C++ files
* storing QML files in a different directory under the same module
* storing QML files in a different directory under a different module

After the split, we will have [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) between each file, and [implementation details will be abstracted](https://en.wikipedia.org/wiki/Abstraction_(computer_science)), making the code more readable.

### Storing QML files together with C++ files

This consists of keeping the project's QML files together with C++ files in `src/`. This sort of structure would look like this:

```
kirigami-tutorial/
├── CMakeLists.txt
├── org.kde.tutorial.desktop
└── src/
    ├── CMakeLists.txt
    ├── main.cpp
    ├── Main.qml
    ├── AddDialog.qml
    └── KountdownDelegate.qml
```

This is what we did previously. In the above case, you would just need to keep adding QML files to the existing `kirigami-tutorial/src/CMakeLists.txt`. There's no logical separation at all, and once the project gets more than a couple of QML files (and C++ files that create types to be used in QML), the folder can quickly become crowded.

### Storing QML files in a different directory under the same module

This consists of keeping all QML files in a separate folder, usually `src/qml/`. This sort of structure would look like this:

```
kirigami-tutorial/
├── CMakeLists.txt
├── org.kde.tutorial.desktop
└── src/
    ├── CMakeLists.txt
    ├── main.cpp
    └── qml/
        ├── Main.qml
        ├── AddDialog.qml
        └── KountdownDelegate.qml
```

This structure is very common in KDE projects, mostly to avoid having an extra CMakeLists.txt file for the `src/qml/` directory and creating a separate module. This method keeps the files themselves in a separate folder, but you would also need to add them in `kirigami-tutorial/src/CMakeLists.txt`. All created QML files would then belong to the same QML module as `Main.qml`.

In practice, once the project gets more than a dozen QML files, while it won't crowd the `src/` directory, it will crowd the `src/CMakeLists.txt` file. It will become difficult to differentiate between traditional C++ files and C++ files that have types exposed to QML.

It will also break the concept of locality (localisation of dependency details), where you would keep the description of your dependencies in the same place as the dependencies themselves.

### Storing QML files in a different directory under a different module

This consists of keeping all QML files in a separate folder with its own CMakeLists.txt and own separate QML module. This sort of structure would look like this:

```
kirigami-tutorial/
├── CMakeLists.txt
├── org.kde.tutorial.desktop
└── src/
    ├── CMakeLists.txt
    ├── main.cpp
    ├── Main.qml
    └── components/
        ├── CMakeLists.txt
        ├── AddDialog.qml
        └── KountdownDelegate.qml
```

This structure is not as common in KDE projects and requires writing an additional CMakeLists.txt, but it is the most flexible. In our case, we name our folder "components" since we are creating two new QML components out of our previous `Main.qml` file, and keep information about them in `kirigami-tutorial/src/components/CMakeLists.txt`. The `Main.qml` file itself stays in `src/` so it's automatically used when running the executable, as before.

Later on, it would be possible to create more folders with multiple QML files, all grouped together by function, such as "models" and "settings", and C++ files that have types exposed to QML (like models) could be kept together with other QML files where it makes sense.

We will be using this structure in this tutorial.

## Preparing CMake for the new files

First, create the file `kirigami-tutorial/src/components/CMakeLists.txt` with the following contents:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/components/CMakeLists.txt" highlight="cmake" >}}

We create a new target called `kirigami-hello-components` and then turn it into a QML module using [ecm_add_qml_module()](https://api.kde.org/ecm/module/ECMQmlModule.html) under the import name `org.kde.tutorial.components` and add the relevant QML files.

Because the target is different from the executable, it will function as a different QML module, in which case we will need to do two things: make it *generate* code for it to work as a Qt plugin with [GENERATE_PLUGIN_SOURCE](https://api.kde.org/ecm/module/ECMQmlModule.html), and *finalize* it with [ecm_finalize_qml_module()](https://api.kde.org/ecm/module/ECMQmlModule.html). We then install it exactly like in previous lessons.

We needed to use [add_library()](https://cmake.org/cmake/help/latest/command/add_library.html) so that we can link `kirigami-hello-components` to the executable in the [target_link_libraries()](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) call in `kirigami-tutorial/src/CMakeLists.txt`:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/CMakeLists.txt" highlight="cmake" >}}

We also need to use [add_subdirectory()](https://cmake.org/cmake/help/latest/command/add_subdirectory.html) so CMake will find the `kirigami-tutorial/src/components/` directory.

In the previous lessons, we did not need to add the `org.kde.tutorial` import to our `Main.qml` because it was not needed: being the entrypoint for the application, the executable would run the file immediately anyway. Since our components are in a separate QML module, the a new import in `kirigami-tutorial/src/Main.qml` is necessary, the same one defined earlier, `org.kde.tutorial.components`:

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.tutorial.components

// The rest of the code...
```

And we are ready to go.

## Splitting Main.qml

Let's take a look once again at the original `Main.qml`:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-dialogs/Main.qml" highlight="qml" >}}

The custom delegate with `id: kountdownDelegate` can be split completely because it is already enveloped in a [QML Component type](docs:qtqml;QtQml.Component). We use a Component to be able to define it without needing to instantiate it; separate QML files work the same way.

If we move the code to a separate files, then, there is no point in leaving it enveloped in a Component: we can split just the [Kirigami.AbstractCard](docs:kirigami2;AbstractCard) in the separate file. Here is the resulting `KountdownDelegate.qml`:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/components/KountdownDelegate.qml" highlight="qml" >}}

Our dialog with `id: addDialog` is not enveloped in a Component, and it is not a component that is visible by default, so the code can be copied as is into the `AddDialog.qml`:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/components/AddDialog.qml" highlight="qml" >}}

With the code split, `Main.qml` thus becomes much shorter:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/Main.qml" highlight="qml" >}}

We now have two extra QML files, `AddDialog.qml` and `KountdownDelegate`, and we need to find some way of using them in `Main.qml`. The way to add the contents of the new files to `Main.qml` is by *instantiating* them.

`AddDialog.qml` becomes `AddDialog {}`:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/Main.qml" highlight="qml" start=31 lines=3 >}}

`KountdownDelegate.qml` becomes `KountdownDelegate {}`:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/Main.qml" highlight="qml" start=47 lines=5 >}}

Most cases you have seen of a component started with uppercase and followed by brackets were instantiations of a QML component. This is why our new QML files need to start with an uppercase letter.

Compile the project and run it, and you should have a functional window that behaves exactly the same as before, but with the code split into separate parts, making things much more manageable.
