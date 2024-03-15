---
title: KWin scripting API
aliases:
  - /docs/plasma/kwin/api/
---

This page describes the KWin Scripting API as of KWin 6.0. It has been generated using https://invent.kde.org/nicolasfella/kwin-scripting-api-generator

## Global

Methods and properties added to the global JavaScript object.

### Read-only Properties

* `KWin::Options options`: Global property to all configuration values of KWin core.
* `KWin::Workspace workspace`: Global property to the core wrapper of KWin.
* `object KWin`: Provides access to enums defined in KWin::WorkspaceWrapper
### Functions

* `print(QVariant ... values)`: Prints all provided values to kDebug and as a D-Bus signal
* `QVariant readConfig(QString key, QVariant defaultValue = QVariant())`: Reads the config value for key in the Script's configuration with the optional default value. If not providing a default value and no value stored in the configuration an undefined value is returned.
* `bool registerScreenEdge(ElectricBorder border, QJSValue callback)`: Registers the callback for the screen edge. When the mouse gets pushed against the given edge the callback will be invoked. Scripts can also add "X-KWin-Border-Activate" to their metadata file to have the effect listed in the screen edges KCM. This will write an entry BorderConfig= in the script configuration object with a list of ScreenEdges the user has selected.
* `bool unregisterScreenEdge(ElectricBorder border)`: Unregisters the callback for the screen edge. This will disconnect all callbacks from this script to that edge.
* `bool registerShortcut(QString title, QString text, QString keySequence, QJSValue callback)`: Registers keySequence as a global shortcut. When the shortcut is invoked the callback will be called. Title and text are used to name the shortcut and make it available to the global shortcut configuration module.
* `bool assert(bool value, QString message = QString())`: Aborts the execution of the script if value does not evaluate to true. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertTrue(bool value, QString message = QString())`: Aborts the execution of the script if value does not evaluate to true. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertFalse(bool value, QString message = QString())`: Aborts the execution of the script if value does not evaluate to false. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertEquals(QVariant expected, QVariant actual, QString message = QString())`: Aborts the execution of the script if the actual value is not equal to the expected value. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertNull(QVariant value, QString message = QString())`: Aborts the execution of the script if value is not null. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertNotNull(QVariant value, QString message = QString())`: Aborts the execution of the script if value is null. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `callDBus(QString service, QString path, QString interface, QString method, QVariant arg..., QJSValue callback = QJSValue())`: Call a D-Bus method at (service, path, interface and method). A variable number of arguments can be added to the method call. The D-Bus call is always performed in an async way invoking the callback provided as the last (optional) argument. The reply values of the D-Bus method call are passed to the callback.
* `registerUserActionsMenu(QJSValue callback)`: Registers the passed in callback to be invoked whenever the User actions menu (`Alt+F3` or right click on window decoration) is about to be shown. The callback is invoked with a reference to the Client for which the menu is shown. The callback can return either a single menu entry to be added to the menu or an own sub menu with multiple entries. The object for a menu entry should be
  ```js
  {
    title: "My Menu entry",
    checkable: true,
    checked: false,
    triggered: function (action) {
      // callback with triggered QAction
    }
  }
  ```
  for a menu it should be
  ```js
  {
    title: "My menu",
    items: [{...}, {...}, ...] /*list with entries as described*/
  }
  ```

## KWin::WorkspaceWrapper

### Enums

#### ClientAreaOption

* `PlacementArea`: window movement snapping area? ignore struts
* `MovementArea`:
* `MaximizeArea`:
* `MaximizeFullArea`:
* `FullScreenArea`:
* `WorkArea`:
* `FullArea`:
* `ScreenArea`:

#### ElectricBorder

* `ElectricTop`:
* `ElectricTopRight`:
* `ElectricRight`:
* `ElectricBottomRight`:
* `ElectricBottom`:
* `ElectricBottomLeft`:
* `ElectricLeft`:
* `ElectricTopLeft`:
* `ELECTRIC_COUNT`:
* `ElectricNone`:

### Read-only Properties

* `QList< KWin::VirtualDesktop * >` `desktops`
* `QSize` `desktopGridSize`
* `int` `desktopGridWidth`
* `int` `desktopGridHeight`
* `int` `workspaceWidth`
* `int` `workspaceHeight`
* `QSize` `workspaceSize`
* `KWin::Output *` `activeScreen`
* `QList< KWin::Output * >` `screens`
* `QStringList` `activities`
* `QSize` `virtualScreenSize`: The bounding size of all screens combined. Overlapping areas are not counted multiple times. virtualScreenGeometry
* `QRect` `virtualScreenGeometry`: The bounding geometry of all screens combined. Always starts at (0,0) and has virtualScreenSize as it's size. virtualScreenSize
* `QList< KWin::Window * >` `stackingOrder`: List of Clients currently managed by KWin, orderd by their visibility (later ones cover earlier ones).
* `QPoint` `cursorPos`: The current position of the cursor.

### Read-write Properties

* `KWin::VirtualDesktop *` `currentDesktop`
* `KWin::Window *` `activeWindow`
* `QString` `currentActivity`

### Signals

* `windowAdded(KWin::Window *window)`
* `windowRemoved(KWin::Window *window)`
* `windowActivated(KWin::Window *window)`
* `desktopsChanged()`: This signal is emitted when a virtual desktop is added or removed.
* `desktopLayoutChanged()`: Signal emitted whenever the layout of virtual desktops changed. That is desktopGrid(Size/Width/Height) will have new values. 4.11
* `screensChanged()`: Emitted when the output list changes, e.g. an output is connected or removed.
* `currentActivityChanged(const QString &id)`: Signal emitted whenever the current activity changed. id id of the new activity
* `activitiesChanged(const QString &id)`: Signal emitted whenever the list of activities changed. id id of the new activity
* `activityAdded(const QString &id)`: This signal is emitted when a new activity is added id id of the new activity
* `activityRemoved(const QString &id)`: This signal is emitted when the activity is removed id id of the removed activity
* `virtualScreenSizeChanged()`: Emitted whenever the virtualScreenSize changes. virtualScreenSize() 5.0
* `virtualScreenGeometryChanged()`: Emitted whenever the virtualScreenGeometry changes. virtualScreenGeometry() 5.0
* `currentDesktopChanged(KWin::VirtualDesktop *previous)`: This signal is emitted when the current virtual desktop changes.
* `cursorPosChanged()`: This signal is emitted when the cursor position changes. cursorPos()

### Functions

* `slotSwitchDesktopNext()`
* `slotSwitchDesktopPrevious()`
* `slotSwitchDesktopRight()`
* `slotSwitchDesktopLeft()`
* `slotSwitchDesktopUp()`
* `slotSwitchDesktopDown()`
* `slotSwitchToNextScreen()`
* `slotSwitchToPrevScreen()`
* `slotSwitchToRightScreen()`
* `slotSwitchToLeftScreen()`
* `slotSwitchToAboveScreen()`
* `slotSwitchToBelowScreen()`
* `slotWindowToNextScreen()`
* `slotWindowToPrevScreen()`
* `slotWindowToRightScreen()`
* `slotWindowToLeftScreen()`
* `slotWindowToAboveScreen()`
* `slotWindowToBelowScreen()`
* `slotToggleShowDesktop()`
* `slotWindowMaximize()`
* `slotWindowMaximizeVertical()`
* `slotWindowMaximizeHorizontal()`
* `slotWindowMinimize()`
* `slotWindowShade()`
* `slotWindowRaise()`
* `slotWindowLower()`
* `slotWindowRaiseOrLower()`
* `slotActivateAttentionWindow()`
* `slotWindowMoveLeft()`
* `slotWindowMoveRight()`
* `slotWindowMoveUp()`
* `slotWindowMoveDown()`
* `slotWindowExpandHorizontal()`
* `slotWindowExpandVertical()`
* `slotWindowShrinkHorizontal()`
* `slotWindowShrinkVertical()`
* `slotWindowQuickTileLeft()`
* `slotWindowQuickTileRight()`
* `slotWindowQuickTileTop()`
* `slotWindowQuickTileBottom()`
* `slotWindowQuickTileTopLeft()`
* `slotWindowQuickTileTopRight()`
* `slotWindowQuickTileBottomLeft()`
* `slotWindowQuickTileBottomRight()`
* `slotSwitchWindowUp()`
* `slotSwitchWindowDown()`
* `slotSwitchWindowRight()`
* `slotSwitchWindowLeft()`
* `slotIncreaseWindowOpacity()`
* `slotLowerWindowOpacity()`
* `slotWindowOperations()`
* `slotWindowClose()`
* `slotWindowMove()`
* `slotWindowResize()`
* `slotWindowAbove()`
* `slotWindowBelow()`
* `slotWindowOnAllDesktops()`
* `slotWindowFullScreen()`
* `slotWindowNoBorder()`
* `slotWindowToNextDesktop()`
* `slotWindowToPreviousDesktop()`
* `slotWindowToDesktopRight()`
* `slotWindowToDesktopLeft()`
* `slotWindowToDesktopUp()`
* `slotWindowToDesktopDown()`
* `sendClientToScreen(KWin::Window *client, KWin::Output *output)`: Sends the Window to the given output.
* `showOutline(const QRect &geometry)`: Shows an outline at the specified geometry. If an outline is already shown the outline is moved to the new position. Use hideOutline to remove the outline again.
* `showOutline(int x, int y, int width, int height)`: Overloaded method for convenience.
* `hideOutline()`: Hides the outline previously shown by showOutline.
* `KWin::Output *` `screenAt(const QPointF &pos) const`
* `KWin::TileManager *` `tilingForScreen(const QString &screenName) const`
* `KWin::TileManager *` `tilingForScreen(KWin::Output *output) const`
* `QRectF` `clientArea(ClientAreaOption option, KWin::Output *output, KWin::VirtualDesktop *desktop) const`: Returns the geometry a Client can use with the specified option. This method should be preferred over other methods providing screen sizes as the various options take constraints such as struts set on panels into account. This method is also multi screen aware, but there are also options to get full areas. option The type of area which should be considered screen The screen for which the area should be considered desktop The desktop for which the area should be considered, in general there should not be a difference The specified screen geometry
* `QRectF` `clientArea(ClientAreaOption option, KWin::Window *client) const`: Overloaded method for convenience. client The Client for which the area should be retrieved The specified screen geometry
* `QRectF` `clientArea(ClientAreaOption option, const KWin::Window *client) const`
* `createDesktop(int position, const QString &name) const`: Create a new virtual desktop at the requested position. position The position of the desktop. It should be in range [0, count]. name The name for the new desktop, if empty the default name will be used.
* `removeDesktop(KWin::VirtualDesktop *desktop) const`: Removes the specified virtual desktop.
* `QString` `supportInformation() const`: Provides support information about the currently running KWin instance.
* `raiseWindow(KWin::Window *window)`: Raises a Window above all others on the screen. window The Window to raise
* `KWin::Window *` `getClient(qulonglong windowId)`: Finds the Client with the given windowId. windowId The window Id of the Client The found Client or null
* `QList< KWin::Window * >` `windowAt(const QPointF &pos, int count=1) const`: Finds up to count windows at a particular location, prioritizing the topmost one first. A negative count returns all matching clients. pos The location to look for count The number of clients to return A list of Client objects
* `bool` `isEffectActive(const QString &pluginId) const`: Checks if a specific effect is currently active. pluginId The plugin Id of the effect to check. true if the effect is loaded and currently active, false otherwise. 6.0

## KWin::VirtualDesktop

### Read-only Properties

* `QString` `id`
* `uint` `x11DesktopNumber`

### Read-write Properties

* `QString` `name`

### Signals

* `nameChanged()`
* `x11DesktopNumberChanged()`
* `aboutToBeDestroyed()`: Emitted just before the desktop gets destroyed.

### Functions

## KWin::Output

### Enums

#### DpmsMode

* `On`:
* `Standby`:
* `Suspend`:
* `Off`:

#### Capability

* `Dpms`:
* `Overscan`:
* `Vrr`:
* `RgbRange`:
* `HighDynamicRange`:
* `WideColorGamut`:
* `AutoRotation`:
* `IccProfile`:
* `Tearing`:

#### SubPixel

* `Unknown`:
* `None`:
* `Horizontal_RGB`:
* `Horizontal_BGR`:
* `Vertical_RGB`:
* `Vertical_BGR`:

#### RgbRange
* `Automatic`:
* `Full`:
* `Limited`:

#### AutoRotationPolicy

* `Never`:
* `InTabletMode`:
* `Always`:

### Read-only Properties

* `QRect` `geometry`
* `qreal` `devicePixelRatio`
* `QString` `name`
* `QString` `manufacturer`
* `QString` `model`
* `QString` `serialNumber`

### Signals

* `geometryChanged()`: This signal is emitted when the geometry of this output has changed.
* `enabledChanged()`: This signal is emitted when the output has been enabled or disabled.
* `scaleChanged()`: This signal is emitted when the device pixel ratio of the output has changed.
* `aboutToTurnOff(std::chrono::milliseconds time)`: Notifies that the display will be dimmed in time ms. This allows effects to plan for it and hopefully animate it
* `wakeUp()`: Notifies that the output has been turned on and the wake can be decorated.
* `aboutToChange(OutputChangeSet *changeSet)`: Notifies that the output is about to change configuration based on a user interaction. Be it because it gets a transformation or moved around. Only to be used for effects
* `changed()`: Notifies that the output changed based on a user interaction. Be it because it gets a transformation or moved around. Only to be used for effects
* `currentModeChanged()`
* `modesChanged()`
* `outputChange(const QRegion &damagedRegion)`
* `transformChanged()`
* `dpmsModeChanged()`
* `capabilitiesChanged()`
* `overscanChanged()`
* `vrrPolicyChanged()`
* `rgbRangeChanged()`
* `wideColorGamutChanged()`
* `sdrBrightnessChanged()`
* `highDynamicRangeChanged()`
* `autoRotationPolicyChanged()`
* `iccProfileChanged()`
* `iccProfilePathChanged()`
* `brightnessMetadataChanged()`
* `sdrGamutWidenessChanged()`
* `colorDescriptionChanged()`

### Functions

* `QPointF` `mapToGlobal(const QPointF &pos) const`
* `QPointF` `mapFromGlobal(const QPointF &pos) const`

## KWin::Window

### Enums

#### SizeMode

* `SizeModeAny`:
* `SizeModeFixedW`:
* `SizeModeFixedH`:
* `SizeModeMax`:

#### SameApplicationCheck

* `RelaxedForActive`:
* `AllowCrossProcesses`:

### Read-only Properties

* `QRectF` `bufferGeometry`: This property holds rectangle that the pixmap or buffer of this Window occupies on the screen. This rectangle includes invisible portions of the window, e.g. client-side drop shadows, etc.
* `QRectF` `clientGeometry`: The geometry of the Window without frame borders.
* `QPointF` `pos`: This property holds the position of the Window's frame geometry.
* `QSizeF` `size`: This property holds the size of the Window's frame geometry.
* `qreal` `x`: This property holds the x position of the Window's frame geometry.
* `qreal` `y`: This property holds the y position of the Window's frame geometry.
* `qreal` `width`: This property holds the width of the Window's frame geometry.
* `qreal` `height`: This property holds the height of the Window's frame geometry.
* `KWin::Output *` `output`: The output where the window center is on
* `QRectF` `rect`
* `QString` `resourceName`
* `QString` `resourceClass`
* `QString` `windowRole`
* `bool` `desktopWindow`: Returns whether the window is a desktop background window (the one with wallpaper). See _NET_WM_WINDOW_TYPE_DESKTOP at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dock`: Returns whether the window is a dock (i.e. a panel). See _NET_WM_WINDOW_TYPE_DOCK at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `toolbar`: Returns whether the window is a standalone (detached) toolbar window. See _NET_WM_WINDOW_TYPE_TOOLBAR at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `menu`: Returns whether the window is a torn-off menu. See _NET_WM_WINDOW_TYPE_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `normalWindow`: Returns whether the window is a "normal" window, i.e. an application or any other window for which none of the specialized window types fit. See _NET_WM_WINDOW_TYPE_NORMAL at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dialog`: Returns whether the window is a dialog window. See _NET_WM_WINDOW_TYPE_DIALOG at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `splash`: Returns whether the window is a splashscreen. Note that many (especially older) applications do not support marking their splash windows with this type. See _NET_WM_WINDOW_TYPE_SPLASH at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `utility`: Returns whether the window is a utility window, such as a tool window. See _NET_WM_WINDOW_TYPE_UTILITY at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dropdownMenu`: Returns whether the window is a dropdown menu (i.e. a popup directly or indirectly open from the applications menubar). See _NET_WM_WINDOW_TYPE_DROPDOWN_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `popupMenu`: Returns whether the window is a popup menu (that is not a torn-off or dropdown menu). See _NET_WM_WINDOW_TYPE_POPUP_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `tooltip`: Returns whether the window is a tooltip. See _NET_WM_WINDOW_TYPE_TOOLTIP at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `notification`: Returns whether the window is a window with a notification. See _NET_WM_WINDOW_TYPE_NOTIFICATION at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `criticalNotification`: Returns whether the window is a window with a critical notification.
* `bool` `appletPopup`: Returns whether the window is an applet popup.
* `bool` `onScreenDisplay`: Returns whether the window is an On Screen Display.
* `bool` `comboBox`: Returns whether the window is a combobox popup. See _NET_WM_WINDOW_TYPE_COMBO at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dndIcon`: Returns whether the window is a Drag&Drop icon. See _NET_WM_WINDOW_TYPE_DND at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `int` `windowType`: Returns the NETWM window type See https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `managed`: Whether this Window is managed by KWin (it has control over its placement and other aspects, as opposed to override-redirect windows that are entirely handled by the application).
* `bool` `deleted`: Whether this Window represents an already deleted window and only kept for the compositor for animations.
* `bool` `popupWindow`: Whether the window is a popup.
* `bool` `outline`: Whether this Window represents the outline. It's always false if compositing is turned off.
* `QUuid` `internalId`: This property holds a UUID to uniquely identify this Window.
* `int` `pid`: The pid of the process owning this window. 5.20
* `int` `stackingOrder`: The position of this window within Workspace's window stack.
* `bool` `fullScreenable`: Whether the Window can be set to fullScreen. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `bool` `active`: Whether this Window is active or not. Use Workspace::activateWindow() to activate a Window. Workspace::activateWindow
* `bool` `closeable`: Whether the window can be closed by the user.
* `QIcon` `icon`
* `bool` `shadeable`: Whether the Window can be shaded. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `bool` `minimizable`: Whether the Window can be minimized. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `QRectF` `iconGeometry`: The optional geometry representing the minimized Window in e.g a taskbar. See _NET_WM_ICON_GEOMETRY at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html . The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `bool` `specialWindow`: Returns whether the window is any of special windows types (desktop, dock, splash, ...), i.e. window types that usually don't have a window frame and the user does not use window management (moving, raising,...) on them. The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `QString` `caption`: The Caption of the Window. Read from WM_NAME property together with a suffix for hostname and shortcut. To read only the caption as provided by WM_NAME, use the getter with an additional false value.
* `QSizeF` `minSize`: Minimum size as specified in WM_NORMAL_HINTS
* `QSizeF` `maxSize`: Maximum size as specified in WM_NORMAL_HINTS
* `bool` `wantsInput`: Whether the Window can accept keyboard focus. The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `bool` `transient`: Whether the Window is a transient Window to another Window. transientFor
* `KWin::Window *` `transientFor`: The Window to which this Window is a transient if any.
* `bool` `modal`: Whether the Window represents a modal window.
* `bool` `move`: Whether the Window is currently being moved by the user. Notify signal is emitted when the Window starts or ends move/resize mode.
* `bool` `resize`: Whether the Window is currently being resized by the user. Notify signal is emitted when the Window starts or ends move/resize mode.
* `bool` `decorationHasAlpha`: Whether the decoration is currently using an alpha channel.
* `bool` `providesContextHelp`: Whether the Window provides context help. Mostly needed by decorations to decide whether to show the help button or not.
* `bool` `maximizable`: Whether the Window can be maximized both horizontally and vertically. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `bool` `moveable`: Whether the Window is moveable. Even if it is not moveable, it might be possible to move it to another screen. The property is evaluated each time it is invoked. Because of that there is no notify signal. moveableAcrossScreens
* `bool` `moveableAcrossScreens`: Whether the Window can be moved to another screen. The property is evaluated each time it is invoked. Because of that there is no notify signal. moveable
* `bool` `resizeable`: Whether the Window can be resized. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `QString` `desktopFileName`: The desktop file name of the application this Window belongs to. This is either the base name without full path and without file extension of the desktop file for the window's application (e.g. "org.kde.foo"). The application's desktop file name can also be the full path to the desktop file (e.g. "/opt/kde/share/org.kde.foo.desktop") in case it's not in a standard location.
* `bool` `hasApplicationMenu`: Whether an application menu is available for this Window
* `bool` `applicationMenuActive`: Whether the application menu for this Window is currently opened
* `bool` `unresponsive`: Whether this window is unresponsive. When an application failed to react on a ping request in time, it is considered unresponsive. This usually indicates that the application froze or crashed.
* `QString` `colorScheme`: The color scheme set on this window Absolute file path, or name of palette in the user's config directory following KColorSchemes format. An empty string indicates the default palette from kdeglobals is used. this indicates the colour scheme requested, which might differ from the theme applied if the colorScheme cannot be found
* `KWin::Layer` `layer`
* `bool` `hidden`: Whether this window is hidden. It's usually the case with auto-hide panels.
* `bool` `inputMethod`: Returns whether this window is a input method window. This is only used for Wayland.

### Read-write Properties

* `qreal` `opacity`
* `bool` `skipsCloseAnimation`: Whether the window does not want to be animated on window close. There are legit reasons for this like a screenshot application which does not want it's window being captured.
* `bool` `fullScreen`: Whether this Window is fullScreen. A Window might either be fullScreen due to the _NET_WM property or through a legacy support hack. The fullScreen state can only be changed if the Window does not use the legacy hack. To be sure whether the state changed, connect to the notify signal.
* `QList< KWin::VirtualDesktop * >` `desktops`: The virtual desktops this client is on. If it's on all desktops, the list is empty.
* `bool` `onAllDesktops`: Whether the Window is on all desktops. That is desktop is -1.
* `QStringList` `activities`: The activities this client is on. If it's on all activities the property is empty.
* `bool` `skipTaskbar`: Indicates that the window should not be included on a taskbar.
* `bool` `skipPager`: Indicates that the window should not be included on a Pager.
* `bool` `skipSwitcher`: Whether the Window should be excluded from window switching effects.
* `bool` `keepAbove`: Whether the Window is set to be kept above other windows.
* `bool` `keepBelow`: Whether the Window is set to be kept below other windows.
* `bool` `shade`: Whether the Window is shaded.
* `bool` `minimized`: Whether the Window is minimized.
* `bool` `demandsAttention`: Whether window state _NET_WM_STATE_DEMANDS_ATTENTION is set. This state indicates that some action in or with the window happened. For example, it may be set by the Window Manager if the window requested activation but the Window Manager refused it, or the application may set it if it finished some work. This state may be set by both the Window and the Window Manager. It should be unset by the Window Manager when it decides the window got the required attention (usually, that it got activated).
* `QRectF` `frameGeometry`: The geometry of this Window. Be aware that depending on resize mode the frameGeometryChanged signal might be emitted at each resize step or only at the end of the resize operation.
* `bool` `noBorder`: Whether the window has a decoration or not. This property is not allowed to be set by applications themselves. The decision whether a window has a border or not belongs to the window manager. If this property gets abused by application developers, it will be removed again.
* `KWin::Tile *` `tile`: The Tile this window is associated to, if any

### Signals

* `stackingOrderChanged()`
* `shadeChanged()`
* `opacityChanged(KWin::Window *window, qreal oldOpacity)`
* `damaged(KWin::Window *window)`
* `inputTransformationChanged()`
* `closed()`
* `windowShown(KWin::Window *window)`
* `windowHidden(KWin::Window *window)`
* `outputChanged()`: Emitted whenever the Window's screen changes. This can happen either in consequence to a screen being removed/added or if the Window's geometry changes. 4.11
* `skipCloseAnimationChanged()`
* `windowRoleChanged()`: Emitted whenever the window role of the window changes. 5.0
* `windowClassChanged()`: Emitted whenever the window class name or resource name of the window changes. 5.0
* `surfaceChanged()`: Emitted whenever the Surface for this Window changes.
* `shadowChanged()`: Emitted whenever the window's shadow changes. 5.15
* `bufferGeometryChanged(const QRectF &oldGeometry)`: This signal is emitted when the Window's buffer geometry changes.
* `frameGeometryChanged(const QRectF &oldGeometry)`: This signal is emitted when the Window's frame geometry changes.
* `clientGeometryChanged(const QRectF &oldGeometry)`: This signal is emitted when the Window's client geometry has changed.
* `frameGeometryAboutToChange()`: This signal is emitted when the frame geometry is about to change. the new geometry is not known yet
* `visibleGeometryChanged()`: This signal is emitted when the visible geometry has changed.
* `tileChanged(KWin::Tile *tile)`: This signal is emitted when associated tile has changed, including from and to none
* `fullScreenChanged()`
* `skipTaskbarChanged()`
* `skipPagerChanged()`
* `skipSwitcherChanged()`
* `iconChanged()`
* `activeChanged()`
* `keepAboveChanged(bool)`
* `keepBelowChanged(bool)`
* `demandsAttentionChanged()`: Emitted whenever the demands attention state changes.
* `desktopsChanged()`
* `activitiesChanged()`
* `minimizedChanged()`
* `paletteChanged(const QPalette &p)`
* `colorSchemeChanged()`
* `captionChanged()`
* `captionNormalChanged()`
* `maximizedAboutToChange(MaximizeMode mode)`
* `maximizedChanged()`
* `transientChanged()`
* `modalChanged()`
* `quickTileModeChanged()`
* `moveResizedChanged()`
* `moveResizeCursorChanged(CursorShape)`
* `interactiveMoveResizeStarted()`
* `interactiveMoveResizeStepped(const QRectF &geometry)`
* `interactiveMoveResizeFinished()`
* `closeableChanged(bool)`
* `minimizeableChanged(bool)`
* `shadeableChanged(bool)`
* `maximizeableChanged(bool)`
* `desktopFileNameChanged()`
* `applicationMenuChanged()`
* `hasApplicationMenuChanged(bool)`
* `applicationMenuActiveChanged(bool)`
* `unresponsiveChanged(bool)`
* `decorationChanged()`
* `hiddenChanged()`
* `hiddenByShowDesktopChanged()`
* `lockScreenOverlayChanged()`
* `readyForPaintingChanged()`
* `maximizeGeometryRestoreChanged()`
* `fullscreenGeometryRestoreChanged()`

### Functions

* `closeWindow()=0`
* `setMaximize(bool vertically, bool horizontally)`: Sets the maximization according to vertically and horizontally.

## KWin::TileManager

### Read-only Properties

* `KWin::Tile *` `rootTile`
* `TileModel *` `model`

### Signals

* `tileRemoved(KWin::Tile *tile)`

### Functions

* `KWin::Tile *` `bestTileForPosition(qreal x, qreal y)`

## KWin::Tile

### Enums

#### LayoutDirection

* `Floating`:
* `Horizontal`:
* `Vertical`:

### Read-only Properties

* `QRectF` `absoluteGeometry`
* `QRectF` `absoluteGeometryInScreen`
* `int` `positionInLayout`
* `Tile *` `parent`
* `QList< KWin::Tile * >` `tiles`
* `QList< KWin::Window * >` `windows`
* `bool` `isLayout`
* `bool` `canBeRemoved`

### Read-write Properties

* `QRectF` `relativeGeometry`
* `qreal` `padding`

### Signals

* `relativeGeometryChanged()`
* `absoluteGeometryChanged()`
* `windowGeometryChanged()`
* `paddingChanged(qreal padding)`
* `rowChanged(int row)`
* `isLayoutChanged(bool isLayout)`
* `childTilesChanged()`
* `windowAdded(Window *window)`
* `windowRemoved(Window *window)`
* `windowsChanged()`

### Functions

* `resizeByPixels(qreal delta, Qt::Edge edge)`

## GlobalMethods and properties added to the global JavaScript object in scriptd effects.

### Read-only Properties

* `KWin::EffectsHandler` `effects`: Global property to the core wrapper of KWin Effects
* `KWin::ScriptedEffect` `effect`: Global property to the actual Effect
* `object` `Effect`: Provides access to enums defined in KWin::AnimationEffect and KWin::ScriptedEffect
* `object` `KWin`: Provides access to enums defined in KWin::WorkspaceWrapper
* `object` `QEasingCurve`: Provides access to enums defined in QEasingCurve

### Functions

* `QList<quint64>` `animate(settings)`: Schedules one or many animations for one window. The animations are defined through the settings object providing a more declarative way to specify the animations than the animate call on the effect object. The settings object supports the following attributes: <syntaxhighlight lang="javascript"> { window: EffectWindow, /* the window to animate, required */ duration: int, /* duration in msec, required */ curve: QEasingCurve.Type, /* global easing curve, optional */ type: Effect.Attribute, /* for first animation, optional */ from: FPx2, /* for first animation, optional */ to: FPx2, /* for first animation, optional */ delay: int, /* for first animation, optional */ shader: int, /* for first animation, optional */ animations: [ /* additional animations, optional */ { curve: QEasingCurve.Type, /* overrides global */ type: Effect.Attribute, from: FPx2, to: FPx2, delay: int, shader: int } ] } </syntaxhighlight> At least one animation or attribute setter (see below) needs to be specified either with the top-level properties or in the animations list.
* `QList<quint64>` `set(settings)`: Like animate, just that the manipulation does not implicitly end with the animation. You have to explicitly cancel it. Until then, the manipulated attribute will remain at animation target value.
* `bool` `cancel(QList<quint64>)`: Cancel one or more present animations caused and returned by KWin::ScriptedEffect::animate or KWin::ScriptedEffect::set. For convenience you can pass a single quint64 as well.
* `print(QVariant ... values)`: Prints all provided values to kDebug and as a D-Bus signal
* `int` `animationTime(int duration)`: Adjusts the passed in duration to the global animation time facator.
* `int` `displayWidth()`: Width of the complete display (all screens).
* `int` `displayHeight()`: Height of the complete display (all screens).
* `bool` `registerScreenEdge(ElectricBorder border, QScriptValue callback)`: Registers the callback for the screen edge. When the mouse gets pushed against the given edge the callback will be invoked.
* `bool` `registerShortcut(QString title, QString text, QString keySequence, QScriptValue callback)`: Registers keySequence as a global shortcut. When the shortcut is invoked the callback will be called. Title and text are used to name the shortcut and make it available to the global shortcut configuration module.
* `uint` `addFragmentShader(ShaderTrait traits, QString fragmentShaderFile)`: Creates a shader and returns an identifier which can be used in animate or set. The shader sources must be provided in the shaders sub-directory of the contents package directory. The fragment shader needs to have the file extension frag. Each shader should be provided in a GLSL 1.10 and GLSL 1.40 variant. The 1.40 variant needs to have a suffix _core. E.g. there should be a shader myCustomShader.frag and myCustomShader_core.frag. The vertex shader is generated from the ShaderTrait. The ShaderTrait enum can be used as flags in this method.
* `uint` `setUniform(uint shaderId, QString name, QJSValue value)`: Updates the uniform value of the uniform identified by @p name for the shader identified by @p shaderId. The @p value can be a floating point numeric value (integer uniform values are not supported), an array with either 2, 3 or 4 numeric values, a string to identify a color or a variant value to identify a color as returned by readConfig. This method can be used to update the state of the shader when the configuration of the effect changed.

### Functions

## KWin::EffectsHandlerManager class that handles all the effects.

### Enums

#### OnScreenMessageHideFlag
* `SkipsCloseAnimation`: The on-screen-message should skip the close window animation. EffectWindow::skipsCloseAnimation

### Read-only Properties

* `QStringList` `activeEffects`
* `QStringList` `loadedEffects`
* `QStringList` `listOfEffects`
* `QString` `currentActivity`
* `QSize` `desktopGridSize`
* `int` `desktopGridWidth`
* `int` `desktopGridHeight`
* `int` `workspaceWidth`
* `int` `workspaceHeight`
* `QList< KWin::VirtualDesktop * >` `desktops`
* `bool` `optionRollOverDesktops`
* `KWin::Output *` `activeScreen`
* `qreal` `animationTimeFactor`: Factor by which animation speed in the effect should be modified (multiplied). If configurable in the effect itself, the option should have also 'default' animation speed. The actual value should be determined using animationTime(). Note: The factor can be also 0, so make sure your code can cope with 0ms time if used manually.
* `QList< EffectWindow * >` `stackingOrder`
* `bool` `decorationsHaveAlpha`: Whether window decorations use the alpha channel.
* `CompositingType` `compositingType`
* `QPointF` `cursorPos`
* `QSize` `virtualScreenSize`
* `QRect` `virtualScreenGeometry`
* `bool` `hasActiveFullScreenEffect`
* `KWin::SessionState` `sessionState`: The status of the session i.e if the user is logging out 5.18
* `KWin::EffectWindow *` `inputPanel`

### Read-write Properties

* `KWin::VirtualDesktop *` `currentDesktop`
* `KWin::EffectWindow *` `activeWindow`

### Signals

* `screenAdded(KWin::Output *screen)`: This signal is emitted whenever a new screen is added to the system.
* `screenRemoved(KWin::Output *screen)`: This signal is emitted whenever a screen is removed from the system.
* `desktopChanged(KWin::VirtualDesktop *oldDesktop, KWin::VirtualDesktop *newDesktop, KWin::EffectWindow *with)`: Signal emitted when the current desktop changed. oldDesktop The previously current desktop newDesktop The new current desktop with The window which is taken over to the new desktop, can be NULL 4.9
* `desktopChanging(KWin::VirtualDesktop *currentDesktop, QPointF offset, KWin::EffectWindow *with)`: Signal emmitted while desktop is changing for animation. currentDesktop The current desktop untiotherwise. offset The current desktop offset. offset.x() = .6 means 60% of the way to the desktop to the right. Positive Values means Up and Right.
* `desktopChangingCancelled()`
* `desktopAdded(KWin::VirtualDesktop *desktop)`
* `desktopRemoved(KWin::VirtualDesktop *desktop)`
* `desktopGridSizeChanged(const QSize &size)`: Emitted when the virtual desktop grid layout changes size new size 5.25
* `desktopGridWidthChanged(int width)`: Emitted when the virtual desktop grid layout changes width new width 5.25
* `desktopGridHeightChanged(int height)`: Emitted when the virtual desktop grid layout changes height new height 5.25
* `showingDesktopChanged(bool)`: Signal emitted when the desktop showing ("dashboard") state changed The desktop is risen to the keepAbove layer, you may want to elevate windows or such. 5.3
* `windowAdded(KWin::EffectWindow *w)`: Signal emitted when a new window has been added to the Workspace. w The added window 4.7
* `windowClosed(KWin::EffectWindow *w)`: Signal emitted when a window is being removed from the Workspace. An effect which wants to animate the window closing should connect to this signal and reference the window by using refWindow w The window which is being closed 4.7
* `windowActivated(KWin::EffectWindow *w)`: Signal emitted when a window get's activated. w The new active window, or NULL if there is no active window. 4.7
* `windowDeleted(KWin::EffectWindow *w)`: Signal emitted when a window is deleted. This means that a closed window is not referenced any more. An effect bookkeeping the closed windows should connect to this signal to clean up the internal references. w The window which is going to be deleted. EffectWindow::refWindow EffectWindow::unrefWindow windowClosed 4.7
* `tabBoxAdded(int mode)`: Signal emitted when a tabbox is added. An effect who wants to replace the tabbox with itself should use refTabBox. mode The TabBoxMode. refTabBox tabBoxClosed tabBoxUpdated tabBoxKeyEvent 4.7
* `tabBoxClosed()`: Signal emitted when the TabBox was closed by KWin core. An effect which referenced the TabBox should use unrefTabBox to unref again. unrefTabBox tabBoxAdded 4.7
* `tabBoxUpdated()`: Signal emitted when the selected TabBox window changed or the TabBox List changed. An effect should only response to this signal if it referenced the TabBox with refTabBox. refTabBox currentTabBoxWindowList currentTabBoxDesktopList currentTabBoxWindow currentTabBoxDesktop 4.7
* `tabBoxKeyEvent(QKeyEvent *event)`: Signal emitted when a key event, which is not handled by TabBox directly is, happens while TabBox is active. An effect might use the key event to e.g. change the selected window. An effect should only response to this signal if it referenced the TabBox with refTabBox. event The key event not handled by TabBox directly refTabBox 4.7
* `mouseChanged(const QPointF &pos, const QPointF &oldpos, Qt::MouseButtons buttons, Qt::MouseButtons oldbuttons, Qt::KeyboardModifiers modifiers, Qt::KeyboardModifiers oldmodifiers)`: Signal emitted when mouse changed. If an effect needs to get updated mouse positions, it needs to first call startMousePolling. For a fullscreen effect it is better to use an input window and react on windowInputMouseEvent. pos The new mouse position oldpos The previously mouse position buttons The pressed mouse buttons oldbuttons The previously pressed mouse buttons modifiers Pressed keyboard modifiers oldmodifiers Previously pressed keyboard modifiers. startMousePolling 4.7
* `cursorShapeChanged()`: Signal emitted when the cursor shape changed. You'll likely want to query the current cursor as reaction: xcb_xfixes_get_cursor_image_unchecked Connection to this signal is tracked, so if you don't need it anymore, disconnect from it to stop cursor event filtering
* `propertyNotify(KWin::EffectWindow *w, long atom)`: Receives events registered for using registerPropertyType. Use readProperty() to get the property data. Note that the property may be already set on the window, so doing the same processing from windowAdded() (e.g. simply calling propertyNotify() from it) is usually needed. w The window whose property changed, is null if it is a root window property atom The property 4.7
* `currentActivityChanged(const QString &id)`: This signal is emitted when the global activity is changed id id of the new current activity 4.9
* `activityAdded(const QString &id)`: This signal is emitted when a new activity is added id id of the new activity 4.9
* `activityRemoved(const QString &id)`: This signal is emitted when the activity is removed id id of the removed activity 4.9
* `screenLockingChanged(bool locked)`: This signal is emitted when the screen got locked or unlocked. locked true if the screen is now locked, false if it is now unlocked 4.11
* `screenAboutToLock()`: This signal is emitted just before the screen locker tries to grab keys and lock the screen Effects should release any grabs immediately 5.17
* `stackingOrderChanged()`: This signels is emitted when ever the stacking order is change, ie. a window is risen or lowered 4.10
* `screenEdgeApproaching(ElectricBorder border, qreal factor, const QRect &geometry)`: This signal is emitted when the user starts to approach the border with the mouse. The factor describes how far away the mouse is in a relative mean. The values are in [0.0, 1.0] with 0.0 being emitted when first entered and on leaving. The value 1.0 means that the border is reached with the mouse. So the values are well suited for animations. The signal is always emitted when the mouse cursor position changes. border The screen edge which is being approached factor Value in range [0.0,1.0] to describe how close the mouse is to the border geometry The geometry of the edge which is being approached 4.11
* `virtualScreenSizeChanged()`: Emitted whenever the virtualScreenSize changes. virtualScreenSize() 5.0
* `virtualScreenGeometryChanged()`: Emitted whenever the virtualScreenGeometry changes. virtualScreenGeometry() 5.0
* `windowDataChanged(KWin::EffectWindow *w, int role)`: This signal gets emitted when the data on EffectWindow w for role changed. An Effect can connect to this signal to read the new value and react on it. E.g. an Effect which does not operate on windows grabbed by another Effect wants to cancel the already scheduled animation if another Effect adds a grab. w The EffectWindow for which the data changed role The data role which changed EffectWindow::setData EffectWindow::data 5.8.4
* `xcbConnectionChanged()`: The xcb connection changed, either a new xcbConnection got created or the existing one got destroyed. Effects can use this to refetch the properties they want to set. When the xcbConnection changes also the x11RootWindow becomes invalid. xcbConnection x11RootWindow 5.11
* `activeFullScreenEffectChanged()`: This signal is emitted when active fullscreen effect changed. activeFullScreenEffect setActiveFullScreenEffect 5.14
* `hasActiveFullScreenEffectChanged()`: This signal is emitted when active fullscreen effect changed to being set or unset activeFullScreenEffect setActiveFullScreenEffect 5.15
* `sessionStateChanged()`: This signal is emitted when the session state was changed 5.18
* `startupAdded(const QString &id, const QIcon &icon)`
* `startupChanged(const QString &id, const QIcon &icon)`
* `startupRemoved(const QString &id)`
* `inputPanelChanged()`

### Functions

* `reconfigureEffect(const QString &name)`
* `bool` `loadEffect(const QString &name)`
* `toggleEffect(const QString &name)`
* `unloadEffect(const QString &name)`
* `bool` `isEffectLoaded(const QString &name) const`
* `bool` `isEffectSupported(const QString &name)`
* `QList< bool >` `areEffectsSupported(const QStringList &names)`
* `QString` `supportInformation(const QString &name) const`
* `QString` `debug(const QString &name, const QString &parameter=QString()) const`
* `moveWindow(KWin::EffectWindow *w, const QPoint &pos, bool snap=false, double snapAdjust=1.0)`
* `windowToDesktops(KWin::EffectWindow *w, const QList< KWin::VirtualDesktop * > &desktops)`: Moves a window to the given desktops On X11, the window will end up on the last window in the list Setting this to an empty list will set the window on all desktops
* `windowToScreen(KWin::EffectWindow *w, Output *screen)`
* `KWin::VirtualDesktop *` `desktopAbove(KWin::VirtualDesktop *desktop=nullptr, bool wrap=true) const`: The desktop above the given desktop. Wraps around to the bottom of the layout if wrap is set. If id is not set use the current one.
* `KWin::VirtualDesktop *` `desktopToRight(KWin::VirtualDesktop *desktop=nullptr, bool wrap=true) const`: The desktop to the right of the given desktop. Wraps around to the left of the layout if wrap is set. If id is not set use the current one.
* `KWin::VirtualDesktop *` `desktopBelow(KWin::VirtualDesktop *desktop=nullptr, bool wrap=true) const`: The desktop below the given desktop. Wraps around to the top of the layout if wrap is set. If id is not set use the current one.
* `KWin::VirtualDesktop *` `desktopToLeft(KWin::VirtualDesktop *desktop=nullptr, bool wrap=true) const`: The desktop to the left of the given desktop. Wraps around to the right of the layout if wrap is set. If id is not set use the current one.
* `QString` `desktopName(KWin::VirtualDesktop *desktop) const`
* `KWin::EffectWindow *` `findWindow(WId id) const`
* `KWin::EffectWindow *` `findWindow(SurfaceInterface *surf) const`
* `KWin::EffectWindow *` `findWindow(QWindow *w) const`: Finds the EffectWindow for the internal window w. If there is no such window null is returned. On Wayland this returns the internal window. On X11 it returns an Unamanged with the window id matching that of the provided window w. 5.16
* `KWin::EffectWindow *` `findWindow(const QUuid &id) const`: Finds the EffectWindow for the Window with KWin internal id. If there is no such window null is returned. 5.16
* `setElevatedWindow(KWin::EffectWindow *w, bool set)`
* `addRepaintFull()`: Schedules the entire workspace to be repainted next time. If you call it during painting (including prepaint) then it does not affect the current painting.
* `addRepaint(const QRectF &r)`
* `addRepaint(const QRect &r)`
* `addRepaint(const QRegion &r)`
* `addRepaint(int x, int y, int w, int h)`

## KWin::EffectWindow Representation of a window used by/for Effect classes.

### Enums

####
* `PAINT_DISABLED`: Window will not be painted
* `PAINT_DISABLED_BY_DESKTOP`: Window will not be painted because of which desktop it's on
* `PAINT_DISABLED_BY_MINIMIZE`: Window will not be painted because it is minimized
* `PAINT_DISABLED_BY_ACTIVITY`: Window will not be painted because it's not on the current activity

### Read-only Properties

* `QRectF` `geometry`
* `QRectF` `expandedGeometry`
* `qreal` `height`
* `qreal` `opacity`
* `QPointF` `pos`
* `KWin::Output *` `screen`
* `QSizeF` `size`
* `qreal` `width`
* `qreal` `x`
* `qreal` `y`
* `QList< KWin::VirtualDesktop * >` `desktops`
* `bool` `onAllDesktops`
* `bool` `onCurrentDesktop`
* `QRectF` `rect`
* `QString` `windowClass`
* `QString` `windowRole`
* `bool` `desktopWindow`: Returns whether the window is a desktop background window (the one with wallpaper). See _NET_WM_WINDOW_TYPE_DESKTOP at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dock`: Returns whether the window is a dock (i.e. a panel). See _NET_WM_WINDOW_TYPE_DOCK at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `toolbar`: Returns whether the window is a standalone (detached) toolbar window. See _NET_WM_WINDOW_TYPE_TOOLBAR at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `menu`: Returns whether the window is a torn-off menu. See _NET_WM_WINDOW_TYPE_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `normalWindow`: Returns whether the window is a "normal" window, i.e. an application or any other window for which none of the specialized window types fit. See _NET_WM_WINDOW_TYPE_NORMAL at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dialog`: Returns whether the window is a dialog window. See _NET_WM_WINDOW_TYPE_DIALOG at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `splash`: Returns whether the window is a splashscreen. Note that many (especially older) applications do not support marking their splash windows with this type. See _NET_WM_WINDOW_TYPE_SPLASH at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `utility`: Returns whether the window is a utility window, such as a tool window. See _NET_WM_WINDOW_TYPE_UTILITY at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dropdownMenu`: Returns whether the window is a dropdown menu (i.e. a popup directly or indirectly open from the applications menubar). See _NET_WM_WINDOW_TYPE_DROPDOWN_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `popupMenu`: Returns whether the window is a popup menu (that is not a torn-off or dropdown menu). See _NET_WM_WINDOW_TYPE_POPUP_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `tooltip`: Returns whether the window is a tooltip. See _NET_WM_WINDOW_TYPE_TOOLTIP at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `notification`: Returns whether the window is a window with a notification. See _NET_WM_WINDOW_TYPE_NOTIFICATION at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `criticalNotification`: Returns whether the window is a window with a critical notification. using the non-standard _KDE_NET_WM_WINDOW_TYPE_CRITICAL_NOTIFICATION
* `bool` `onScreenDisplay`: Returns whether the window is an on screen display window using the non-standard _KDE_NET_WM_WINDOW_TYPE_ON_SCREEN_DISPLAY
* `bool` `comboBox`: Returns whether the window is a combobox popup. See _NET_WM_WINDOW_TYPE_COMBO at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `dndIcon`: Returns whether the window is a Drag&Drop icon. See _NET_WM_WINDOW_TYPE_DND at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `int` `windowType`: Returns the NETWM window type See https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `deleted`: Whether this EffectWindow represents an already deleted window and only kept for the compositor for animations.
* `QString` `caption`: The Caption of the window. Read from WM_NAME property together with a suffix for hostname and shortcut.
* `bool` `keepAbove`: Whether the window is set to be kept above other windows.
* `bool` `keepBelow`: Whether the window is set to be kept below other windows.
* `bool` `modal`: Whether the window represents a modal window.
* `bool` `moveable`: Whether the window is moveable. Even if it is not moveable, it might be possible to move it to another screen. moveableAcrossScreens
* `bool` `moveableAcrossScreens`: Whether the window can be moved to another screen. moveable
* `QSizeF` `basicUnit`: By how much the window wishes to grow/shrink at least. Usually QSize(1,1). MAY BE DISOBEYED BY THE WM! It's only for information, do NOT rely on it at all.
* `bool` `move`: Whether the window is currently being moved by the user.
* `bool` `resize`: Whether the window is currently being resized by the user.
* `QRectF` `iconGeometry`: The optional geometry representing the minimized Client in e.g a taskbar. See _NET_WM_ICON_GEOMETRY at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html .
* `bool` `specialWindow`: Returns whether the window is any of special windows types (desktop, dock, splash, ...), i.e. window types that usually don't have a window frame and the user does not use window management (moving, raising,...) on them.
* `QIcon` `icon`
* `bool` `skipSwitcher`: Whether the window should be excluded from window switching effects.
* `QRectF` `contentsRect`: Geometry of the actual window contents inside the whole (including decorations) window.
* `QRectF` `decorationInnerRect`: Geometry of the transparent rect in the decoration. May be different from contentsRect if the decoration is extended into the client area.
* `bool` `hasDecoration`
* `QStringList` `activities`
* `bool` `onCurrentActivity`
* `bool` `onAllActivities`
* `bool` `decorationHasAlpha`: Whether the decoration currently uses an alpha channel. 4.10
* `bool` `visible`: Whether the window is currently visible to the user, that is: Not minimized On current desktop On current activity 4.11
* `bool` `skipsCloseAnimation`: Whether the window does not want to be animated on window close. In case this property is true it is not useful to start an animation on window close. The window will not be visible, but the animation hooks are executed. 5.0
* `bool` `fullScreen`: Whether the window is fullscreen. 5.6
* `bool` `unresponsive`: Whether this client is unresponsive. When an application failed to react on a ping request in time, it is considered unresponsive. This usually indicates that the application froze or crashed. 5.10
* `bool` `waylandClient`: Whether this is a Wayland client. 5.15
* `bool` `x11Client`: Whether this is an X11 client. 5.15
* `bool` `popupWindow`: Whether the window is a popup. A popup is a window that can be used to implement tooltips, combo box popups, popup menus and other similar user interface concepts. 5.15
* `QWindow *` `internalWindow`: KWin internal window. Specific to Wayland platform. If the EffectWindow does not reference an internal window, this property is null. 5.16
* `bool` `outline`: Whether this EffectWindow represents the outline. When compositing is turned on, the outline is an actual window. 5.16
* `pid_t` `pid`: The PID of the application this window belongs to. 5.18
* `bool` `lockScreen`: Whether this EffectWindow represents the screenlocker greeter. 5.22
* `bool` `hiddenByShowDesktop`: Whether this EffectWindow is hidden because the show desktop mode is active.

