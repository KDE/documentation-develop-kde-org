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


Labels on the left
~~~~~~~~~~~~~~~~~~

On |desktopicon| Desktop it is recomended to place the labels to the left
of the connected widgets.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_KDE3.qml.png
         :scale: 80%

         :iconred:`BAD` |br|
         KDE3 form alignment

   .. container::

      .. figure:: /img/Form_Align_KDE5.qml.png
         :scale: 80%

         :noblefir:`GOOD` |br|
         Plasma 5 form alignment

-  The labels that are to the left of their connected widgets should be right-aligned.
   This makes the whole group of form widgets appear to be center-aligned.
   In Qt5, using a QFormLayout handles this correctly for you.

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
         :scale: 80%

         :iconred:`BAD` |br| 
         OSX form alignment

   .. container::

      .. figure:: /img/Form_Align_KDE5.qml.png
         :scale: 80%

         :noblefir:`GOOD` |br|
         Plasma 5 form alignment

-  Left align controls over multiple groups (in case of right-to-left
   languages mirror the alignment). The visual anchor facilitates
   scanning of content, and left-hand alignment fits as well forms that
   have been oversized individually.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_NO.qml.png
         :scale: 80%

         :iconred:`BAD` |br|
         no alignment over controls

   .. container::

      .. figure:: /img/Form_Align_YES.qml.png
         :scale: 80%

         :noblefir:`GOOD` |br|
         left aligned controls

-  Keep track on label size; avoid big differences in text length (even
   after translation), that could result in much whitespace for
   multiple aligned controls.

   .. figure:: /img/Form_Align_Long.qml.png
      :scale: 80%

      :iconred:`BAD` |br|
      Avoid very long captions

Labels on top
~~~~~~~~~~~~~

For |mobileicon| mobile, or if only narrow space is available, it is
recomended to place the labels above the connected widgets.

.. image:: /img/Form_Align_YES_Mobile.qml.png
         :scale: 80%

-  Labels and widgets align left
-  Minimize label length. Avoid multi-line labels.

Checkboxes and Radio buttons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For more details on alignment of 
:doc:`radio buttons </components/radiobutton>` and 
:doc:`checkboxes </components/checkbox>`, see the detailed HIG pages.
