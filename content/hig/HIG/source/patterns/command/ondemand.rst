On-Demand Controls
==================

.. container:: intend

   |desktopicon| |mobileicon|

.. container:: flex

   .. container::

      .. image:: /img/Slide_to_reveal.jpg
         :alt:  240px
         :scale: 25 %

   .. container::

      .. image:: /img/Dolphin_hover.png
         :alt:  240px
         :scale: 80 %

When to Use
-----------

Use on-demand controls for actions which directly relate to an element
in a list or a grid, so they can be executed without selecting the element first
(for example deleting or replying to an email right from the list).

How to Use
----------

-  Don't use on-demand controls as the only means to execute an action;
   they are only shortcuts.
-  Don't use more than five (ideally not more than three) actions in
   on-demand controls. If you need more actions, choose a different 
   :doc:`command pattern <index>`.
-  Only use on-demand controls, if the actions are the same for each item.
-  Since the actions don't have a label, don't use the on-demand pattern, 
   if the actions are not clearly identifiable.
   
.. caution::
   Especially if only one action is available, it is often better to show 
   the action directly or have the action as default on the item.


Behavior
---------

|desktopicon| Desktop
~~~~~~~~~~~~~~~~~~~~~

On-demand controls are shown when hovering over the item with the cursor.
A handle can be added to enable touch screen support.
As soon as the user taps anywhere else or the pointer is not any longer 
hovering the item, the on-demand controls are hiden again.



|mobileicon| Mobile
~~~~~~~~~~~~~~~~~~~
On-demand controls are revealed by sliding a handle from right to left
to reveal them. As soon as the user taps anywhere else, the
handle is slid back.


For futher guidelines see :doc:`list item </components/editing/list>`.
