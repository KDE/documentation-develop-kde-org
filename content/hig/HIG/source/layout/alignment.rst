Alignment
=========

Purpose
-------

One of the most important aspects of presentation is *alignment* and
*placement* of objects. Its theoretical foundation is based on `Gestalt psychology <https://en.wikipedia.org/wiki/Gestalt_psychology>`_: 
Human perception tends to order experience in a manner that
is regular, orderly, symmetric, and simple. Visual impression is
generated to an emergent whole based on several principles, called
Gestalt laws. Two basic laws are:

-  Law of proximity: an assortment of objects that are close to each
   other are formed into a group
-  Law of similarity: objects will be perceptually grouped together if
   they are similar to each other

Placement of objects should be carefully done according to Gestalt
theory.

.. raw:: html

   <video src="https://cdn.kde.org/hig/video/20180620-1/Alignment1.webm" loop="true" playsinline="true" width="536" controls="true" onended="this.play()" class="border"></video>

Principles
----------
Alignment pertains to the common-sense usage of visual positioning 
of text, images, controls in user interfaces. Alignment is an element of 
visual design that is easy to miss when done properly and easy to spot 
when it is not. Plasma seeks to achieve strong visual alignment in 
applications so that users don't have to wonder where elements on a page
should go. Plasma seeks simplicity in alignment first.

Alignment in Plasma is:
-----------------------

-  Simple: good alignment improves visual understanding and speed, and allows
   less thinking.  Developers should strive to run alignment that is reduced 
   to a minimum and build more of the UI from there on.

-  Coherent: Users will see elements aligned in a way that follows common, 
   natural, human-like behavior. This can be likened to taking notes. Titles
   will go first, then sub-headings, etc. The objective is that ideas follow
   a natural progression. Developers must prioritize their UI to meet these
   ideas.

-  Reliable: Users will expect elements to be aligned the same across
   multiple applications. Users will come to expect that similar elements 
   are grouped in a predictable fashion.

-  Powerful: Users will expect powerful controls close together that will
   allow them to complete complex operations with only a few clicks and low
   visual travel of the UI to locate such controls.

General Alignment
-----------------

-  Guides and Margins |br|
   In Plasma, alignment behaves like most with a horizontal, vertical, top,
   bottom, and center guides. As developers look to place controls or UI
   elements on their applications, they must set their guides or margins first.

-  Limits |br|
   Using the note paradigm for aligning elements, developers should not go more
   than 3 layers with left justification. Beyond 3 layers seems messy and less
   clear to the user.

:noblefir:`Do:`
^^^^^^^^^^^^^^^

Title
  Label
     Sub-label

*Limit hierarchy to three levels or less.*

:iconred:`Don't:`
^^^^^^^^^^^^^^^^^

Title
   Label
      Sub-label
         Sub-label
            Sub-label

*Don't use more than three levels of hierarchy.*

This same structure should apply to controls.

A General Note of Caution
-------------------------

When working with elements on a page and text, it is tempting to maximize
the use of space by placing as many controls and labels as possible within
the UI. The Plasma team recommends that you first:

-  Organize your controls 
-  Prioritize them 
-  Remove redundancy

And then work in the fashion previously suggested using verticality for
your controls. If your controls don't fit on one page because of the
vertical alignment chosen, consider options such as:

-  Using Tabs
-  Create an "Advanced" window with extra controls
-  Split your UI into smaller groups and categories

This should be done in order to preserve alignment conventions.