### Read-write Properties

* `bool` `minimized`: Whether the window is minimized.

### Signals

* `windowStartUserMovedResized(KWin::EffectWindow *w)`: Signal emitted when a user begins a window move or resize operation. To figure out whether the user resizes or moves the window use isUserMove or isUserResize. Whenever the geometry is updated the signal windowStepUserMovedResized is emitted with the current geometry. The move/resize operation ends with the signal windowFinishUserMovedResized. Only one window can be moved/resized by the user at the same time! w The window which is being moved/resized windowStepUserMovedResized windowFinishUserMovedResized EffectWindow::isUserMove EffectWindow::isUserResize
* `windowStepUserMovedResized(KWin::EffectWindow *w, const QRectF &geometry)`: Signal emitted during a move/resize operation when the user changed the geometry. Please note: KWin supports two operation modes. In one mode all changes are applied instantly. This means the window's geometry matches the passed in geometry. In the other mode the geometry is changed after the user ended the move/resize mode. The geometry differs from the window's geometry. Also the window's pixmap still has the same size as before. Depending what the effect wants to do it would be recommended to scale/translate the window. w The window which is being moved/resized geometry The geometry of the window in the current move/resize step. windowStartUserMovedResized windowFinishUserMovedResized EffectWindow::isUserMove EffectWindow::isUserResize
* `windowFinishUserMovedResized(KWin::EffectWindow *w)`: Signal emitted when the user finishes move/resize of window w. w The window which has been moved/resized windowStartUserMovedResized windowFinishUserMovedResized
* `windowMaximizedStateChanged(KWin::EffectWindow *w, bool horizontal, bool vertical)`: Signal emitted when the maximized state of the window w changed. A window can be in one of four states: restored: both horizontal and vertical are false horizontally maximized: horizontal is true and vertical is false vertically maximized: horizontal is false and vertical is true completely maximized: both horizontal and vertical are true w The window whose maximized state changed horizontal If true maximized horizontally vertical If true maximized vertically
* `windowMaximizedStateAboutToChange(KWin::EffectWindow *w, bool horizontal, bool vertical)`: Signal emitted when the maximized state of the window w is about to change, but before windowMaximizedStateChanged is emitted or any geometry change. Useful for OffscreenEffect to grab a window image before any actual change happens A window can be in one of four states: restored: both horizontal and vertical are false horizontally maximized: horizontal is true and vertical is false vertically maximized: horizontal is false and vertical is true completely maximized: both horizontal and vertical are true w The window whose maximized state changed horizontal If true maximized horizontally vertical If true maximized vertically
* `windowFrameGeometryChanged(KWin::EffectWindow *window, const QRectF &oldGeometry)`: This signal is emitted when the frame geometry of a window changed. window The window whose geometry changed oldGeometry The previous geometry
* `windowFrameGeometryAboutToChange(KWin::EffectWindow *window)`: This signal is emitted when the frame geometry is about to change, the new one is not known yet. Useful for OffscreenEffect to grab a window image before any actual change happens. window The window whose geometry is about to change
* `windowOpacityChanged(KWin::EffectWindow *w, qreal oldOpacity, qreal newOpacity)`: Signal emitted when the windows opacity is changed. w The window whose opacity level is changed. oldOpacity The previous opacity level newOpacity The new opacity level
* `minimizedChanged(KWin::EffectWindow *w)`: Signal emitted when a window is minimized or unminimized. w The window whose minimized state has changed
* `windowModalityChanged(KWin::EffectWindow *w)`: Signal emitted when a window either becomes modal (ie. blocking for its main client) or looses that state. w The window which was unminimized
* `windowUnresponsiveChanged(KWin::EffectWindow *w, bool unresponsive)`: Signal emitted when a window either became unresponsive (eg. app froze or crashed) or respoonsive w The window that became (un)responsive unresponsive Whether the window is responsive or unresponsive
* `windowDamaged(KWin::EffectWindow *w)`: Signal emitted when an area of a window is scheduled for repainting. Use this signal in an effect if another area needs to be synced as well. w The window which is scheduled for repainting
* `windowKeepAboveChanged(KWin::EffectWindow *w)`: This signal is emitted when the keep above state of w was changed. w The window whose the keep above state was changed.
* `windowKeepBelowChanged(KWin::EffectWindow *w)`: This signal is emitted when the keep below state of was changed. w The window whose the keep below state was changed.
* `windowFullScreenChanged(KWin::EffectWindow *w)`: This signal is emitted when the full screen state of w was changed. w The window whose the full screen state was changed.
* `windowDecorationChanged(KWin::EffectWindow *window)`: This signal is emitted when decoration of was changed. w The window for which decoration changed
* `windowExpandedGeometryChanged(KWin::EffectWindow *window)`: This signal is emitted when the visible geometry of a window changed.
* `windowDesktopsChanged(KWin::EffectWindow *window)`: This signal is emitted when a window enters or leaves a virtual desktop.
* `windowShown(KWin::EffectWindow *w)`: The window w gets shown again. The window was previously initially shown with windowAdded and hidden with windowHidden. windowHidden windowAdded
* `windowHidden(KWin::EffectWindow *w)`: The window w got hidden but not yet closed. This can happen when a window is still being used and is supposed to be shown again with windowShown. On X11 an example is autohiding panels. On Wayland every window first goes through the window hidden state and might get shown again, or might get closed the normal way. windowShown windowClosed

