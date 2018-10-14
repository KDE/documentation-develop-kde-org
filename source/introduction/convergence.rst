Optimized Convergence
=====================

The design of KDE software, and by extension the KDE HIG, is made with
convergence in mind. *Convergence* means that a user interface (UI) can
immediately adapt its user experience (UX) depending on the UX Context.

There terms are explained in the :doc:`resources/glossary`.

Device Types
------------

The KDE HIG defines an optimal UX for each UX Context which are identified as
Device Type. The optimal UX of a Device Type describes how the user interface
(UI) should behave to provide users with the best user experience (UX). This
is defined in :doc:`devicetypeUX`

Some devices may change their UX Context to correspond with a different Device
Type, e.g. adding a keyboard and mouse to a tablet. This means a different UX
may need to be provided to the user. If minimal changes are needed, this can be
achieved with a "responsive" design, as described in :doc:`responsive`. For more
extensive changes, an entirely different UI may need to be presented.

Common Components
-----------------

Convergence requires an understanding of the commonalities in the UI. To that
end, we define a set of Common Components which are independent of any device
type. Convergence can then be implemented by providing variations of these
common UI components which correspond with the optimal UX of each Device Type.

For each Common Component we describe what it does and define its user story.
This user story describes the functionality of the component from a user's
perspective. This provides more detail and context than the short description
of what the component does.

- **Workspace**: The top-level container of the workspace. Often called desktop,
  home screen or shell, it shows your wallpaper and allows users to add widgets,
  app launchers, files or folders.

 - **Application Launcher**: Provides an overview of installed applications and
   allows the user to launch one of them.

  - *User Story: Susan wants to launch any of her applications so she can use
    its functionality.*

 - **Application Shortcuts**: Provides quick access to often-used applications.

  - *User Story: Susan wants to launch her favorite applications more
    quickly than other applications so she can use her device more efficiently.*

 - **Active Application Overview**: Provides an overview of the active
   applications that are directly used by the user.

  - *User Story: Susan wants to switch between the applications she is using
    so she can efficiently use the functionality from multiple applications.*

 - **Workspace Actions**: Provides quick access to functionality
   integrated into the workspace that needs to highly visible to the user. These
   are things like enabling/disable wifi and bluetooth or showing notifications.

  - *User Story: Susan wants to access functionality integrated into the
    workspace so she can configure it to suit her needs.*

 - **Application-Workspace Interaction**: Displays information about active
   applications and provides ways to change how the application runs within the
   workspace (e.g. minimize, maximize, close).

  - *User Story: Susan wants to customize how an application runs within the
    workspace so she can configure it to suit her needs.*

- **Application**: The top-level container of a single application which is
  directly used by the user.

 - **Application Tools**: Provides access to common functionality of
   applications. An application may also choose to provide this functionality in
   the Application Content.

  - *User Story: Susan wants to access common functionality of applications in a
    similar way for all applications so she can always easily find this
    functionality.*

 - **Application Content**: The actual content of an application. This depends
   on the application itself but conformance to the KDE HIG should make it
   easier to allow convergence for this component

  - *User Story: Susan wants to access the content of the application so she
    can use its functionality.*

These common components may become a bit more clear with a visual example:

.. figure:: /img/Desktop_UX.png
   :scale: 25%
   :alt: Example showing the common components on a Desktop device type

Making convergent applications
------------------------------

The KDE HIG describes patterns and components that an application developer can
use to manually define how their application fits the UX of each device type.
The UI toolkit Kirigami provides many of these patterns and components already
so they can be easily integrated in the application. If application developers
keep to the recommendations and best practices from the KDE HIG, their
application would support convergence. These recommendations may include manual
work for convergence, like creating additional UIs for different Device Types.
