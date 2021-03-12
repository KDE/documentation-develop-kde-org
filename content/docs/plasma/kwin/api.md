---
title: KWin Scripting API
---

This page describes the KWin Scripting API as of KWin 5.21. It has been generated using https://invent.kde.org/nicolasfella/kwin-scripting-api-generator

## Global

Methods and properties added to the global JavaScript object.

### Read-only Properties

* `KWin::Options options`: Global property to all configuration values of KWin core.
* `KWin::Workspace workspace`: Global property to the core wrapper of KWin.
* `object KWin`: Provides access to enums defined in KWin::WorkspaceWrapper
### Functions

* `print(QVariant ... values)`: Prints all provided values to kDebug and as a D-Bus signal
* `QVariant readConfig(QString key, QVariant defaultValue = QVariant())`: Reads the config value for key in the Script's configuration with the optional default value. If not providing a default value and no value stored in the configuration an undefined value is returned.
* `bool registerScreenEdge(ElectricBorder border, QScriptValue callback)`: Registers the callback for the screen edge. When the mouse gets pushed against the given edge the callback will be invoked. Scripts can also add "X-KWin-Border-Activate" to their metadata file to have the effect listed in the screen edges KCM. This will write an entry BorderConfig= in the script configuration object with a list of ScreenEdges the user has selected.
* `bool unregisterScreenEdge(ElectricBorder border)`: Unregisters the callback for the screen edge. This will disconnect all callbacks from this script to that edge.
* `bool registerShortcut(QString title, QString text, QString keySequence, QScriptValue callback)`: Registers keySequence as a global shortcut. When the shortcut is invoked the callback will be called. Title and text are used to name the shortcut and make it available to the global shortcut configuration module.
* `bool assert(bool value, QString message = QString())`: Aborts the execution of the script if value does not evaluate to true. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertTrue(bool value, QString message = QString())`: Aborts the execution of the script if value does not evaluate to true. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertFalse(bool value, QString message = QString())`: Aborts the execution of the script if value does not evaluate to false. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertEquals(QVariant expected, QVariant actual, QString message = QString())`: Aborts the execution of the script if the actual value is not equal to the expected value. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertNull(QVariant value, QString message = QString())`: Aborts the execution of the script if value is not null. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `bool assertNotNull(QVariant value, QString message = QString())`: Aborts the execution of the script if value is null. If message is provided an error is thrown with the given message, if not provided an error with default message is thrown.
* `callDBus(QString service, QString path, QString interface, QString method, QVariant arg..., QScriptValue callback = QScriptValue())`: Call a D-Bus method at (service, path, interface and method). A variable number of arguments can be added to the method call. The D-Bus call is always performed in an async way invoking the callback provided as the last (optional) argument. The reply values of the D-Bus method call are passed to the callback.
* `registerUserActionsMenu(QScriptValue callback)`: Registers the passed in callback to be invoked whenever the User actions menu (Alt+F3 or right click on window decoration) is about to be shown. The callback is invoked with a reference to the Client for which the menu is shown. The callback can return either a single menu entry to be added to the menu or an own sub menu with multiple entries. The object for a menu entry should be {title: "My Menu entry", checkable: true, checked: false, triggered: function (action) { // callback with triggered QAction}}, for a menu it should be {title: "My menu", items: [{...}, {...}, ...] /*list with entries as described*/}


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

* `QSize desktopGridSize`
* `int desktopGridWidth`
* `int desktopGridHeight`
* `int workspaceWidth`
* `int workspaceHeight`
* `QSize workspaceSize`
* `QSize displaySize`: The same of the display, that is all screens. Deprecatedsince 5.0 use virtualScreenSize
* `int displayWidth`: The width of the display, that is width of all combined screens. Deprecatedsince 5.0 use virtualScreenSize
* `int displayHeight`: The height of the display, that is height of all combined screens. Deprecatedsince 5.0 use virtualScreenSize
* `int activeScreen`
* `int numScreens`
* `QStringList activities`
* `QSize virtualScreenSize`: The bounding size of all screens combined. Overlapping areas are not counted multiple times. virtualScreenGeometry
* `QRect virtualScreenGeometry`: The bounding geometry of all outputs combined. Always starts at (0,0) and has virtualScreenSize as it's size. virtualScreenSize

### Read-write Properties

* `int currentDesktop`
* `KWin::AbstractClient * activeClient`
* `int desktops`: The number of desktops currently used. Minimum number of desktops is 1, maximum 20.
* `QString currentActivity`

### Signals

* `desktopPresenceChanged(KWin::AbstractClient *client, int desktop)`
* `currentDesktopChanged(int desktop, KWin::AbstractClient *client)`
* `clientAdded(KWin::AbstractClient *client)`
* `clientRemoved(KWin::AbstractClient *client)`
* `clientManaging(KWin::X11Client *client)`
* `clientMinimized(KWin::AbstractClient *client)`
* `clientUnminimized(KWin::AbstractClient *client)`
* `clientRestored(KWin::X11Client *client)`
* `clientMaximizeSet(KWin::AbstractClient *client, bool h, bool v)`
* `killWindowCalled(KWin::X11Client *client)`
* `clientActivated(KWin::AbstractClient *client)`
* `clientFullScreenSet(KWin::X11Client *client, bool fullScreen, bool user)`
* `clientSetKeepAbove(KWin::X11Client *client, bool keepAbove)`
* `numberDesktopsChanged(uint oldNumberOfDesktops)`: Signal emitted whenever the number of desktops changed. To get the current number of desktops use the property desktops. oldNumberOfDesktops The previous number of desktops.
* `desktopLayoutChanged()`: Signal emitted whenever the layout of virtual desktops changed. That is desktopGrid(Size/Width/Height) will have new values. 4.11
* `clientDemandsAttentionChanged(KWin::AbstractClient *client, bool set)`: The demands attention state for Client c changed to set. c The Client for which demands attention changed set New value of demands attention
* `numberScreensChanged(int count)`: Signal emitted when the number of screens changes. count The new number of screens
* `screenResized(int screen)`: This signal is emitted when the size of screen changes. Don't forget to fetch an updated client area.
* `currentActivityChanged(const QString &id)`: Signal emitted whenever the current activity changed. id id of the new activity
* `activitiesChanged(const QString &id)`: Signal emitted whenever the list of activities changed. id id of the new activity
* `activityAdded(const QString &id)`: This signal is emitted when a new activity is added id id of the new activity
* `activityRemoved(const QString &id)`: This signal is emitted when the activity is removed id id of the removed activity
* `virtualScreenSizeChanged()`: Emitted whenever the virtualScreenSize changes. virtualScreenSize() 5.0
* `virtualScreenGeometryChanged()`: Emitted whenever the virtualScreenGeometry changes. virtualScreenGeometry() 5.0

### Functions

* `slotSwitchDesktopNext()`
* `slotSwitchDesktopPrevious()`
* `slotSwitchDesktopRight()`
* `slotSwitchDesktopLeft()`
* `slotSwitchDesktopUp()`
* `slotSwitchDesktopDown()`
* `slotSwitchToNextScreen()`
* `slotWindowToNextScreen()`
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
* `slotWindowPackLeft()`
* `slotWindowPackRight()`
* `slotWindowPackUp()`
* `slotWindowPackDown()`
* `slotWindowGrowHorizontal()`
* `slotWindowGrowVertical()`
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
* `sendClientToScreen(KWin::AbstractClient *client, int screen)`: Sends the AbstractClient to the given screen.
* `showOutline(const QRect &geometry)`: Shows an outline at the specified geometry. If an outline is already shown the outline is moved to the new position. Use hideOutline to remove the outline again.
* `showOutline(int x, int y, int width, int height)`: Overloaded method for convenience.
* `hideOutline()`: Hides the outline previously shown by showOutline.
* `QRect clientArea(ClientAreaOption option, int screen, int desktop) const`: Returns the geometry a Client can use with the specified option. This method should be preferred over other methods providing screen sizes as the various options take constraints such as struts set on panels into account. This method is also multi screen aware, but there are also options to get full areas. option The type of area which should be considered screen The screen for which the area should be considered desktop The desktop for which the area should be considered, in general there should not be a difference The specified screen geometry
* `QRect clientArea(ClientAreaOption option, const QPoint &point, int desktop) const`: Overloaded method for convenience. option The type of area which should be considered point The coordinates which have to be included in the area desktop The desktop for which the area should be considered, in general there should not be a difference The specified screen geometry
* `QRect clientArea(ClientAreaOption option, const KWin::AbstractClient *client) const`: Overloaded method for convenience. client The Client for which the area should be retrieved The specified screen geometry
* `QString desktopName(int desktop) const`: Returns the name for the given desktop.
* `createDesktop(int position, const QString &name) const`: Create a new virtual desktop at the requested position. position The position of the desktop. It should be in range [0, count]. name The name for the new desktop, if empty the default name will be used.
* `removeDesktop(int position) const`: Remove the virtual desktop at the requested position position The position of the desktop to be removed. It should be in range [0, count - 1].
* `QString supportInformation() const`: Provides support information about the currently running KWin instance.
* `KWin::X11Client * getClient(qulonglong windowId)`: Finds the Client with the given windowId. windowId The window Id of the Client The found Client or null

## KWin::Options

### Enums

#### FocusPolicy

* `ClickToFocus`: Clicking into a window activates it. This is also the default.
* `FocusFollowsMouse`: Moving the mouse pointer actively onto a normal window activates it. For convenience, the desktop and windows on the dock are excluded. They require clicking.
* `FocusUnderMouse`: The window that happens to be under the mouse pointer becomes active. The invariant is: no window can have focus that is not under the mouse. This also means that Alt-Tab won't work properly and popup dialogs are usually unsable with the keyboard. Note that the desktop and windows on the dock are excluded for convenience. They get focus only when clicking on it.
* `FocusStrictlyUnderMouse`: This is even worse than FocusUnderMouse. Only the window under the mouse pointer is active. If the mouse points nowhere, nothing has the focus. If the mouse points onto the desktop, the desktop has focus. The same holds for windows on the dock.

#### WindowOperation

* `MaximizeOp`:
* `RestoreOp`:
* `MinimizeOp`:
* `MoveOp`:
* `UnrestrictedMoveOp`:
* `ResizeOp`:
* `UnrestrictedResizeOp`:
* `CloseOp`:
* `OnAllDesktopsOp`:
* `ShadeOp`:
* `KeepAboveOp`:
* `KeepBelowOp`:
* `OperationsOp`:
* `WindowRulesOp`:
* `ToggleStoreSettingsOp`:
* `HMaximizeOp`:
* `VMaximizeOp`:
* `LowerOp`:
* `FullScreenOp`:
* `NoBorderOp`:
* `NoOp`:
* `SetupWindowShortcutOp`:
* `ApplicationRulesOp`:

#### MouseCommand

* `MouseRaise`:
* `MouseLower`:
* `MouseOperationsMenu`:
* `MouseToggleRaiseAndLower`:
* `MouseActivateAndRaise`:
* `MouseActivateAndLower`:
* `MouseActivate`:
* `MouseActivateRaiseAndPassClick`:
* `MouseActivateAndPassClick`:
* `MouseMove`:
* `MouseUnrestrictedMove`:
* `MouseActivateRaiseAndMove`:
* `MouseActivateRaiseAndUnrestrictedMove`:
* `MouseResize`:
* `MouseUnrestrictedResize`:
* `MouseShade`:
* `MouseSetShade`:
* `MouseUnsetShade`:
* `MouseMaximize`:
* `MouseRestore`:
* `MouseMinimize`:
* `MouseNextDesktop`:
* `MousePreviousDesktop`:
* `MouseAbove`:
* `MouseBelow`:
* `MouseOpacityMore`:
* `MouseOpacityLess`:
* `MouseClose`:
* `MouseNothing`:

#### MouseWheelCommand

* `MouseWheelRaiseLower`:
* `MouseWheelShadeUnshade`:
* `MouseWheelMaximizeRestore`:
* `MouseWheelAboveBelow`:
* `MouseWheelPreviousNextDesktop`:
* `MouseWheelChangeOpacity`:
* `MouseWheelNothing`:

#### GlSwapStrategy

* `CopyFrontBuffer`:
* `PaintFullScreen`:
* `ExtendDamage`:
* `AutoSwapStrategy`:

### Read-only Properties

* `bool focusPolicyIsReasonable`

### Read-write Properties

* `FocusPolicy focusPolicy`
* `XwaylandCrashPolicy xwaylandCrashPolicy`
* `int xwaylandMaxCrashCount`
* `bool nextFocusPrefersMouse`
* `bool clickRaise`: Whether clicking on a window raises it in FocusFollowsMouse mode or not.
* `bool autoRaise`: Whether autoraise is enabled FocusFollowsMouse mode or not.
* `int autoRaiseInterval`: Autoraise interval.
* `int delayFocusInterval`: Delayed focus interval.
* `bool shadeHover`: Whether shade hover is enabled or not.
* `int shadeHoverInterval`: Shade hover interval.
* `bool separateScreenFocus`: Whether to see Xinerama screens separately for focus (in Alt+Tab, when activating next client)
* `int placement`
* `int borderSnapZone`: The size of the zone that triggers snapping on desktop borders.
* `int windowSnapZone`: The size of the zone that triggers snapping with other windows.
* `int centerSnapZone`: The size of the zone that triggers snapping on the screen center.
* `bool snapOnlyWhenOverlapping`: Snap only when windows will overlap.
* `bool rollOverDesktops`: Whether or not we roll over to the other edge when switching desktops past the edge.
* `int focusStealingPreventionLevel`: 0 - 4 , see Workspace::allowClientActivation()
* `KWin::Options::WindowOperation operationTitlebarDblClick`
* `KWin::Options::WindowOperation operationMaxButtonLeftClick`
* `KWin::Options::WindowOperation operationMaxButtonMiddleClick`
* `KWin::Options::WindowOperation operationMaxButtonRightClick`
* `MouseCommand commandActiveTitlebar1`
* `MouseCommand commandActiveTitlebar2`
* `MouseCommand commandActiveTitlebar3`
* `MouseCommand commandInactiveTitlebar1`
* `MouseCommand commandInactiveTitlebar2`
* `MouseCommand commandInactiveTitlebar3`
* `MouseCommand commandWindow1`
* `MouseCommand commandWindow2`
* `MouseCommand commandWindow3`
* `MouseCommand commandWindowWheel`
* `MouseCommand commandAll1`
* `MouseCommand commandAll2`
* `MouseCommand commandAll3`
* `uint keyCmdAllModKey`
* `bool showGeometryTip`: Whether the Geometry Tip should be shown during a window move/resize.
* `bool condensedTitle`: Whether the visible name should be condensed.
* `bool electricBorderMaximize`: Whether a window gets maximized when it reaches top screen edge while being moved.
* `bool electricBorderTiling`: Whether a window is tiled to half screen when reaching left or right screen edge while been moved.
* `float electricBorderCornerRatio`: Whether a window is tiled to half screen when reaching left or right screen edge while been moved.
* `bool borderlessMaximizedWindows`
* `int killPingTimeout`: timeout before non-responding application will be killed after attempt to close.
* `bool hideUtilityWindowsForInactive`: Whether to hide utility windows for inactive applications.
* `int compositingMode`
* `bool useCompositing`
* `int hiddenPreviews`
* `int glSmoothScale`: 0 = no, 1 = yes when transformed, 2 = try trilinear when transformed; else 1, -1 = auto
* `bool xrenderSmoothScale`
* `bool glStrictBinding`
* `bool glStrictBindingFollowsDriver`: Whether strict binding follows the driver or has been overwritten by a user defined config value. If true glStrictBinding is set by the OpenGL Scene during initialization. If false glStrictBinding is set from a config value and not updated during scene initialization.
* `bool glCoreProfile`
* `GlSwapStrategy glPreferBufferSwap`
* `KWin::OpenGLPlatformInterface glPlatformInterface`
* `bool windowsBlockCompositing`
* `LatencyPolicy latencyPolicy`
* `RenderTimeEstimator renderTimeEstimator`

### Signals

* `focusPolicyChanged()`
* `focusPolicyIsResonableChanged()`
* `xwaylandCrashPolicyChanged()`
* `xwaylandMaxCrashCountChanged()`
* `nextFocusPrefersMouseChanged()`
* `clickRaiseChanged()`
* `autoRaiseChanged()`
* `autoRaiseIntervalChanged()`
* `delayFocusIntervalChanged()`
* `shadeHoverChanged()`
* `shadeHoverIntervalChanged()`
* `separateScreenFocusChanged(bool)`
* `placementChanged()`
* `borderSnapZoneChanged()`
* `windowSnapZoneChanged()`
* `centerSnapZoneChanged()`
* `snapOnlyWhenOverlappingChanged()`
* `rollOverDesktopsChanged(bool enabled)`
* `focusStealingPreventionLevelChanged()`
* `operationTitlebarDblClickChanged()`
* `operationMaxButtonLeftClickChanged()`
* `operationMaxButtonRightClickChanged()`
* `operationMaxButtonMiddleClickChanged()`
* `commandActiveTitlebar1Changed()`
* `commandActiveTitlebar2Changed()`
* `commandActiveTitlebar3Changed()`
* `commandInactiveTitlebar1Changed()`
* `commandInactiveTitlebar2Changed()`
* `commandInactiveTitlebar3Changed()`
* `commandWindow1Changed()`
* `commandWindow2Changed()`
* `commandWindow3Changed()`
* `commandWindowWheelChanged()`
* `commandAll1Changed()`
* `commandAll2Changed()`
* `commandAll3Changed()`
* `keyCmdAllModKeyChanged()`
* `showGeometryTipChanged()`
* `condensedTitleChanged()`
* `electricBorderMaximizeChanged()`
* `electricBorderTilingChanged()`
* `electricBorderCornerRatioChanged()`
* `borderlessMaximizedWindowsChanged()`
* `killPingTimeoutChanged()`
* `hideUtilityWindowsForInactiveChanged()`
* `compositingModeChanged()`
* `useCompositingChanged()`
* `hiddenPreviewsChanged()`
* `glSmoothScaleChanged()`
* `xrenderSmoothScaleChanged()`
* `glStrictBindingChanged()`
* `glStrictBindingFollowsDriverChanged()`
* `glCoreProfileChanged()`
* `glPreferBufferSwapChanged()`
* `glPlatformInterfaceChanged()`
* `windowsBlockCompositingChanged()`
* `animationSpeedChanged()`
* `latencyPolicyChanged()`
* `configChanged()`
* `renderTimeEstimatorChanged()`

## KWin::Toplevel

### Read-only Properties

* `bool alpha`
* `qulonglong frameId`
* `QRect geometry`: This property holds the geometry of the Toplevel, excluding invisible portions, e.g. client-side and server-side drop-shadows, etc. DeprecatedUse frameGeometry property instead.
* `QRect bufferGeometry`: This property holds rectangle that the pixmap or buffer of this Toplevel occupies on the screen. This rectangle includes invisible portions of the client, e.g. client-side drop shadows, etc.
* `QRect frameGeometry`: This property holds the geometry of the Toplevel, excluding invisible portions, e.g. server-side and client-side drop-shadows, etc.
* `QPoint pos`: This property holds the position of the Toplevel's frame geometry.
* `QSize size`: This property holds the size of the Toplevel's frame geometry.
* `int x`: This property holds the x position of the Toplevel's frame geometry.
* `int y`: This property holds the y position of the Toplevel's frame geometry.
* `int width`: This property holds the width of the Toplevel's frame geometry.
* `int height`: This property holds the height of the Toplevel's frame geometry.
* `QRect visibleRect`
* `int screen`
* `qulonglong windowId`
* `int desktop`
* `bool onAllDesktops`: Whether the window is on all desktops. That is desktop is -1.
* `QRect rect`
* `QPoint clientPos`
* `QSize clientSize`
* `QByteArray resourceName`
* `QByteArray resourceClass`
* `QByteArray windowRole`
* `bool desktopWindow`: Returns whether the window is a desktop background window (the one with wallpaper). See _NET_WM_WINDOW_TYPE_DESKTOP at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool dock`: Returns whether the window is a dock (i.e. a panel). See _NET_WM_WINDOW_TYPE_DOCK at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool toolbar`: Returns whether the window is a standalone (detached) toolbar window. See _NET_WM_WINDOW_TYPE_TOOLBAR at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool menu`: Returns whether the window is a torn-off menu. See _NET_WM_WINDOW_TYPE_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool normalWindow`: Returns whether the window is a "normal" window, i.e. an application or any other window for which none of the specialized window types fit. See _NET_WM_WINDOW_TYPE_NORMAL at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool dialog`: Returns whether the window is a dialog window. See _NET_WM_WINDOW_TYPE_DIALOG at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool splash`: Returns whether the window is a splashscreen. Note that many (especially older) applications do not support marking their splash windows with this type. See _NET_WM_WINDOW_TYPE_SPLASH at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool utility`: Returns whether the window is a utility window, such as a tool window. See _NET_WM_WINDOW_TYPE_UTILITY at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool dropdownMenu`: Returns whether the window is a dropdown menu (i.e. a popup directly or indirectly open from the applications menubar). See _NET_WM_WINDOW_TYPE_DROPDOWN_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool popupMenu`: Returns whether the window is a popup menu (that is not a torn-off or dropdown menu). See _NET_WM_WINDOW_TYPE_POPUP_MENU at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool tooltip`: Returns whether the window is a tooltip. See _NET_WM_WINDOW_TYPE_TOOLTIP at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool notification`: Returns whether the window is a window with a notification. See _NET_WM_WINDOW_TYPE_NOTIFICATION at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool criticalNotification`: Returns whether the window is a window with a critical notification.
* `bool onScreenDisplay`: Returns whether the window is an On Screen Display.
* `bool comboBox`: Returns whether the window is a combobox popup. See _NET_WM_WINDOW_TYPE_COMBO at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `bool dndIcon`: Returns whether the window is a Drag&Drop icon. See _NET_WM_WINDOW_TYPE_DND at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `int windowType`: Returns the NETWM window type See https://standards.freedesktop.org/wm-spec/wm-spec-latest.html
* `QStringList activities`
* `bool managed`: Whether this Toplevel is managed by KWin (it has control over its placement and other aspects, as opposed to override-redirect windows that are entirely handled by the application).
* `bool deleted`: Whether this Toplevel represents an already deleted window and only kept for the compositor for animations.
* `bool shaped`: Whether the window has an own shape
* `quint32 surfaceId`: The Id of the Wayland Surface associated with this Toplevel. On X11 only setups the value is 0.
* `KWaylandServer::SurfaceInterface * surface`: Interface to the Wayland Surface. Relevant only in Wayland, in X11 it will be nullptr
* `bool popupWindow`: Whether the window is a popup.
* `bool outline`: Whether this Toplevel represents the outline. It's always false if compositing is turned off.
* `QUuid internalId`: This property holds a UUID to uniquely identify this Toplevel.
* `int pid`: The pid of the process owning this window. 5.20

### Read-write Properties

* `qreal opacity`
* `bool skipsCloseAnimation`: Whether the window does not want to be animated on window close. There are legit reasons for this like a screenshot application which does not want it's window being captured.

### Signals

* `opacityChanged(KWin::Toplevel *toplevel, qreal oldOpacity)`
* `damaged(KWin::Toplevel *toplevel, const QRegion &damage)`
* `inputTransformationChanged()`
* `geometryChanged()`: This signal is emitted when the Toplevel's frame geometry changes. Deprecatedsince 5.19, use frameGeometryChanged instead
* `geometryShapeChanged(KWin::Toplevel *toplevel, const QRect &old)`
* `paddingChanged(KWin::Toplevel *toplevel, const QRect &old)`
* `windowClosed(KWin::Toplevel *toplevel, KWin::Deleted *deleted)`
* `windowShown(KWin::Toplevel *toplevel)`
* `windowHidden(KWin::Toplevel *toplevel)`
* `shapedChanged()`: Signal emitted when the window's shape state changed. That is if it did not have a shape and received one or if the shape was withdrawn. Think of Chromium enabling/disabling KWin's decoration.
* `screenChanged()`: Emitted whenever the Toplevel's screen changes. This can happen either in consequence to a screen being removed/added or if the Toplevel's geometry changes. 4.11
* `skipCloseAnimationChanged()`
* `windowRoleChanged()`: Emitted whenever the window role of the window changes. 5.0
* `windowClassChanged()`: Emitted whenever the window class name or resource name of the window changes. 5.0
* `surfaceIdChanged(quint32)`: Emitted when a Wayland Surface gets associated with this Toplevel. 5.3
* `hasAlphaChanged()`: 5.4
* `surfaceChanged()`: Emitted whenever the Surface for this Toplevel changes.
* `screenScaleChanged()`
* `shadowChanged()`: Emitted whenever the client's shadow changes. 5.15
* `bufferGeometryChanged(KWin::Toplevel *toplevel, const QRect &oldGeometry)`: This signal is emitted when the Toplevel's buffer geometry changes.
* `frameGeometryChanged(KWin::Toplevel *toplevel, const QRect &oldGeometry)`: This signal is emitted when the Toplevel's frame geometry changes.
* `clientGeometryChanged(KWin::Toplevel *toplevel, const QRect &oldGeometry)`: This signal is emitted when the Toplevel's client geometry has changed.

### Functions

* `addRepaint(const QRect &r)`
* `addRepaint(const QRegion &r)`
* `addRepaint(int x, int y, int w, int h)`
* `addLayerRepaint(const QRect &r)`
* `addLayerRepaint(const QRegion &r)`
* `addLayerRepaint(int x, int y, int w, int h)`
* `addRepaintFull()`


## KWin::AbstractClient

### Enums

#### Position

* `PositionCenter`:
* `PositionLeft`:
* `PositionRight`:
* `PositionTop`:
* `PositionBottom`:
* `PositionTopLeft`:
* `PositionTopRight`:
* `PositionBottomLeft`:
* `PositionBottomRight`:

#### ForceGeometry\_t

* `NormalGeometrySet`:
* `ForceGeometrySet`:

#### SizeMode

* `SizeModeAny`:
* `SizeModeFixedW`:
* `SizeModeFixedH`:
* `SizeModeMax`:

#### SameApplicationCheck

* `RelaxedForActive`:
* `AllowCrossProcesses`:

### Read-only Properties

* `bool fullScreenable`: Whether the Client can be set to fullScreen. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `bool active`: Whether this Client is active or not. Use Workspace::activateClient() to activate a Client. Workspace::activateClient
* `QVector< uint > x11DesktopIds`: The x11 ids for all desktops this client is in. On X11 this list will always have a length of
* `bool closeable`: Whether the window can be closed by the user. The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `QIcon icon`
* `bool shadeable`: Whether the Client can be shaded. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `bool minimizable`: Whether the Client can be minimized. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `QRect iconGeometry`: The optional geometry representing the minimized Client in e.g a taskbar. See _NET_WM_ICON_GEOMETRY at https://standards.freedesktop.org/wm-spec/wm-spec-latest.html . The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `bool specialWindow`: Returns whether the window is any of special windows types (desktop, dock, splash, ...), i.e. window types that usually don't have a window frame and the user does not use window management (moving, raising,...) on them. The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `QString caption`: The Caption of the Client. Read from WM_NAME property together with a suffix for hostname and shortcut. To read only the caption as provided by WM_NAME, use the getter with an additional false value.
* `QSize minSize`: Minimum size as specified in WM_NORMAL_HINTS
* `QSize maxSize`: Maximum size as specified in WM_NORMAL_HINTS
* `bool wantsInput`: Whether the Client can accept keyboard focus. The value is evaluated each time the getter is called. Because of that no changed signal is provided.
* `bool transient`: Whether the Client is a transient Window to another Window. transientFor
* `KWin::AbstractClient * transientFor`: The Client to which this Client is a transient if any.
* `bool modal`: Whether the Client represents a modal window.
* `bool move`: Whether the Client is currently being moved by the user. Notify signal is emitted when the Client starts or ends move/resize mode.
* `bool resize`: Whether the Client is currently being resized by the user. Notify signal is emitted when the Client starts or ends move/resize mode.
* `bool decorationHasAlpha`: Whether the decoration is currently using an alpha channel.
* `bool providesContextHelp`: Whether the Client provides context help. Mostly needed by decorations to decide whether to show the help button or not.
* `bool maximizable`: Whether the Client can be maximized both horizontally and vertically. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `bool moveable`: Whether the Client is moveable. Even if it is not moveable, it might be possible to move it to another screen. The property is evaluated each time it is invoked. Because of that there is no notify signal. moveableAcrossScreens
* `bool moveableAcrossScreens`: Whether the Client can be moved to another screen. The property is evaluated each time it is invoked. Because of that there is no notify signal. moveable
* `bool resizeable`: Whether the Client can be resized. The property is evaluated each time it is invoked. Because of that there is no notify signal.
* `QByteArray desktopFileName`: The desktop file name of the application this AbstractClient belongs to. This is either the base name without full path and without file extension of the desktop file for the window's application (e.g. "org.kde.foo"). The application's desktop file name can also be the full path to the desktop file (e.g. "/opt/kde/share/org.kde.foo.desktop") in case it's not in a standard location.
* `bool hasApplicationMenu`: Whether an application menu is available for this Client
* `bool applicationMenuActive`: Whether the application menu for this Client is currently opened
* `bool unresponsive`: Whether this client is unresponsive. When an application failed to react on a ping request in time, it is considered unresponsive. This usually indicates that the application froze or crashed.
* `QString colorScheme`: The color scheme set on this client Absolute file path, or name of palette in the user's config directory following KColorSchemes format. An empty string indicates the default palette from kdeglobals is used. this indicates the colour scheme requested, which might differ from the theme applied if the colorScheme cannot be found

### Read-write Properties

* `bool fullScreen`: Whether this Client is fullScreen. A Client might either be fullScreen due to the _NET_WM property or through a legacy support hack. The fullScreen state can only be changed if the Client does not use the legacy hack. To be sure whether the state changed, connect to the notify signal.
* `int desktop`: The desktop this Client is on. If the Client is on all desktops the property has value -1. This is a legacy property, use x11DesktopIds instead
* `bool onAllDesktops`: Whether the Client is on all desktops. That is desktop is -1.
* `QStringList activities`: The activities this client is on. If it's on all activities the property is empty.
* `bool skipTaskbar`: Indicates that the window should not be included on a taskbar.
* `bool skipPager`: Indicates that the window should not be included on a Pager.
* `bool skipSwitcher`: Whether the Client should be excluded from window switching effects.
* `bool keepAbove`: Whether the Client is set to be kept above other windows.
* `bool keepBelow`: Whether the Client is set to be kept below other windows.
* `bool shade`: Whether the Client is shaded.
* `bool minimized`: Whether the Client is minimized.
* `bool demandsAttention`: Whether window state _NET_WM_STATE_DEMANDS_ATTENTION is set. This state indicates that some action in or with the window happened. For example, it may be set by the Window Manager if the window requested activation but the Window Manager refused it, or the application may set it if it finished some work. This state may be set by both the Client and the Window Manager. It should be unset by the Window Manager when it decides the window got the required attention (usually, that it got activated).
* `QRect geometry`: The geometry of this Client. Be aware that depending on resize mode the frameGeometryChanged signal might be emitted at each resize step or only at the end of the resize operation. DeprecatedUse frameGeometry
* `QRect frameGeometry`: The geometry of this Client. Be aware that depending on resize mode the frameGeometryChanged signal might be emitted at each resize step or only at the end of the resize operation.
* `bool noBorder`: Whether the window has a decoration or not. This property is not allowed to be set by applications themselves. The decision whether a window has a border or not belongs to the window manager. If this property gets abused by application developers, it will be removed again.

### Signals

* `fullScreenChanged()`
* `skipTaskbarChanged()`
* `skipPagerChanged()`
* `skipSwitcherChanged()`
* `iconChanged()`
* `activeChanged()`
* `keepAboveChanged(bool)`
* `keepBelowChanged(bool)`
* `demandsAttentionChanged()`: Emitted whenever the demands attention state changes.
* `desktopPresenceChanged(KWin::AbstractClient *, int)`
* `desktopChanged()`
* `activitiesChanged(KWin::AbstractClient *client)`
* `x11DesktopIdsChanged()`
* `shadeChanged()`
* `minimizedChanged()`
* `clientMinimized(KWin::AbstractClient *client, bool animate)`
* `clientUnminimized(KWin::AbstractClient *client, bool animate)`
* `paletteChanged(const QPalette &p)`
* `colorSchemeChanged()`
* `captionChanged()`
* `clientMaximizedStateChanged(KWin::AbstractClient *, MaximizeMode)`
* `clientMaximizedStateChanged(KWin::AbstractClient *c, bool h, bool v)`
* `transientChanged()`
* `modalChanged()`
* `quickTileModeChanged()`
* `moveResizedChanged()`
* `moveResizeCursorChanged(CursorShape)`
* `clientStartUserMovedResized(KWin::AbstractClient *)`
* `clientStepUserMovedResized(KWin::AbstractClient *, const QRect &)`
* `clientFinishUserMovedResized(KWin::AbstractClient *)`
* `closeableChanged(bool)`
* `minimizeableChanged(bool)`
* `shadeableChanged(bool)`
* `maximizeableChanged(bool)`
* `desktopFileNameChanged()`
* `applicationMenuChanged()`
* `hasApplicationMenuChanged(bool)`
* `applicationMenuActiveChanged(bool)`
* `unresponsiveChanged(bool)`
* `geometryChanged()`
* `keepBelowChanged()`

### Functions

* `closeWindow()`
* `setMaximize(bool vertically, bool horizontally)`: Sets the maximization according to vertically and horizontally.
