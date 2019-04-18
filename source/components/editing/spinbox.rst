Spin box
========

.. figure:: /img/Spinbox1.png
   :alt:  Spinbox
   :figclass: border
   
   Control that accepts a range of values.


Purpose
-------

A *spin box* is a line edit that accepts a range of values. It
incorporates two arrow buttons that allow the user to increase or
decrease the current value by a fixed amount. Spins are efficient for
small changes of numeric values in a contiguous range.

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use spin boxes for numerical input only. Use a list or option menu
   when you need the user to select from fixed data sets of other types.
-  Use a spin box if the numerical value is meaningful or useful for the
   user to know, and the valid input range is unlimited or fixed at one
   end only. For example, a control for specifying the number of
   iterations of some action, or a time-out value.
-  If the range is fixed at both ends, or the numerical values are
   arbitrary (for example, a volume control), use a :doc:`Slider <slider>` control
   instead.
-  For cases where the values are constrained at both ends and there
   large ranges of integers (more than about 20) or floating-point
   values that require precise control, consider providing both a
   :doc:`Slider and Spin Box <slider>`. This allows the user to quickly set or
   fine-tune the setting more easily than they could with the slider
   control alone.

Behavior
~~~~~~~~

-  If the input data has a value that is known to be invalid, display an
   input problem hint when the spin edit loses input focus.
-  If the input data is inconsistent with other controls on the window,
   give an error message when the entire input is complete, such as when
   users click OK for a modal dialog box.
-  Don't clear invalid input data unless users aren't able to correct
   errors easily. Doing so allows users to correct mistakes without
   starting over.

Appearance
~~~~~~~~~~

-  Label the spin box with a text label to its left, using sentence
   capitalization.
-  Always append a suffix with the value's unit to the right.
-  Provide an access key in the label that allows the user to give focus
   directly to the spin box.
-  Right-justify the contents of spin boxes, unless the convention in
   the user's locale demands otherwise. This is useful in windows where
   the user might want to compare two numerical values in the same
   column of controls. In this case, ensure the right edges of the
   relevant controls are also aligned.

Code
----

Kirigami
~~~~~~~~

 - `QML: SpinBox <https://doc.qt.io/qt-5/qml-qtquick-controls2-spinbox.html>`_
