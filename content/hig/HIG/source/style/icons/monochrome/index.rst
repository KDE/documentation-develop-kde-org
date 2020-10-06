Monochromatic Icons
===================

.. toctree::
   :caption: Contents:
   :titlesonly:
   :hidden:

   action
   emblem
   mimetype
   places
   status

* :doc:`action`
* :doc:`emblem`
* :doc:`mimetype`
* :doc:`places`
* :doc:`status`

.. image:: /img/HIGMonoIcons.png
   :alt: Monochrome icons

Monochrome icons come in two sizes: 16px and 22px. 16px monochrome icons are
commonly seen in menu items, tabs, and push buttons that have a raised,
buttonlike appearance. 22px monochrome icons are used in ToolButtons. Monochrome
icons at both sizes are used to represent small file types and entries in the
Places panel in Dolphin and file dialogs.

Don't use the monochrome style for larger icon sizes.

The Monochrome style is used for `Action <action.html>`_, Status,
small `Places, <places.html>`_ and small `MIME type <mimetype.html>`_ icons.


Colors
~~~~~~
The monochrome style relies on distinct shapes and outlines instead of fine
details and vibrant colors, and employs an intentionally limited color palette:

.. container:: flex

   .. container::

      .. figure:: /img/Shade-Black.png
         :scale: 85%

         Color for non-destructive actions and states:
         navigation, acceptance, etc. 

   .. container::

      .. figure:: /img/Icon-Red.png
         :scale: 85%

         Color for destructive actions and states:
         delete, remove, error, etc.

.. container:: flex

   .. container::

      .. figure:: /img/Beware-Orange.png
         :scale: 85%

         Color for warning actions and states:
         warning, unsure, user interaction, etc.

   .. container::

      .. figure:: /img/Plasma-Blue.png
         :scale: 85%

         Color for manipulative actions and states:
         selection, insertion, focus feedback, etc.

.. container:: flex

   .. container::

      .. figure:: /img/Noble-Fir.png
         :scale: 85%

         Color for successful actions and states:
         completion, connection, security, etc.

Margins and alignment
~~~~~~~~~~~~~~~~~~~~~
16px monochrome icons should not use the top or bottom 2 pixels, and 22px
monochrome icons should not use the top or bottom 3 pixels:

.. container:: flex

   .. container::

      .. figure:: /img/margins-16.png
         :scale: 85%

         2px margins for a 16px icon.

   .. container::

      .. figure:: /img/margins-22.png
         :scale: 85%

         3px margins for a 22px icon.

It is recommended to keep monochrome icons perfectly square. For some types of 
icons described later (e.g. Places icons) this is a hard requirement.

Because monochrome icons are so small and simple, it is important that they be
pixel-perfect, with their lines and objects aligned to a regular grid:

.. container:: flex

   .. container::

      .. figure:: /img/pixel-align-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Make sure your icon is aligned 
         to the pixel grid—use grids and guides
         to assist you when designing it.

   .. container::

      .. figure:: /img/pixel-align-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't misalign your icon to the pixel
         grid—this makes it look blurry when
         scaled and can make it look wonky.

Adding Emblems to monochrome icons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Because monochrome icons usually depict actions, many include status or action
emblems. These are always located in the bottom-right corner. The emblem should
be a minimum of 5px wide and tall, and there must be 1px of blank space between
the emblem and the rest of the icon.

.. container:: flex

   .. container::

      .. figure:: /img/emblem-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Clear out some space for your 
         icon's emblem.

   .. container::

      .. figure:: /img/emblem-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't overlay your icon's emblem
         on its corner.