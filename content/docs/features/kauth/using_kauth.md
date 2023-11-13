---
title: Using actions in your applications
authors:
  - SPDX-FileCopyrightText: 2008 Nicola Gigante <nicola.gigante@gmail.com>
  - SPDX-FileCopyrightText: 2009 Dario Freddi <drf@kde.org>
  - SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
SPDX-License-Identifier: LGPL-2.1-or-later
aliases:
  - /docs/features/kauth/using_kauth/
---

Now that you've learned the basic KAuth concepts and how to register
a set of actions into the system, it's time to see how to actually
use KAuth actions inside your application.

## Implementing an action helper

From the code point of view, the helper is implemented as a QObject subclass.
Every action is implemented by a public slot. In the [example/](https://invent.kde.org/frameworks/kauth/-/tree/master/examples) directory in the
[source code tree for KAuth](https://invent.kde.org/frameworks/kauth) you can find a complete example. Let's look at that. The
`helper.h` file declares the class that implements the helper. It looks like:

{{< doxysnippet repo="frameworks/kauth" file="examples/helper.cpp" part="helper_declaration" lang="cpp" >}}

The slot names are the last part of the action name, without the helper's ID if
it's a prefix, with all the dots replaced by underscores. In this case, the
helper ID is `org.kde.kf5auth.example`, so those three slots implement the
actions `org.kde.kf5auth.example.read`, `org.kde.kf5auth.example.write` and
`org.kde.kf5auth.example.longaction`.

The helper ID doesn't have to appear at
the beginning of the action name, but it's good practice. If you want to extend
`MyHelper` to implement also a different action like
`org.kde.datetime.changetime`, since the helper ID doesn't match you'll have to
implement a slot called `org_kde_datetime_changetime()`.

The slot's signature is fixed: the return type is `ActionReply`, a class that
allows you to return results, error codes and custom data to the application
when your action has finished to run. Starting from KAuth 5.69, a fully qualified
name `KAuth::ActionReply` can be used for the return type.

Let's look at the `read()` action implementation. Its purpose is to read files:

{{< doxysnippet repo="frameworks/kauth" file="examples/helper.cpp" part="helper_read_action" lang="cpp" >}}

First, the code creates a default reply object. The default constructor creates
a reply that reports success. Then it gets the filename parameter from the
`QVariantMap` argument that has previously been set by the application, before
calling the helper. If it fails to open the file, it creates an `ActionReply`
object that notifies that some error has happened in the helper, then set the
error code to that returned by `QFile` and returns. If there is no error, it
reads the file. The contents are added to the reply.

Because this class will be compiled into a standalone executable, we need a
`main()` function and some code to initialize everything: you don't have to write
it. Instead, you use the `KAUTH_HELPER_MAIN()` macro that will take care of
everything. It's used like this:

{{< doxysnippet repo="frameworks/kauth" file="examples/helper.cpp" part="helper_main" lang="cpp" >}}

The first parameter is the string containing the helper identifier. Please note
that you need to use this same string in the application's code to tell the
library which helper to call, so please stay away from typos, because we don't
have any way to detect them.

The second parameter is the name of the helper's
class.  Your helper, if complex, can be composed of a lot of source files, but
the important thing is to include this macro in at least one of them.

To build the helper, KDE macros provide a function named
`kauth_install_helper_files()`. Use it in your `CMakeLists.txt` file like this:

```cmake
add_executable(<helper_target> your sources...)
target_link_libraries(<helper_target> your libraries...)
install(TARGETS <helper_target> DESTINATION ${KAUTH_HELPER_INSTALL_DIR})

kauth_install_helper_files(<helper_target> <helper_id> <user>)
```

As locale is not inherited, the auth helper will have the text codec explicitly set
to use UTF-8.

The first argument is the CMake target name for the helper executable, which
you have to build and install separately. Make sure to INSTALL THE HELPER IN
`${KAUTH_HELPER_INSTALL_DIR}`, otherwise `kauth_install_helper_files()` will not work. The
second argument is the helper ID. Please be sure to not misspell it, and to
not quote it. The `user` parameter is the user that the helper has to be run as.
It usually is root, but some actions could require less strict permissions, so
you should use the right user where possible (for example the user `apache` if
you have to mess with Apache settings). Note that the target created by this
macro already links to `libkauth` and `QtCore`.

## Action registration

To be able to authorize the actions, they have to be added to the policy
database. To do this in a cross-platform way, we provide a CMake macro. It
looks like the following:

```cmake
kauth_install_actions(<helper_id> <actions definition file>)
```

The `actions definition file` describes which actions are implemented by your code
and which default security options they should have. It is a common text file
in INI format, with one section for each action and some parameters. The
definition for the `read()` action is:

```ini
[org.kde.kf5auth.example.read]
Name=Read action
Description=Read action description
Policy=auth_admin
Persistence=session
```

The `Name` describes the action for *who reads the
file*. The `Description` is the message shown to the user in the
authentication dialog. It should be a phrase of reasonable size.  The `Policy` 
specifies the default rule that the user must satisfy to be authorized. Possible
values are:

- **yes**: the action should be always allowed
- **no**: the action should be always denied
- **auth_self**: the user should authenticate as themselves
- **auth_admin**: the user should authenticate as an administrator user

`Persistence` is optional. It determines how long an authorization should
be retained for that action. The values could be:
- **session**: the authorization persists until the user logs out
- **always**: the authorization will persist indefinitely

If this attribute is missing, the authorization will be queried every time.

{{< alert color="info" title="Note" >}}
Only the PolicyKit and polkit-1 backends use this attribute.
{{< /alert >}}

{{< alert color="warning" title="Warning" >}}
With the polkit-1 backend, "session" and "always" have the same meaning.
They just make the authorization persist for a few minutes.
{{< /alert >}}

## Calling the helper from the application

Once the helper is ready, we need to call it from the main application.
In `examples/client.cpp` you can see how this is done.

* To create a reference to an action, an object of type `Action` has to be created.
* Every `Action` object refers to an action by its action ID.
* Two objects with the same action ID will act on the same action.
* With an `Action` object, you can authorize and execute the action.
* To execute an action you need to retrieve an `ExecuteJob`, which is
a standard `KJob` that you can run synchronously or asynchronously.

See the `KJob` documentation (from KCoreAddons) for more details.

The piece of code that calls the action of the previous example is:

{{< doxysnippet repo="frameworks/kauth" file="examples/client.cpp" part="client_how_to_call_helper" lang="cpp" >}}

First of all, it creates the action object specifying the action ID. Then it
loads the filename (we want to read a forbidden file) into the `arguments()`
`QVariantMap`, which will be directly passed to the helper in the `read()` slot's
parameter. This example code uses a synchronous call to execute the action and
retrieve the reply. If the reply succeeded, the reply data is retrieved from
the returned `QVariantMap` object. Please note that you have
to explicitly set the helper ID to the action: this is done for added safety,
to prevent the caller from accidentally invoking a helper, and also because
KAuth actions may be used without a helper attached (the default).

Please note that if your application is calling the helper multiple times it
must do so from the same thread.

## Asynchronous calls, data reporting, and action termination

For a more advanced example, we look at the action
`org.kde.kf5auth.example.longaction` in the example helper. This is an action
that takes a long time to execute, so we need some features:
- The helper needs to regularly send data to the application, to inform about
  the execution status.
- The application needs to be able to stop the action execution if the user
  stops it or close the application.

The example code follows:

{{< doxysnippet repo="frameworks/kauth" file="examples/helper.cpp" part="helper_longaction" lang="cpp" >}}

In this example, the action is only waiting a "long" time using a loop, but we
can see some interesting lines. The progress status is sent to the application
using the `HelperSupport::progressStep()` method.  When this method is called,
the `HelperProxy` associated with this action will emit the `progressStep()`
signal, reporting the data back to the application.

There are two overloads for these methods and corresponding signals.
The one used here takes an integer. Its meaning is application dependent,
so you can use it as a sort of percentage.

The other overload takes a `QVariantMap` object that is directly passed to the app.
In this way, you can report to the application all the custom data you want.

In this example code, the loop exits when the `HelperSupport::isStopped()`
returns `true`. This happens when the application calls the `HelperProxy::stopAction()`
method on the corresponding action object.
The `stopAction()` method, this way, asks the helper to
stop the action execution. It's up to the helper to obey this request, and
if it does so, it should return from the slot, _not_ exit.

## Other features

It doesn't happen very frequently that you code something that doesn't require
some debugging, and you'll need some tool, even a basic one, to debug your
helper code as well. For this reason, the KDE Authorization library provides a
message handler for the Qt debugging system. This means that every call to
`qDebug()` & co. will be reported to the application, and printed using the same
Qt debugging system, with the same debug level.  If, in the helper code, you
write something like:

```cpp
qDebug() << "I'm in the helper";
```

You'll see something like this in the _application's_ output:

```
Debug message from the helper: I'm in the helper
```

Remember that the debug level is preserved, so if you use `qFatal()` you won't
only abort the helper (which isn't suggested anyway), but also the application.



<!-- TODO ## Getting data back -->

These code examples are licensed under the LGPL-2.1-or-later.
