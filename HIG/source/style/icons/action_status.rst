Action and Status Icons
=======================
Action icons visually reinforce their control's action, and are commonly seen
on push buttons, tool buttons, and menu items. Status icons display the current
status of software or hardware and generally live in the System Tray.

Both action and status icons always use the `monochrome style \
<index.html#monochrome-icon-style>`__ and come in two sizes: 16px and 22px. They
use the standard monochrome icon margins.

Action items should use Shade Black as much as possible:

.. image:: /img/Breeze-icon-design-action.png
   :alt: Action icons

Status icons can use a bit more color in their composition to connote status
information:

.. image:: /img/Breeze-icon-design-status.png
   :alt: Status icons

Action and status icons dynamically change their colors when the user changes
the system's color. To accomplish this, a special CSS stylesheet is embedded
in the SVG, and then the actual shape definitions are tagged with the
appropriate class. For technical information regarding how to do this, read the
`workflow tips on how to create an icon \
<https://community.kde.org/Guidelines_and_HOWTOs/Icon_Workflow_Tips>`_.
