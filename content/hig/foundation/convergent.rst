---
title: Convergence
weight: 5
description: One of the most notable features of modern KDE apps is convergence
---

Purpose
-------

Convergence is an extension of `consistency <consistency.html>`_.
Convergent applications provide just enough consistency between different platforms and allow users to bring their skills with them from one platform to another.
Users enjoy not having to learn different apps for different platforms.

Guidelines
----------

Use standard convergent controls in your application.
For KDE applications, this typically means using Kirigami's controls, such as the ApplicationWindow/RouterWindow + Pages, or the SwipeNavigator + pages.
Using custom controls is especially discouraged for convergent applications, as there is much more difficulty in implementing convergent patterns, and custom ones can easily go wrong.

Ensure that your application's core features can be used on all platforms.
While different platforms don't require feature parity (and implementing it can be unfeasible), the core of your application should still be recognisable.

Don't implement radically different UIs for mobile and desktop: your UIs should be the same patterns expressed with platform-specific affordances, and stock Kirigami components provide this out of the box.
