Alignment
=========

Purpose
-------

One of the most important aspects of presentation is *alignment* and
*placement* of controls. Its theoretical foundation is based on Gestalt
psychology. Human perception tends to order experience in a manner that
is regular, orderly, symmetric, and simple. Visual impression is
generated to an emergent whole based on several principles, called
Gestalt laws. Two basic laws are:

-  Law of proximity: an assortment of objects that are close to each
   other are formed into a group
-  Law of similarity: objects will be perceptually grouped together if
   they are similar to each other

Placement of controls should be carefully done according to Gestalt
theory.

Guidelines
----------

Labels
~~~~~~

-  Align labels to the right and connected widgets to the left, making a
   group of form widgets appear to be center aligned. In Qt5, using a
   QFormLayout handles this correctly for you.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_KDE3.qml.png

         *BAD*
         KDE3 form alignment

   .. container::

      .. figure:: /img/Form_Align_KDE5.qml.png

         *GOOD*
         Plasma 5 form alignment

Controls
~~~~~~~~

-  Align groups of items vertically rather than horizontally, as this
   makes them easier to scan visually. Use horizontal or rectangular
   alignments only if they greatly improve the layout of the window.
-  Align a group of widgets to the left. This makes use of space more
   efficiently.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_OSX.qml.png

         *BAD*
         OSX form alignment

   .. container::

      .. figure:: /img/Form_Align_KDE5.qml.png

         *GOOD*
         Plasma 5 form alignment

-  Left align controls over multiple groups (in case of right-to-left
   languages mirror the alignment). The visual anchor facilitates
   scanning of content, and left-hand alignment fits as well forms that
   have been oversized individually.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_NO.qml.png

         *BAD*
         no alignment over controls

   .. container::

      .. figure:: /img/Form_Align_YES.qml.png

         *GOOD*
         left aligned controls

-  Keep track on label size; avoid big differences in text length (even
   after translation), that could result in much white space for
   multiple aligned controls.

   .. figure:: /img/Form_Align_Long.qml.png

      *BAD*
      Avoid very long captions

-  In some cases it may be useful to visually separate groups of related
   options within one group box to facilitate scanning of the dialog. In
   that case, put a vertical, fixed-size spacer of 16px height between
   the options.

.. figure:: /img/Form_Align_Space.qml.png
   :alt: Separating groups of related options with a vertical spacer.

   Separating groups of related options with a vertical spacer.

Check boxes and Radio buttons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For more details on alignment of :doc:`radio buttons </controls/radio>` and :doc:`checkboxes </controls/checkbox>` see the detailed HIG pages.
