Checkbox
========

Purpose
-------

A *checkbox* is a control that permits the user to make multiple
selections from a number of options. Checkboxes are used to toggle an
option on or off, or to select or deselect an item. Users make a
decision between two clearly opposite choices, e.g. 'on vs. off', 'apply
vs. don't apply', 'show vs. hide'.

Example
-------

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use checkboxes for non-exclusive options that have clear
   alternatives. Mutually exclusive options should use a set of 
   :doc:`radio buttons <radiobutton>` or a :doc:`combo box <combobox>`.

.. container:: flex

   .. container::

      .. figure:: /img/Ambiguous_Opposite_Bad.qml.png
        :figclass: border

        :iconred:`BAD` |br|
        Do not use a checkbox if the opposite is ambiguous.

   .. container::

      .. figure:: /img/Ambiguous_Opposite_Good.qml.png
        :figclass: border

        :noblefir:`GOOD` |br|
        Using two radio buttons removes the need to guess.


-  For more than five options, use either a :doc:`list view <list>` or the
   :doc:`dual-list pattern <duallist>` in case of multiple selections.
-  Do not use the selection to perform commands.

.. container:: flex

   .. container::

      .. figure:: /img/No_Command_2_Bad.qml.png
        :figclass: border

        :iconred:`BAD` |br|
        Do not use the selection to perform commands.

   .. container::

      .. figure:: /img/No_Command_2_Good.qml.png
        :figclass: border

        :noblefir:`GOOD` |br|         
        Consider using a :doc:`push button <pushbutton>` instead.

Behavior
~~~~~~~~

-  Checking a checkbox should always "enable" an option or change the
   state of an option to "on". Checking a negative or disabling option
   is a double negative and causes confusion and errors.

.. container:: flex

   .. container::

      .. figure:: /img/Checkbox_Enable_Bad.qml.png
        :figclass: border

        :iconred:`BAD`

   .. container::

      .. figure:: /img/Checkbox_Enable_Good.qml.png
        :figclass: border

        :noblefir:`GOOD`

-  Use the mixed state only to indicate that an option is set for some,
   but not all, child objects. Mixed state must not be used to represent
   a third state.

.. image:: /img/Checkbox_Mixed_State.qml.png
   :alt: Example for mixed state.

   
-  Users must not be able to set a mixed state directly.
-  Clicking a mixed state checkbox enables all child objects.
-  Do not use sliding switches in Desktop applications. They only offer
   good user interaction on touch screens, so they should only be used
   in applications for mobile devices.

.. container:: flex

    .. container::

        .. figure:: /img/Checkbox_Switch_Desktop.qml.png

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Checkbox_Switch_Mobile.qml.png

            :noblefir:`GOOD`

Appearance
~~~~~~~~~~

If you are using qt widgets you should use one of Qt's Layout Classes
like , that will take care of lay outing and spacing of your controls.

-  The text of a checkbox is on the right of its tick rectangle, which
   can make it difficult to avoid blank areas on the left side of the
   form. To keep the layout of the form balanced you can use one of the
   following approaches:

   -  Group checkboxes together in the widget column and add a label
      describing the group in the label column.
      
      .. image:: /img/Grouped_checkboxes.qml.png
        :alt: Grouped checkboxes

   -  If all else fails, add a label describing the checkbox on the left
      side of the checkbox, then set the text of the checkbox to
      "Enabled", "On", or similar.
      
      .. image:: /img/Checkbox_separate_label.qml.png
        :alt: Using a separate title label for the checkbox.

-  When options are subordinate to a checkbox (e.g. Audio level can
   only be set if the Activate Audio option is selected), this relation
   should be visualized by indenting the sub-options. There are two
   options to do so:

   -  When you are using a left-aligned checkbox, indent the
      sub-options by using a horizontal spacer of SizeType "Minimum".
      
      .. image:: /img/Suboption_spacer.qml.png
        :alt: Aligning sub-options with a horizontal spacer of SizeType "Minimum".

   -  When you are using a checkbox that is placed right to its label,
      indent the sub-options in the same vertical axis as the checkbox.
      
      .. image:: /img/Suboption_right.qml.png
        :alt: Aligning sub-options with the same vertical axis as the
          checkbox itself.|

-  If activating a choice affects the appearance or the enabled state of
   other controls, place them next to the checkbox (group).
-  Align checkboxes vertically rather than horizontally, as this makes
   them easier to scan visually. Use horizontal or rectangular
   alignments only if they greatly improve the layout of the window.
-  If certain controls in a configuration dialog are only relevant if a
   certain checkbox is checked (i.e. they are dependent controls),
   disable them instead of hiding them if that checkbox is unchecked.

-  Do not separate checkbox and label. Clicking on both the box and the
   label should toggle the option.
   
    .. image:: /img/HIG_Checkbox5.png
        :alt: Separate checkbox and label

-  Do not add line breaks. If necessary place an additional label below
   the checkbox.

.. container:: flex

    .. container::

        .. figure:: /img/Checkbox_Alignment_Bad.qml.png

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Checkbox_Alignment_Good.qml.png

            :noblefir:`GOOD`

-  Label a group of checkbox with a descriptive caption to the top left
   of the group (cf. :doc:`alignment </layout/alignment>`).
-  Create a buddy relation so access keys are assigned.
-  Use :doc:`sentence style capitalization </style/writing/capitalization>` 
   for checkbox items.
-  Do not use ending punctuation (neither dot nor colon) for group
   label.