### Functions

* `addRepaint(const QRect &r)`
* `addRepaint(int x, int y, int w, int h)`
* `addRepaintFull()`
* `addLayerRepaint(const QRect &r)`
* `addLayerRepaint(int x, int y, int w, int h)`
* `bool` `isOnActivity(const QString &id) const`
* `bool` `isOnDesktop(KWin::VirtualDesktop *desktop) const`
* `KWin::EffectWindow *` `findModal()`
* `KWin::EffectWindow *` `transientFor()`
* `QList< KWin::EffectWindow * >` `mainWindows() const`
* `closeWindow()`
* `setData(int role, const QVariant &data)`: Can be used to by effects to store arbitrary data in the EffectWindow. Invoking this method will emit the signal EffectsHandler::windowDataChanged. EffectsHandler::windowDataChanged
* `QVariant` `data(int role) const`

## KWin::AnimationEffect

### Enums

#### Anchor
* `Left`:
* `Top`:
* `Right`:
* `Bottom`:
* `Horizontal`:
* `Vertical`:
* `Mouse`:

#### Attribute
* `Opacity`:
* `Brightness`:
* `Saturation`:
* `Scale`:
* `Rotation`:
* `Position`:
* `Size`:
* `Translation`:
* `Clip`:
* `Generic`:
* `CrossFadePrevious`:
* `Shader`: Performs an animation with a provided shader. The float uniform animationProgress is set to the current progress of the animation.
* `ShaderUniform`: Like Shader, but additionally allows to animate a float uniform passed to the shader. The uniform location must be provided as metadata.
* `NonFloatBase`:

