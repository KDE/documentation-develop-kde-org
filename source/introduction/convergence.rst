Optimized Convergence
=====================

The design of KDE software, and by extension the KDE HIG, is made with
convergence in mind. *Convergence* means that a piece of software's user
interface can immediately adapt its user experience to the particularities of
each type of device that it can run on (desktop, laptop, tablet, phone, etc).

For information regarding the differences between a user interface and the user experience, see the :doc:`../resources/glossary`.

Device Types
------------

The KDE HIG defines an optimal user experience for each device type, as
described in :doc:`devicetypes`.


Common Components
-----------------

Convergence requires an understanding of the commonalities in the user
interface. To that end, the KDE HIG defines a set of common components which
are independent of any device type. Convergence can then be implemented by
providing variations of these common UI components which correspond with the
optimal user experience for each device's usage model.


- **Workspace**: The top-level container of the whole user interface. Often
  called "desktop", "home screen", or "shell", it shows the wallpaper and
  allows users to add widgets, app launchers, files or folders.

- **Application Launcher**: Provides an overview of installed applications and
  allows the user to launch one of them.

- **Application Shortcuts**: Provides quick access to frequently-used
  applications.

- **Active Application Overview**: Provides an overview of the active
  applications that are directly used by the user.

- **Workspace Tools**: Provides quick access to functionality integrated
  into the workspace that's both highly visible to the user and frequently
  changed, like enabling/disabling WiFi and Bluetooth, or whether or not to
  show notifications.

- **Application-Workspace Interaction**: Displays information about each
  application's windows, and provides ways to move or close them and change how
  they run within the workspace.

- **Application**: The top-level container of a single application.

- **Application Tools**: Provides access to an application's commonly-used
  functionality in an always-accessible toolbar or menubar. These tools should
  not change depending on what the application is displaying.

- **Application Content**: The actual content of an application. This depends
  on the application itself, but conformance to the KDE HIG should make it
  easier to allow convergence for this component. This part of the application
  can also contain contextually-appropriate tools that operate directly on the
  active or selected content.

These common components may become a bit more clear with a visual example:

.. figure:: /img/Desktop_UX.png
   :scale: 25%
   :alt: Example showing the common components on a Desktop device type

Making convergent applications
------------------------------

The best way to create convergent applications is to follow the recommendations
and best practices from the KDE HIG, and build your app using the Kirigami UI
toolkit, which provides many of these patterns and components "out of the box"
so that they can be easily integrated.
