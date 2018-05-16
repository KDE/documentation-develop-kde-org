Swipe list item
===============

When to use
-----------

This uses an :doc:`on-demand pattern </patterns/navigation/ondemand.rst>` as
alternative to always visible controls in lists. If the user
often performs tasks on single items of a list, add a handle on the side
the list item (next to the context drawer's edge, defined by a
system-wide configuration) which.

Example
-------

.. image:: /img/Slide_to_reveal.jpg
   :alt:  Slide to reveal actions
   :scale: 30 %

How to use
----------

-  See :doc:`on-demand pattern </patterns/navigation/ondemand.rst>` for
   general recomendations.
-  |desktopicon| If only one action is available, most the time it's better 
   to not use the on-demand pattern, but show the action right away.

Behavior
---------

The item slides only as far as needed, so the user has a visual hint 
which item is swiped.

|desktopicon| Desktop
~~~~~~~~~~~~~~~~~~~~~

.. image:: /img/desktop-listview.png
   :alt:  Hover to reveal
   :scale: 80 %

On-demand controls are shown when hovering over the item with the cursor.
A handle is shown to support devices with touch screens. Swiping the handle 
right to left reveals the actions. 
As soon as the user taps anywhere else or the pointer is not any longer 
hovering the item, the handle is slid back.

|mobileicon| Mobile
~~~~~~~~~~~~~~~~~~~

.. image:: /img/mobile-listview.png
   :alt:  Hover to reveal
   :scale: 80 %

On-demand controls are revealed by sliding a handle from right to left
to reveal them. As soon as the user taps anywhere else, the
handle is slid back.
