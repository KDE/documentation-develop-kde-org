---
title: "KAuth"
description: KAuth, privilege elevation for your program
weight: 5
group: "features"
authors:
  - SPDX-FileCopyrightText: 2008 Nicola Gigante <nicola.gigante@gmail.com>
  - SPDX-FileCopyrightText: 2009 Dario Freddi <drf@kde.org>
  - SPDX-FileCopyrightText: 2014 David Edmundson <davidedmundson@kde.org>
  - SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
SPDX-License-Identifier: LGPL-2.1-or-later
aliases:
  - /docs/features/kauth/
---

## Privilege Escalation

When writing an application, occasionally we want to access actions that require administrator access. This could include writing some configuration files that are owned by root, editing the system clock, or other administrative tasks.

The obvious solution is to run the entire application as root, but this exposes a lot of potential security problems to the user. We want a way to run the main application as a normal user, yet still be able to authenticate and run small parts as root or another user.

## What is KAuth

KAuth is an authentication framework that acts as a wrapper around lower-level libraries and tools. If you are planning to use KAuth, however, you won't have to care about what authentication system is used by the system you are targeting: KAuth will take care of that on its own.

In addition, KAuth is also able to perform privilege elevation on restricted portions of code (helpers), giving the developer an efficient and easy to use pipes to communicate with them, and making them secure throughout the authorization process.

## Concepts

There are a few concepts to understand when using KAuth. Many of those are carried from underlying APIs such as Polkit, so if you are familiar with one of them you might as well skip this section.

* An `action` is a single task that needs authorization to be performed. Each action has a unique action identifier, which is a string in reverse domain name syntax, like `org.kde.this.is.an.action`. For example, if our application needs to read a file the user has no privileges to, it would need an action like "org.kde.auth.example.read". Please note that each action has to refer to a single task: this allows system administrators to fine-tune the policies that allow users to perform the specified actions, and also provides a more secure way of locking down the privileged actions in your application.

* The "authorization system" is an underlying framework (like Polkit or Authorization Services), which KAuth interfaces with. KAuth's aim is to never make the developer know or care about the underlying authorization system, however in this tutorial series this concept will come up quite often to explain how KAuth works.

* An `action namespace` is the first part of the action identifier. In `org.kde.auth.example.read`, `org.kde.auth.example` is the **action namespace**, `read` is the **action name**. This is a very important concept when dealing with helpers and `.actions` files.

* `Authorization` is a particular phase where the underlying authorization system performs the needed checks (and eventually asks the user for their credentials in order to authorize them). Before any action is executed, the Authorization phase takes place. This is handled internally by KAuth: even if you are able to trigger this phase manually, most of the times you don't need to: KAuth will still execute an action only if the underlying authorization system allows its execution.

* `Authentication` is an **optional** phase that takes place during authorization, if the policy for the action requests the user to input a credential to give them an explicit authorization. This phase is external and not handled by KAuth, but entirely by the underlying authorization system. It is, however, important for you to know something about it even if KAuth has no way to hijack the Authentication phase by design.

* `Execution` happens **only** if the Authorization was successful: the execution might consist in a simple confirmation of the successful authorization, or eventually in the execution of a function in an helper.

* A `Helper` is a separate application running as a privileged user (usually root), which is called upon execution if your action was attached to a helper. KAuth uses a completely transparent approach: IPC between your application and the helper itself is handled internally through an extremely simple API, and you won't even know that the helper is a separate application: spawning, killing and all the process handling is handled by KAuth.

## Phases breakdown

Supposing that you want to use KAuth to perform a privileged operation and the action you are considering requires the user to authenticate (which is the most common use case of KAuth), the break down of phases would be:

