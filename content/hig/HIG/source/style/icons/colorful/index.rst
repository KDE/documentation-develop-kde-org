Colorful Icons
==============

.. toctree::
   :caption: Contents:
   :titlesonly:
   :hidden:

   application
   mimetype
   places
   category_preferences

.. image:: /img/Sample_color_icons.png
   :alt: Colorful icons

Colorful icons make full use of the :doc:`Breeze color palette <../../color/index>`. 
Colorful icons are not flat and incorporate elevation, shadows, and lighting.

.. container:: flex

   .. container::

      .. figure:: /img/anjuta-deep.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Use a variety of techniques to give
         your icon depth.

   .. container::

      .. figure:: /img/anjuta-flat.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't make your icon flat - this makes
         it visually bland.

There are a variety of colorful icon types:

-  32px: `Category, Preferences, <category_preferences.html>`_ `MIME type, \
   <mimetype.html>`_ and `Places <places.html>`_ icons
-  48px: `Application <application.html>`_ icons
-  64px: `MIME type, <mimetype.html>`_ `Places, <places.html>`_ Devices, and a
   few `Status <action.html>`_ icons

Margins
~~~~~~~

Vertical
********

Colorful icons have a top and bottom margin of 4 pixels. Icons should not put
any details here whatsoever.

.. figure:: /img/anjuta-margin-horiz.png
   :alt: Anjuta icon showing off 4px top and bottom margins

   Anjuta icon with 4px top and bottom margins. 
   The icon does not enter the margins.

Horizontal
**********
Colorful icons also have a left and right margin of 4 pixels. Minor details can
extend here as necessary.

.. figure:: /img/anjuta-margin-vert.png
   :alt: Anjuta icon showing off 4px left and right margins

   Anjuta icon with 4px left and right margins.
   The circle's edges extend into the margin.

32px Colorful Icons
********************
32px colorful icons have a 2px margin instead of 4px margins.

.. container:: flex

   .. container::

      .. figure:: /img/small-margin-do.png
         :figclass: do

         :noblefir:`Do.` |br|
         Use 2px margins on 32px colorful icons.

   .. container::

      .. figure:: /img/small-margin-dont.png
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't use 4px margins on 32px colorful icons;
         this reduces the canvas size too much.

Anatomy
~~~~~~~
All colorful icons share the same basic anatomy.

.. figure:: /img/anjuta-anatomy.png
   :alt: Annotated Anjuta icon with parts of icon anatomy labelled.

1. Foreground
2. Foreground Shadow
3. Base
4. Base Shadow

.. container:: flex

   .. container::

      .. figure:: /img/anjuta-foreground.png

         The foreground of an icon is the distinctive
         part that conveys the most branding.

   .. container::

      .. figure:: /img/anjuta-foreground-shadow.png

         Foregrounds on a background
         have a 45° shadow to the bottom right that 
         spans the entire background.

.. container:: flex

   .. container::

      .. figure:: /img/anjuta-background.png

         Icons can have a background to serve as a base for
         their foreground.

   .. container::

      .. figure:: /img/anjuta-background-shadow.png

         The foreground, or the background if there is one,
         has a 1px hard shadow on the bottom.

Elements
~~~~~~~~

Color
*****

Icons can have a variety of shapes, which when combined with color,
produce numerous unique arrangements.

.. container:: flex

   .. container::

      .. figure:: /img/color-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Color can be used to add variety to
         an otherwise bland surface.

   .. container::

      .. figure:: /img/color-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't give color shadows; color is not
         shape and should not be treated as such.

Layers
******
Icons are composed of layers that cast shadows.

.. container:: flex

   .. container::

      .. figure:: /img/layer-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Give icons at most two or three major layers.

   .. container::

      .. figure:: /img/layer-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't give icons too many layers.

Lighting and Shadows
********************

Ambient Lighting
++++++++++++++++
Icon fills should reflect ambient lighting—go from a lighter top to a darker
bottom.

.. container:: flex

   .. container::

      .. figure:: /img/lighting-gradient-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Do have gradients behave like
         light is coming from above the icon.

   .. container::

      .. figure:: /img/lighting-gradient-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't have gradients behave like light
         is coming from below the icon.

Hard Shadow
+++++++++++
Every icon should have a 1px solid hard shadow. A good baseline color to overlay is 10% black (#000000).

.. container:: flex

   .. container::

      .. figure:: /img/hardshadow-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Add a 1px hard shadow
         to give your icon depth.

   .. container::

      .. figure:: /img/hardshadow-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't forego a hard shadow;
         this makes your icon seem flat.

45° Shadows
+++++++++++
Foregrounds should have a 45° shadow to the bottom right.

.. container:: flex

   .. container::

      .. figure:: /img/45shadow-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Objects are solid, and block
         shadows from passing through.

   .. container::

      .. figure:: /img/45shadow-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't have shadows pass through
         objects; they are not glass.

.. container:: flex

   .. container::

      .. figure:: /img/bound-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         45° shadows are bounded
         to their parent elements.

   .. container::

      .. figure:: /img/bound-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         45° shadows should not
         exceed the bounds of their
         parents.

.. container:: flex

   .. container::

      .. figure:: /img/gradient-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         45° shadows have a gradient
         that fades out before they hit
         an edge.

   .. container::

      .. figure:: /img/gradient-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         45° shadows are not solid
         and do not extend to the edge
         of their parents.