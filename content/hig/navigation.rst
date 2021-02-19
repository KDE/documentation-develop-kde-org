---
title: Navigation
weight: 7
---

Applications are composed of items called "views" "screens" or "pages".
Navigation is how users move between and inside these pages.
It's one of the fundamental parts of your app's design, as it's how users find the content and features they want in your application.
Your users will typically be unaware of it until it doesn't meet their expectations.
As an app developer, your job is to implement navigation in a natural and familiar manner that lives up to user expectations.
In KDE applications, there are two main types of navigation, and many ways to implement them.

Hierarchical Navigation
-----------------------

.. image:: /hig/hierarchy.svg
   :alt: Hierarchical navigation diagram

In hierarchical navigation, users must make one choice per page to go deeper in the hierarchy, until they reach their destination.
Users need to retrace their steps, or in some cases, restart in order to access another page.
System Settings uses this style of navigation.

The Kirigami PageRow is the primary provider of hierarchical navigation in KDE applications; and is integrated into the Kirigami RouterWindow and the Kirigami ApplicationWindow.
Some applications, like Dolphin, use browser-style navigation instead, providing back, forward, and up controls on a single view.

Lateral Navigation
------------------

.. image:: /hig/lateral.svg
   :alt: Lateral navigation diagram

In lateral navigation, users switch between multiple pages, typically representing categories.
Elisa and KClock use this style of navigation.

The `Kirigami SwipeNavigator <docs:kirigami2;PageRow>`_ is the primary provider of lateral navigation in KDE applications; and provides a convergent interface for both desktop and mobile, adapting to various form factors and providing gestures on touch devices.

Composed Navigation
-------------------

.. image:: /hig/composed.svg
   :alt: Composed navigation diagram

Different parts of your application can be composed of different navigation patterns.
For example, Elisa offers lateral navigation as the root navigation scheme of the application, while using hierarchical navigation for traversing the user's filesystem and music library.

Guidelines
----------

Clarity
~~~~~~~

Always provide a clear path to where the user wants to go.
People should always know where they are in your application and how to get to where they want to go.
Spatial consistency is important in navigation; each page should only be accessible from a single path, like how a building can only be in one place.
Multiple ways to access a single page is confusing, especially on mobile, where the only context provided is the current page, meaning users cannot discern which path they took to reach the page if they do not remember how they got there.
If you need to present a single view in multiple contexts, consider using an overlay sheet or a layer instead of using a page.

Ease of Access
~~~~~~~~~~~~~~

Design your app's navigational structures in a manner that requires the minimum amount of clicks, taps, swipes for a user to get to their destination.

Consistency
~~~~~~~~~~~

Whenever possible, use standard navigational controls such as the `Kirigami PageRow <docs:kirigami2;PageRow>`_, the `Kirigami SwipeNavigator <docs:kirigami2;SwipeNavigator>`_, and the QtQuick tab views.
Users already know how to use these controls and will be able to use your app easier than if you use custom controls.
Implementing your own navigational controls is strongly discouraged, as your users will expect your application to use the controls that other applications use.

Fluidity
~~~~~~~~

Navigation should be frictionless as possible.
On desktop, ensure that navigation only requires a single click.
On mobile, navigation should take advantage of gestures, being sure to respect the system gestures, such as the swipe-to-go-back gesture on Android.
The standard Kirigami components for navigation provide a standard set of gestures that users will expect to function in your application.

Notes
-----

Navigation should not be confused with user documents, which are typically presented using an editable tab bar, as opposed to the non-editable nature of navigation controls.
