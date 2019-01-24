Swipe list item
===============

Purpose
-------

This uses an :doc:`on-demand pattern </patterns/command/ondemand>` as
alternative to always visible controls in lists. If the user
often performs tasks on single items of a list, add a handle on the side
the list item (next to the context drawer's edge, defined by a
system-wide configuration) which.

Example
-------

.. image:: /img/Slide_to_reveal.jpg
   :alt:  Slide to reveal actions
   :scale: 30 %

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  See :doc:`on-demand pattern </patterns/command/ondemand>` for
   general recomendations.
-  |desktopicon| If only one action is available, most the time it's better 
   to not use the on-demand pattern, but show the action right away.

Behavior
~~~~~~~~

|desktopicon| Desktop
"""""""""""""""""""""

.. image:: /img/desktop-listview.png
   :alt:  Hover to reveal
   :scale: 60 %

On-demand controls are shown when hovering over the item with the cursor.
A handle is shown to support devices with touch screens. Swiping the handle 
right to left reveals the actions. 
As soon as the user taps anywhere else or the pointer is not any longer 
hovering the item, the handle is slid back.

|mobileicon| Mobile
"""""""""""""""""""

.. raw:: html

   <video src="https://cdn.kde.org/hig/video/20181031-1/Swipelistitem1.webm" 
   loop="true" playsinline="true" width="320" controls="true" 
   onended="this.play()" class="border"></video>

On-demand controls are revealed by sliding a handle from right to left
to reveal them. As soon as the user taps anywhere else, the
handle is slid back.

Appearance
~~~~~~~~~~

|desktopicon| Desktop
"""""""""""""""""""""

   .. figure:: /img/Listview3.png
      :alt: Default padding of an item
      :scale: 60 %
      :figclass: border
      
      Default padding of a swipelistitem on desktop

Items have a padding of :doc:`Units.smallSpacing </layout/units>` to the top 
and bottom and a padding of :doc:`2 * Units.smallSpacing </layout/units>` at 
the left.

   .. figure:: /img/Listview4.png
      :alt: Label is vertical center aligned
      :scale: 60 %
      :figclass: border
      
      Label is vertical center aligned

Labels are vertical center aligned to the item. If you have an icon in 
the item, add a :doc:`2 * Units.smallSpacing </layout/units>` margin between 
the icon and the label.


|mobileicon| Mobile
"""""""""""""""""""

   .. figure:: /img/Listview1.png
      :alt: Default padding of an item
      :scale: 60 %
      :figclass: border
      
      Default padding of a swipelistitem on mobile

Items have a padding of :doc:`Units.largeSpacing </layout/units>` to the top 
and bottom and a padding of :doc:`2 * Units.largeSpacing </layout/units>` at 
the left.

   .. figure:: /img/Listview2.png
      :alt: Label is vertical center aligned
      :scale: 60 %
      :figclass: border
      
      Label is vertical center aligned

Labels are vertical center aligned to the item. If you have an icon in 
the item, add a :doc:`2 * Units.largeSpacing </layout/units>` margin between 
the icon and the label.
