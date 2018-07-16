Slider and spin box
===================

Purpose
-------

:doc:`Spin boxes </components/editing/spinbox>` allow a user to enter a specific
value, and gives users fine control over which value is chosen, 
but are slow when moving over large ranges of values. 
:doc:`Sliders </components/editing/slider>` allow for quickly changing values 
over long ranges, but make it harder to select very specific values. In
cases where both are necessary, combing the two is sometimes a good
approach.

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use both a slider and spin box when the value is constrained at both
   ends, and when there is a large range of values (more than 20 steps)
   but precise control over the value is needed nevertheless.
-  Consider to use only slider *or* spin box if a well defined workflow
   makes the other redundant.

Behavior
~~~~~~~~

-  The values of the slider and spin box should be linked so changes to
   one are immediately reflect in another.
-  Make sure that all requirements from slider and spin box are met.

Appearance
~~~~~~~~~~

-  The spin box should be aligned with the long axis of the slider. So
   if the slider is horizontal, the spin box should be to the right of
   the slider and aligned vertically with the center of the slider. If
   the slider is vertical, the spin box should be below the slider and
   aligned horizontally with the center of the slider.
-  Provide a single label using a text label above it or to the left of
   the widgets, using sentence capitalization. Provide an access key in
   the label that should give focus directly to the spin box.
-  Mark significant values along the length of the slider with text or
   tick marks.
