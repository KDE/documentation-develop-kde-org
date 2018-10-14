Device Type UX
==============

A Device Type corresponds to the UX Context of a specific user experience (UX).
So for each Device Type the UX Context and the optimal UX are defined here. An
example is included to indicate how this might influence the Common Components
(which are described in :doc:`convergence`), but it is not part of the
definition for the Device Type.

A single device may represent multiple Device Types so the UI would need to
adapt to the Device Type most closely matching the device's current behaviour in
order to provide an optimal UX. For example, a tablet will normally have an
optimal UX, as defined for a Tablet. When the tablet is docked into its
docking station its UX Context more closely matches that of the Desktop/Laptop
UX. So the UI needs to be changed to correspond with the optimal UX for a
Desktop/Laptop. This example essentially shows how convergence works.

.. contents:: :depth: 2

Desktop/Laptop
--------------

UX Context
^^^^^^^^^^
- Primary Input method: *Keyboard/Pointing device from close range.*
- Screen size: *Moderate to Large.*
- Screen orientation: *Landscape, fixed.*

Optimal UX
^^^^^^^^^^
Since there is sufficient space, all components are directly accessible and
multiple applications can be shown at once. The use of a keyboard allows quick
and efficient text input without any on-screen elements. Pointing devices are
highly accurate and can use mouse-over (or "hover") effects. This allows for
additional elements, like hidden controls, to be shown on-screen when the cursor
"hovers" over a specific area. It is also possible to configure the workspace to
always maximize applications, which is more suitable for smaller screen sizes.

Example
^^^^^^^
This example shows how the Desktop UX can be applied in the Plasma Desktop
workspace:

- **Workspace**: has Virtual Desktops.

 - **Application Launcher**: Kickoff Menu in the taskbar.
 - **Application Shortcuts**: Applications can be dragged to the Panel or
   pinned in the Active Application Overview.
 - **Active Application Overview**: Task Manager in the taskbar.
 - **Workspace Actions**: System Tray in the taskbar.
 - **Application-Workspace Interaction**: Window Decorations for each
   application.

- **Application**: is windowed.

 - **Application Tools**: shows all top-level menu items at once at the top of
   the application window.
 - **Application Content**: most applications are already optimized for this
   device type.

.. figure:: /img/Desktop_UX.png
   :scale: 25%
   :alt: Example of the Desktop UX in the Plasma Desktop

Tablet
------

UX Context
^^^^^^^^^^
- Primary Input method: *Touchscreen from close range, usually with both hands.*
- Screen size: *Moderate.*
- Screen orientation: *Landscape/Portrait, dynamic.*

Optimal UX
^^^^^^^^^^
The workspace hides as much as possible, given the lack of screen space. The
main focus is the Application Content. Components are designed to be controlled
by fingers, which are less accurate than a pointing device. Given that the user
interacts directly with the screen, swiping inwards from screen edges can be
used to access otherwise hidden components.

Example
^^^^^^^
This example shows how the Tablet UX can be applied in a Plasma Tablet workspace
(though this does not exist yet, it is based on common tablet interfaces such as
on Android tablets):

- **Workspace**: has multiple home screens (similar to Virtual Desktops).

 - **Application Launcher**: a launcher accessible from the home screen (not
   necessarily fullscreen).
 - **Application Shortcuts**: the bottom bar on the home screen.
 - **Active Application Overview**: a fullscreen application switcher accessible
   from the bottom bar or auto-hidden controls (like a button bar containing the
   Home, Back and application switcher buttons).
 - **Workspace Actions**: a minimal top bar that auto-hides.
 - **Application-Workspace Interaction**: only from the Active Application
   Overview (close only).

- **Application**: running fullscreen or tiled.

 - **Application Tools**: available from a single button within the Application
   Content, a component shown by swiping from the edge of the workspace or
   through a shortcut (e.g. long-press a button in the button bar).
 - **Application Content**: needs to conform to the KDE HIG in order to display
   content in a way that's suitable for this device type.

Smartphone
----------

UX Context
^^^^^^^^^^
- Primary Input method: *Touchscreen from close range, mostly with one hand.*
- Screen size: *Small.*
- Screen orientation: *Landscape/Portrait, dynamic.*

Optimal UX
^^^^^^^^^^
The workspace hides as much as possible, given the lack of screen space. The
main focus is the Application Content. Components are designed to be controlled
by fingers, which are less accurate than a pointing device. This UX differs from
the Tablet UX in that the Application Content is adapted more heavily to the
smaller screen size, for which guidelines are provided in this KDE HIG. Also,
while it is optimized for one-handed use it may sometimes be necessary to use
both hands.

Example
^^^^^^^
This example shows how the Smartphone UX can be applied in the Plasma Mobile
workspace:

- **Workspace**: has multiple home screens (similar to Virtual Desktops).

 - **Application Launcher**: a fullscreen launcher accessible from the home
   screen.
 - **Application Shortcuts**: the bottom bar on the home screen.
 - **Active Application Overview**:  a fullscreen application switcher
   accessible from the bottom bar or auto-hidden controls (like a button bar
   containing the Home, Back and application switcher buttons).
 - **Workspace Actions**: a minimal top bar that auto-hides.
 - **Application-Workspace Interaction**: only from the Active Application
   Overview (close only).

- **Application**: always running fullscreen.

 - **Application Menu**: available from a single button within the Application
   Content, a component shown by swiping from the edge of the workspace or
   through a shortcut (e.g. long-press a button in the button bar).
 - **Application Content**: needs to conform to the KDE HIG in order to display
   content in a way that's suitable for this device type.
