Combo box
=========

Purpose
-------

A *combo box* is a combination of a drop-down list and an edit control,
thus allowing users to enter a value that isn't in the list. It behaves
like a drop-down list and allows the user to choose from a list of
existing items but adds the option to type a value directly into the
control. Newly typed items are usually added to the list and can be
selected next time. Combo boxes are typically applied to provide
auto-complete or auto-type functionality in a convenient way to the
user.

The list provides auto-complete feature for the whole string,
independently of the "editable" property. Given the items of "bike",
"boat", and "car":

-  If one types "b", the list selects "bike".
-  If one (rapidly) types "bo", it selects "boat".
-  If one types "c", it selects "car".

The input field of the combo box ("editable" is true) marks the
completed part of the item as selected, making it easy to change the
completion.

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use a combo box for single selection of one out of many items of
   lists that can be extended by the user. Prefer a simple :doc:`drop-down list <dropdown>` in case of read-only interaction.
-  Consider to replace the combo box by a :doc:`list view <list>` with a connected :doc:`edit control <editcontrol>`.

Behavior
~~~~~~~~

-  Show a maximum of eight items at once.
-  When possible apply changes immediately but do not initiate an action
   (like print, send, delete) when the user selects an item from the
   list.
-  Do not add controls to the drop-down (e.g. check boxes for each
   item).
-  Place options that represent general options (e.g. all, none) at the
   beginning of the list.
-  Sort list items in a logical order. Make sure sorting fits
   translation.
-  Make sure the items are easily accessible via keyboard by moving
   distinctive letters to the beginning of each option. For example, in
   a list of countries on continents, write "Germany (Europe)" instead
   of "Europe/Germany".
-  Do not have blank list items; use meta-options, e.g. (None) instead

Appearance
~~~~~~~~~~

-  Combo boxes are distinguished visually from drop-down lists (normally
   by the raised or lowered bevel). Do not override the common
   processing, e.g. by using a combo box and making it read only in
   order to simulate a simple drop-down list.
-  If activating a choice affects the appearance or the enabled state of
   other controls, place them next to the combo box.
-  If certain controls in a configuration dialog are only relevant if a
   certain item is selected (i.e. they are dependent controls), disable
   them instead of hiding.
-  Label the combo box with a descriptive caption to the left (cf.
   :doc:`alignment </layout/alignment>`).
-  Create a buddy relation so access keys are assigned.
-  End each label with a colon.
-  Use :doc:`sentence style capitalization </style/writing/capitalization>` for items.