* The user wants to perform some privileged task.
* The application creates an action for the task in question.
* The action is requested to be executed.
* The following steps are handed internally, either by KAuth or the underlying authorization system.
* *Authorization phase begins*
* The system detects that the user needs to authenticate to authorize the action.
* *Authentication phase begins*
* The user is requested to input their password, swipe their finger, press a button...
* *Authentication phase ends*
* If authentication was unsuccessful, the action is rejected.
* Otherwise, the system grants an explicit authorization to the user.
* *Authorization phase ends*
* If authorization was unsuccessful, the action is rejected.
* Otherwise, the action is executed.
* *Execution phase begins*
* A separate application is spawned by root, and the requested portion of code is executed.
* The helper code, immediately after starting, checks the authorization again to improve security, and also because some authorization systems delay the authorization phase in the beginning of the execution phase. If the helper is not authorized, the execution is aborted.
* If the caller is authorized, the helper executes the task.
* *Execution phase ends*
* The application receives the result of the execution from the helper.

This is how, concept-proof, KAuth works. However, please note that in your implementation you will have to deal with the pre-authorization phase only, since everything else is handled internally.

## Creating Actions with KAuth

To increase the level of security, authorization systems require to register the actions together with the application installation, so that the authorized actions are all known to the system administrator. This means that if you're using KAuth you probably want to register some new actions in the system.

## Naming actions and namespaces

Many authorization systems are quite strict about action naming, hence staying compatible with all of them is a tricky task. To ensure maximum compatibility with all of them, in both action namespaces and action names, **use only lowercase letters and numbers**. Here comes a small example:

* `org.kde.auth.example.read` **OK**
* `org.KDE.auth.example.read` **NOT OK**
* `org.kde.auth.example-1.read` **NOT OK**
* `org.kde.auth.example.readFile` **NOT OK**
* `org.kde.auth.example.readfile` **OK**

## The basic .actions file

This is done by creating an `.actions` file, which is a standard INI file containing a set of new actions. This file is translatable, and if you're developing your project in KDE's Gitlab's instance, [Invent](https://invent.kde.org), scripty will take care of updating it.

Each `.actions` file can contain an unlimited set of actions, provided that they **belong to the same action namespace**. This is extremely important.

The file has the following format:

```ini
[org.kde.auth.example.action]
Name=Example action
Description=The system is attempting to perform the example action
Policy=auth_admin
Persistence=session
```

The fields are defined as follows:

* **Title**: The action identifier.
* **Name**: A human readable action name.
* **Description**: This message will eventually be displayed to the user during the authentication phase, if any.
* **Policy**: The default policy for this action. It can be one of the following values:
  * `yes`: the action should be allowed without requesting authentication
  * `no`: the action should be always denied, without requesting authentication
  * `auth_self`: the action will be authorized if the user will authenticate as themselves
  * `auth_admin`: the action will be authorized if the user will authenticate as a system administrator
* **Persistence**: this field is optional and takes effect only if the authorization system supports it and **Policy** is either `auth_admin` or `auth_self`. It defines the persistence of the explicit authorization granted by the user through authentication. It can be one of the following values:

  * `session`: the authorization persists until the user logs out.
  * `always`: the authorization will persist indefinitely.

## The Domain field

`.actions` files can have a special group, **[Domain]**, under which you can give out some more information about the action namespace you're defining. This is how it looks (all fields are optional):

```init
[Domain]
Name=The KAuth example series
Icon=kauth-example
URL=https://invent.kde.org/
```

The fields are defined as follows:

* **Name**: Usually the name defining the application that is going to use this namespace.
* **Icon**: An icon name that will be shared among all the actions.
* **URL**: The home page of your organization.

## CMake macros and file format

Once you defined the actions in your file (remember you can define an unlimited number of actions in an `.actions` file, provided that they all belong to the same namespace, for example `org.kde.auth.example.*`), KAuth provides a CMake macro to register the actions in the system. In your `CMakeLists.txt`, supposing your file is named `org.kde.auth.example.actions`, you would do:

```cmake
kauth_install_actions(org.kde.auth.example org.kde.auth.example.actions)
```

This macro has the following syntax:

```cmake
kauth_install_actions(<namespace_id> <actions definition file>)
```

Where `namespace_id` is the namespace where you defined your actions, in this case `org.kde.auth.example`.