#### MetaType
* `SourceAnchor`:
* `TargetAnchor`:
* `RelativeSourceX`:
* `RelativeSourceY`:
* `RelativeTargetX`:
* `RelativeTargetY`:
* `Axis`:

#### Direction

* `Forward`:
* `Backward`:

#### TerminationFlag

* `DontTerminate`: Don't terminate the animation when it reaches source or target position.
* `TerminateAtSource`: Terminate the animation when it reaches the source position. An animation can reach the source position if its direction was changed to go backward (from target to source).
* `TerminateAtTarget`: Terminate the animation when it reaches the target position. If this flag is not set, then the animation will be persistent.

### Functions

## KWin::ScriptedEffect

### Enums

#### DataRole

* `WindowAddedGrabRole`:
* `WindowClosedGrabRole`:
* `WindowMinimizedGrabRole`:
* `WindowUnminimizedGrabRole`:
* `WindowForceBlurRole`:
* `WindowBlurBehindRole`:
* `WindowForceBackgroundContrastRole`:
* `WindowBackgroundContrastRole`:

#### EasingCurve

* `GaussianCurve`:

#### ShaderTrait

* `MapTexture`:
* `UniformColor`:
* `Modulate`:
* `AdjustSaturation`:

### Read-only Properties

* `QString` `pluginId`: The plugin ID of the effect
* `bool` `isActiveFullScreenEffect`: True if we are the active fullscreen effect

