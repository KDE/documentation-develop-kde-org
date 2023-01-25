---
title: Device Types
weight: 3
---

With the multitude of digital devices available today, such as desktop and laptop computers, smartphones, and tablets, achieving a seamless and efficient user experience is contingent upon designing a user interface that is tailored to each device's physical characteristics and the way in which everyday users interact with it .

For information regarding the differences between a user interface and
the user experience, see the [Glossary]({{< relref "glossary" >}}).

Some devices are adaptable, such as a tablet with an attached keyboard, or
a convertible laptop that can be used in laptop and tablet mode. These types of devices will require the user interface to adaptto each mode of use. If minimal changes are needed (for example, a laptop plugged
into a large external screen) this can be achieved with a "responsive"
design, as described in `responsive`. 

For more extensive changes (for example, a tablet plugged into a docking
station with a mouse and keyboard attached), an entirely different user
interface paradigm may be necessary.

Desktops and Laptops
--------------

### Device Characteristics

-   **Primary Input method**: *Keyboard and Pointing device*

-   **Input device precision**: *Very high: individual keys and screen
    pixels can be targeted and pressed with high accuracy*

-   **Screen size**: *Typically 28 - 76cm measured diagonally*

-   **Screen orientation**: *Fixed landscape orientation*

-   **Learning curve**: *Medium: keyboard and mouse skills must be learned*

### Creating An Optimal User Experience

Since there is sufficient space, all components are directly accessible
and multiple applications can be shown at once. The use of a keyboard
allows quick and efficient text input without any on-screen elements.
Pointing devices are highly accurate and user interface elements may be
compact.

