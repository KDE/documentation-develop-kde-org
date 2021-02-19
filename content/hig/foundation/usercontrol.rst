---
title: User Control
weight: 6
description: Apps should provide users with control, and should not dictate what the user does
---

Purpose
-------

User control is a core component of `accessibility <accessibility.html>`_ and `communication <communication.html>`_, as well as being an important thing on its own.
Giving your users control over your application is important: your applications are the tool, not the smith.

Guidelines
----------

Your application should be driven by the user your app should not initiate action, your user should
Additionally, don't restrict users to reacting to a limited set of actions that are deemed "good" for the user or "protect" the user from making complex decisions.
Striking a balance between giving your users the tools they need and ensuring destructive actions aren't unwillingly performed is key to a good level of user control.
Instead of removing dangerous actions, guard them with warnings (usually in the form of a confirmation dialog), and preferably add a way to back out of them if the user realises they do not want to perform them.

User control also involves allowing the user to adapt the application to their needs.
This means respecting system standard settings that the user can configure to their needs, for starters.
Adding additional application-specific configuration is useful as well, especially in regards to the toolbar configuration of an application.
Different users have different tools they want to use in an application, and allowing them to select which ones to see and which ones to hide provides your user with control.
