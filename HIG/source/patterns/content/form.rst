Form
====

A form layout is used to help align and structure a layout containing many
control and input fields.

When to Use
-----------

-  Use a Form layout when there are many related controls and input fields.
-  Form layouts are ideal for :doc:`settings dialogs </patterns/content/settings>`.

How to Use
----------

-  On |desktopicon| Desktop it is recommended to place the labels to the left
   of the connected widgets. Labels that are to the left of their connected
   widgets should be right-aligned and end with a colon (in case of
   right-to-left languages, mirror the alignment). This makes the whole group
   of form widgets appear to be center-aligned. In Qt 5, using a QFormLayout handles all of this for you automatically.
-  See the pages on
   :doc:`radio buttons </components/editing/radiobutton>` and 
   :doc:`checkboxes </components/editing/checkbox>` for detailed information
   regarding how to align these tricky controls in a Form layout.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_KDE3.qml.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't use KDE3-style form alignment

   .. container::

      .. figure:: /img/Form_Align_KDE5.qml.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Use Plasma 5-style form alignment.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_OSX.qml.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br| 
         Don't use macOS-style form alignment.

   .. container::

      .. figure:: /img/Form_Align_KDE5.qml.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Use Plasma 5-style form alignment.

-  Position groups of items vertically rather than horizontally, as this
   makes them easier to scan visually. Use horizontal or rectangular
   positioning only if it would greatly improve the layout of the window.
-  Left align controls over multiple groups. This visual anchor facilitates
   scanning of content, and left-hand alignment fits as well forms that
   have been oversized individually.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_NO.qml.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't misalign controls.

   .. container::

      .. figure:: /img/Form_Align_YES.qml.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Align controls to the left.

-  Keep track of label sizes; avoid big differences in text length that could
   result in too much whitespace for multiple aligned controls. Keep
   translation in mind too; existing length differences will be exaggerated
   for wordy languages such as German and Brazilian Portuguese.

   .. figure:: /img/Form_Align_Long.qml.png
      :scale: 80%
      :figclass: dont

      :iconred:`Don't.` |br|
      Don't use very long captions.

-  For |mobileicon| mobile, or if only narrow space is available, it is
   recommended to place the labels above the connected widgets.
-  When using labels on top, labels and widgets should be left-aligned.

.. image:: /img/Form_Align_YES_Mobile.qml.png
         :scale: 80%