### Signals

* `configChanged()`: Signal emitted whenever the effect's config changed.
* `animationEnded(KWin::EffectWindow *w, quint64 animationId)`
* `isActiveFullScreenEffectChanged()`

### Functions

* `bool` `borderActivated(ElectricBorder border) override`
* `bool` `isGrabbed(KWin::EffectWindow *w, DataRole grabRole)`: Whether another effect has grabbed the w with the given grabRole. w The window to check grabRole The grab role to check true if another window has grabbed the effect, false otherwise
* `bool` `grab(KWin::EffectWindow *w, DataRole grabRole, bool force=false)`: Grabs the window with the specified role. w The window. grabRole The grab role. force By default, if the window is already grabbed by another effect, then that window won't be grabbed by effect that called this method. If you would like to grab a window even if it's grabbed by another effect, then pass true. true if the window was grabbed successfully, otherwise false.
* `bool` `ungrab(KWin::EffectWindow *w, DataRole grabRole)`: Ungrabs the window with the specified role. w The window. grabRole The grab role. true if the window was ungrabbed successfully, otherwise false.
* `QJSValue` `readConfig(const QString &key, const QJSValue &defaultValue=QJSValue())`: Reads the value from the configuration data for the given key. key The key to search for defaultValue The value to return if the key is not found The config value if present
* `int` `displayWidth() const`
* `int` `displayHeight() const`
* `int` `animationTime(int defaultTime) const`
* `registerShortcut(const QString &objectName, const QString &text, const QString &keySequence, const QJSValue &callback)`
* `bool` `registerScreenEdge(int edge, const QJSValue &callback)`
* `bool` `registerRealtimeScreenEdge(int edge, const QJSValue &callback)`
* `bool` `unregisterScreenEdge(int edge)`
* `bool` `registerTouchScreenEdge(int edge, const QJSValue &callback)`
* `bool` `unregisterTouchScreenEdge(int edge)`
* `quint64` `animate(KWin::EffectWindow *window, Attribute attribute, int ms, const QJSValue &to, const QJSValue &from=QJSValue(), uint metaData=0, int curve=QEasingCurve::Linear, int delay=0, bool fullScreen=false, bool keepAlive=true, uint shaderId=0)`
* `QJSValue` `animate(const QJSValue &object)`
* `quint64` `set(KWin::EffectWindow *window, Attribute attribute, int ms, const QJSValue &to, const QJSValue &from=QJSValue(), uint metaData=0, int curve=QEasingCurve::Linear, int delay=0, bool fullScreen=false, bool keepAlive=true, uint shaderId=0)`
* `QJSValue` `set(const QJSValue &object)`
* `bool` `retarget(quint64 animationId, const QJSValue &newTarget, int newRemainingTime=-1)`
* `bool` `retarget(const QList< quint64 > &animationIds, const QJSValue &newTarget, int newRemainingTime=-1)`
* `bool` `freezeInTime(quint64 animationId, qint64 frozenTime)`
* `bool` `freezeInTime(const QList< quint64 > &animationIds, qint64 frozenTime)`
* `bool` `redirect(quint64 animationId, Direction direction, TerminationFlags terminationFlags=TerminateAtSource)`
* `bool` `redirect(const QList< quint64 > &animationIds, Direction direction, TerminationFlags terminationFlags=TerminateAtSource)`
* `bool` `complete(quint64 animationId)`
* `bool` `complete(const QList< quint64 > &animationIds)`
* `bool` `cancel(quint64 animationId)`
* `bool` `cancel(const QList< quint64 > &animationIds)`
* `QList< int >` `touchEdgesForAction(const QString &action) const`
* `uint` `addFragmentShader(ShaderTrait traits, const QString &fragmentShaderFile={})`
* `setUniform(uint shaderId, const QString &name, const QJSValue &value)`
