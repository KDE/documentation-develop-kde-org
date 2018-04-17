Radio button
============

Purpose
-------

*Radio buttons* offer the user a choice of two or more mutually
exclusive options. Try to limit the number of radio buttons and radio
button groups in a dialog. Offering a high number of radio buttons
consumes screen space and adds to visual clutter. At the same time,
showing all available options at once is an advantage if users are
likely not to know possible alternatives.

Examples
--------

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use radio buttons for a few mutually exclusive options. If there are
   more than five options (or if there is not enough space to arrange
   four or five options), use a combo box or list instead.

.. container:: flex

    .. container::

        .. figure:: /img/Radiobutton_Many_Bad.qml.png
            :figclass: border

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Radiobutton_Many_Good.qml.png
            :figclass: border

            :noblefir:`GOOD`


-  If there are only two options where one is the negation of the other
   (e.g. "apply" vs. "do not apply"), consider replacing the radio
   buttons by one :doc:`check box <checkbox>`.
   
.. container:: flex

    .. container::

        .. figure:: /img/Radiobutton_Negation_Bad.qml.png
            :figclass: border

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Radiobutton_Negation_Good.qml.png
            :figclass: border

            :noblefir:`GOOD`

-  Use radio buttons if the user should see the choices without further
   interaction.

.. container:: flex

    .. container::

        .. figure:: /img/Radiobutton_Visible_Bad.qml.png
            :figclass: border

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Radiobutton_Visible_Good.qml.png
            :figclass: border

            :noblefir:`GOOD`

-  Do not use a radio button to initiate an action. Consider using a
   :doc:`push button <pushbutton>` instead.

.. container:: flex

    .. container::

        .. figure:: /img/Radiobutton_Command_Bad.qml.png
            :figclass: border

            :iconred:`BAD` |br|
            Do not use the selection to perform commands.

    .. container::

        .. figure:: /img/No_Command_2_Good.qml.png
            :figclass: border

            :noblefir:`GOOD` |br|
            Consider using a :doc:`push button <pushbutton>`.

Behavior
~~~~~~~~

-  Radio buttons are not dynamic; their content or labels should not
   change depending on the context.
-  Always have one radio button selected.

.. container:: flex

    .. container::

        .. figure:: /img/Radiobutton_Default_Bad.qml.png
            :figclass: border

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Radiobutton_Default_Good.qml.png
            :figclass: border

            :noblefir:`GOOD`

-  Make the first item the default option.

.. container:: flex

    .. container::

        .. figure:: /img/Radiobutton_First_Bad.qml.png
            :figclass: border

            :iconred:`BAD`

    .. container::

        .. figure:: /img/Radiobutton_First_Good.qml.png
            :figclass: border

            :noblefir:`GOOD`

-  When using a radio button and none of the options is a valid choice,
   add another option to reflect this choice, such as None or Does not
   apply.

Appearance
~~~~~~~~~~

If you are using qt widgets you should use one of Qt's Layout Classes
like , that will take care of lay outing and spacing of your controls.

-  When options are subordinate to a radio box, this relation should be
   visualized by indenting the sub-options by using a horizontal spacer
   of SizeType "Minimum".

-  If activating a choice affects the appearance or the enabled state of
   other controls, place them next to the radio button (group).
-  Align radio buttons vertically rather than horizontally, as this
   makes them easier to scan visually. Use horizontal or rectangular
   alignments only if they greatly improve the layout of the window.
-  If certain controls in a configuration dialog are only relevant if a
   certain radio button is toggled on (i.e. they are dependent
   controls), disable them instead of hiding them if that radio button
   is toggled off.

-  Do not separate radio button and label. Clicking on both the button
   and the label should toggle the option.
-  Do not add line breaks. If necessary place an additional label below
   the check box.
-  Label a group of radio buttons with a descriptive caption to the top
   left of the group (cf. :doc:`alignment </layout/alignment>`).
-  Create a buddy relation so access keys are assigned.
-  Use :doc:`sentence style capitalization </style/writing/capitalization>` for radio buttons.
-  Do not use ending punctuation (neither dot nor colon) for group
   label.
