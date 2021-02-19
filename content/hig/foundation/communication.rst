---
title: Communication
weight: 3
description: Open dialogue between your app and your users ensures they feel in control
---

Purpose
-------

Open communication between your app and your users ensures your app feels responsive.
If your app fails to provide an adequate level of communication, users will perceive it as non-functional, frozen, or buggy.

Guidelines
----------

Ensure that controls acknowledge the user's actions.
For standard controls, this is already built in: buttons respond to being pressed, sliders are dragged directly by the mouse, etc.

For long-running operations, use standard progress controls, such as spinners or loading bars.
Your app should make every attempt possible to communicate to the user how long operations are going to take, or if not possible, show that an operation will take an indeterminate amount of time.

When a user attempts to take a potentially dangerous action, be sure to notify them that the action is dangerous, and give them a chance to back out. Better yet, add the ability to undo dangerous actions.

Provide simple and direct feedback that your users can understand.
Most users cannot understand what "Error code 418" means.
Instead, use feedback in your user's language, and preferably point out the situation that caused the error, so that users can understand how to avoid the situation in the future.