Though mouse-over (or \"hover\") effects are possible, we discourage the use of effect-based functionality because it is not readily available to the user. We encourage you to use the available screen space to present functionality directly to the user. Hover effects should only be used for
non-essential informational purposes, such as showing tooltips, previews, snippets, etc.

Given the available screen real estate, it is possible to customize the user interface to match the user\'s workflow and aesthetic preferences.

Laptops should be properly supported, keeping in mind the following
guidelines:

-   When using a touchpad\'s two-finger scroll gesture, ensure that
    scrollviews do pixel-by-pixel scrolling instead of \"jumping\"
    certain number of rows.

-   Minimize window chrome and make sure that there is enough space for
    content. Avoid crammed toolbars and multiple frames that take away from content. While space is available, keep in mind the main objective of your application and give that space the most attention.

-   Minimize the use of Function keys as shortcuts as these can be
    difficult to access with a laptop keyboard. Provide alternative
    accelerators wherever possible such as a button in a toolbar or sidebar.

-   Avoid assigning essential functions to right-click or middle-click. Do not require the use of right-click-drag or middle-click-drag as they can be difficult or impossible to replicate on a touchpad, limiting the functionality of the application for some users.

### Example

This describes the existing Plasma Desktop:

- **Workspace**: Has Virtual Desktops

  - **Application Launcher**: Kickoff Menu in the Panel

  - **Application Shortcuts**: Applications can be dragged to the
    Panel or pinned in the Active Application Overview

  - **Active Application Overview**: Task Manager in the Panel

  - **Workspace Tools**: System Tray in the Panel

  - **Application-Workspace Interaction**: Titlebars and other window
    decoration for each application\'s window

- **Application**: Is windowed
  - **Application Tools**: Shows application-global tools at the top
    of the application window in the form of toolbars and menubars

  - **Application Content**: Most applications are already optimized
    for this device type

![Desktop](/hig/Desktop_UX.png)

Tablets
------

### Device Characteristics

- **Primary input method**: *Touch. Touching a screen with one or multiple fingers from one or both hands.*

- **Device input precision**: *Low. There is a wide range of hand and finger sizes among users of different ages, sizes, and genders, therefore inaccurate input must often be taken into account and corrected.*

- **Screen size**: *Typically: 18 - 30+cm measured diagonally.*

- **Screen orientation**: *Dynamic. Supports dynamic switching between landscape and portrait orientations.*

- **Learning curve**: *Low. Intuitive touch input and simple applications.*

### Creating an Optimized User Experience

Design should prioritize the characteristics of touch input, ensuring that user interface elements are large enough to be easily tapped by all human input sizes. Intelligent software should be utilized to correct any inaccurate input, particularly when it comes to text entry.

The main focus is the application content. Because of limited screen
space in tablets, the workspace tends to hide many controls. 

Applications should show the most contextually-appropriate content and tools, maximizing the use of the small screen space. Application windows should be opened in a maximized state. Larger tablets may allow for side-by-side, or quarter window tiling.

### Example

Though a Plasma Tablet shell does not exist, this example
shows how it might behave:

- **Workspace**: Contains multiple home screens, similar to Virtual
    Desktops

   - **Application Launcher**: A launcher accessible from the home
     screen (not necessarily fullscreen)

   - **Application Shortcuts**: Live on the bottom Panel, similar to on
     Plasma Desktop

   - **Active Application Overview**: A fullscreen application switcher
     accessible from the bottom panel or auto-hidden controls (like a
     button bar containing the Home, Back and application switcher
     buttons)

   - **Workspace Actions**: A minimal top panel that auto-hides

   - **Application-Workspace Interaction**: Available from the Active
     Application Overview, and allows closing and
     re-arranging/re-ordering apps

* **Application**: Runs fullscreen or tiled
   * **Application Tools**: Available from a toolbar within the
     application window. No desktop-style menubars are used.
     Commonly-used tools can be accessed through touch gesture
     shortcuts

   * **Application Content**: Needs to conform to the KDE HIG in order
     to display content in a way that\'s suitable for this device type

Smartphone
----------

### Characteristics

- Primary Input method: *One or more fingers touching a touchscreen,
  usually with only one hand*

- Input device precision: *Low: wide variability of hand and fingertip
  sizes across user ages, sizes and genders. Sloppy input must often
  be corrected*

- Screen size: *Typically: 11 - 18cm measured diagonally*

- Screen orientation: *Dynamically switches between landscape and
  portrait, though mostly used in portrait mode*

- Learning curve: *Low: intuitive touch input and simple apps*

### Optimal user experience

Like with the tablet device type, user interface elements must be large
enough to accommodate a large low-precision fingertip. Because of the
even more constrained screen size, only a few interactive controls can
be presented at one time. Others must be hidden on other pages or behind
drawers and pop-up views.

Like the tablet mode, the workspace hides as much as possible and the
main focus is the Application Content\--only even more so. Great care
must be taken to optimize the Application Content to the small screen
size, omitting anything not absolutely necessary

While this device type is optimized for one-handed use, it may sometimes
be useful to support two-handed use, especially when typing.

### Example

This example shows how the Smartphone UX can be applied in the
[Plasma mobile](https://www.plasma-mobile.org/)
workspace:

- **Workspace**: Has multiple home screens (similar to Virtual
    Desktops)
   - **Application Launcher**: A fullscreen launcher accessible from
     the home screen
   - **Application Shortcuts**: The bottom panel on the home screen
   - **Active Application Overview**: A fullscreen application switcher
     accessible from the bottom panel or auto-hidden controls (like a
     button bar containing the Home, Back and application switcher
     buttons)
   - **Workspace Actions**: A minimal top panel that auto-hides
   - **Application-Workspace Interaction**: Available from the Active
     Application Overview, and allows closing and
     re-arranging/re-ordering apps

- **Application**: Always runs fullscreen
   - **Application Tools**: The absolute minimum possible assortment of
     tools are available from a toolbar within the application window.
     No desktop-style menubars are used. Commonly-used tools can be
     accessed through touch gesture shortcuts
   - **Application Content**: Needs to conform to the KDE HIG in order
     to display content in a way that\'s suitable for this device type

TV
--

### Characteristics

- Primary Input method:
    - *Remote control from long range (\~3m)*
    - *Voice control*
- Input device precision:
    - *High: Remote control provides precise input but only with a
      limited number of buttons*
    - *Moderate: Remote control may provide rough cursor control.*
    - *Low: Voice control allows executing any action directly but can
      be difficult to interpret correctly*
- Screen size: *Typically: 81 - 140cm measured diagonally*
- Screen orientation: *Typically landscape mode*
- Learning curve:
    - *Low: Intuitive remote control navigation on-screen*
    - *Moderate: Voice control trigger phrases may take some time to
      learn*

### Optimal user experience

Viewing the device from a long range requires the user interface
elements to be very clear and large enough to easily distinguish. This
means that the information density should also not be too high.

The main focus is the Application Content but some other components can
be shown if it does not increase the information density too much.
Hidden components can be shown and accessed by navigating to them using
the remote control.

Navigating the Application Content can be done using only 4 directional
arrow buttons, an OK button and a Back button. This is the set of
buttons that is available on almost all remote controls. Common tools
and actions for both the workspace and applications can be accessed
through voice control actions.

### Example

This example shows how the Smart TV UX can be applied in the Plasma
Bigscreen workspace:

- **Workspace**: Has a single home screen.
   - **Application Launcher**: A fullscreen launcher that is always
     open
   - **Application Shortcuts**: None (use Application Launcher only)
   - **Active Application Overview**: A fullscreen application
     accessible from the Application Launcher as a normal application
     (no Workspace shortcut)
   - **Workspace Actions**: A minimal top panel that is automatically
     hidden
   - **Application-Workspace Interaction**: Available from the Active
     Application Overview, and allows closing apps

- **Application**: Always runs fullscreen
   - **Application Tools**: The absolute minimum possible assortment of
     tools are available from large and clear user interface elements.
     These elements may be be smaller or hidden by default and are
     shown or made bigger when navigating to them. No desktop-style
     menubars are used. Commonly-used tools can be accessed through
     voice control.
   - **Application Content**: Needs to conform to the KDE HIG in order
     to display content in a way that\'s suitable for this device type.
