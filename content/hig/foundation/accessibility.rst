---
title: Accessibility
weight: 1
description: Accessible apps allow users of diverse abilities to understand and use them
---

Purpose
-------

Building accessibility into your app is important to allow users of diverse abilities to use your application.
Not only does it expand the userbase your app can empower, focusing on accessibility makes your application more usable for all users, not just ones with disabilities.

Assistive Technology
--------------------

Assistive technologies like screen readers, magnifiers, and hearing aids help users with disabilities using your application.

Screen Readers
~~~~~~~~~~~~~~

Screen readers are programs that read screen contents aloud or renders content on braille displays.
They rely on applications to use components with correct semantics, and filling in accessibility information when using custom components.

Screen readers have two main modes of usage, and your application should be able to work well with both.

Touch Exploration
^^^^^^^^^^^^^^^^^

In touch exploration, users drag their fingers over a touch screen, and the screen reader will read content below their fingers out loud.
Users can also build muscle memory by remembering where on the screen key UI components are.

When designing your UI for touch exploration users, be sure to

* Keep landmark UI elements in a consistent place: relearning where UI elements are is substantially slower for blind users than for seeing users
* Keep UI elements large enough to have room for dragging the finger over them: touch exploration typically requires the finger to be dragged over the UI control; simply tapping the control will not cause touch exploration to happen

Linear Navigation
^^^^^^^^^^^^^^^^^

In linear navigation, users use forwards, backwards, and "interact" actions in order to navigate through a UI.
Linear navigation strongly correlates to, but is not keyboard navigation-linear navigation will cover UI elements typically not covered by keyboard navigation.

When designing your UI for linear navigation users, be sure to:

* Provide efficient linear access to all app features and content
* Ensure that keyboard access does not conflict with system keyboard gestures
* Provide linear equivalents to all mouse-driven features, including item selection and movement
* Ensure that linear forwards and backwards navigation does not trigger actions

Contrast
~~~~~~~~

Contrast is important for users to be able to discern your app's contents.

When designing for good contrast, be sure to:

* Use colors from the user's color scheme
* Use colors only as an additional way of conveying information, not as the only way
* Use sufficiently large text, and use system font metrics so that users can adjust fonts to their need

Audio
~~~~~

Apps should seldom if ever make use of audio that does not directly relate to content, such as a video or a user's music library.

However, when using audio, ensure that:

* Audio is not the only way to receive information
* Users can modify or disable the audio to their needs
