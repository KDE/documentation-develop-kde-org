Form
====

A form layout is used to help align and structure a layout that contains many
controls and input fields.

When to Use
-----------

-  Use a Form layout when there are many related controls and input fields.
-  Form layouts are often used for :doc:`settings </plattform/settings>`.

How to Use
----------

-  Use Qt's QFormLayout or Kirigami.FormLayout wherever possible.
-  Do not synthesize your own FormLayout-style layout using a grid.

.. attention::
   |devicon| If for some reason you must create your own FormLayout style layout
   without using one of the aforementioned controls, there are several very
   important things to take into account for 
   :doc:`accessibility </accessibility/index>` reasons""
   
   - Form labels need to be connected with input fields.
   - Headlines for groupings need to be connected.
   - Make sure to test keyboard navigation with the form.
   - Ctrl + Tab should switch between logical groups of controls.
   - Make sure to set the focus to focused controls; don't just highlight them.


Alignment
^^^^^^^^^

|desktopicon| Desktop
"""""""""""""""""""""

-  On  Desktop it is recommended to place the labels to the left
   of the connected widgets. Labels that are to the left of their connected
   widgets should be right-aligned and end with a colon (in case of
   right-to-left languages, mirror the alignment). This makes the whole group
   of form widgets appear to be center-aligned. In Qt 5, using a QFormLayout 
   handles all of this for you automatically.



-  See the pages on
   :doc:`radio buttons </components/editing/radiobutton>` and 
   :doc:`checkboxes </components/editing/checkbox>` for detailed information
   regarding how to align these tricky controls in a Form layout.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_KDE3.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't use KDE3-style form alignment

   .. container::

      .. figure:: /img/Form_Align_KDE5.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Use Plasma 5-style form alignment.

.. container:: flex

   .. container::

      .. figure:: /img/Form_Align_OSX.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br| 
         Don't use macOS-style form alignment.

   .. container::

      .. figure:: /img/Form_Align_KDE5.png
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

      .. figure:: /img/Form_Align_NO.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't misalign controls.

   .. container::

      .. figure:: /img/Form_Align_YES.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         Align controls to the left.

-  Keep track of label sizes; avoid large differences in text length that could
   result in too much whitespace. Keep translation in mind too; existing length
   differences will be exaggerated for wordy languages such as German and
   Brazilian Portuguese.

   .. figure:: /img/Form_Align_Long.png
      :scale: 80%
      :figclass: dont

      :iconred:`Don't.` |br|
      Don't use very long captions.


|mobileicon| Mobile and narrow space
""""""""""""""""""""""""""""""""""""

-  For mobile, or if only a very small amount of horizontal space is available,
   it is recommended to place the labels above the connected widgets.
-  When using labels on top, labels and widgets should be left-aligned.

.. image:: /img/Form_Align_YES_Mobile.png
         :scale: 80%


Spacing and Grouping
^^^^^^^^^^^^^^^^^^^^

Use :doc:`spacing </layout/metrics>` to group and separate controls in your 
forms.

.. figure:: /img/Form3.png

   Spacing used to create three groups of controls

Alternatively, you can use separators for a stronger separation.

.. figure:: /img/Form4.png

   Using a separator to group controls
   
Code
----

Kirigami
~~~~~~~~

 - :kirigamiapi:`Kirigami: FormLayout <FormLayout>`


.. literalinclude:: /../../examples/kirigami/FormLayout.qml
   :language: qml
