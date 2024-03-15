---
title: Kiosk keys
weight: 2
layout: kiosk-keys
applications:
  - name: Application Action Restrictions
    hasmenu: true
    description: |
      These keys disable actions that are commonly found in KDE applications.
      To use these actions, create a section in `kdeglobals` that looks like this:

      ```ini
      [KDE Action Restrictions][$i]
      action/<key>=false
      ```
    keys:
      - key: "action/file_new"
        menu: File
        action: New
      - key: "action/file_open"
        menu: File
        action: Open
      - key: "action/file_open_recent"
        menu: File
        action: Open Recent File
      - key: "action/file_save"
        menu: File
        action: Save
      - key: "action/file_save_as"
        menu: File
        action: Save As
      - key: "action/file_revert"
        menu: File
        action: Revert
      - key: "action/file_close"
        menu: File
        action: Close
      - key: "action/file_print"
        menu: File
        action: Print
      - key: "action/file_print_preview"
        menu: File
        action: Print Preview
      - key: "action/file_mail"
        menu: File
        action: Email File
      - key: "action/file_quit"
        menu: File
        action: Quit
      - key: "action/edit_undo"
        menu: Edit
        action: Undo
      - key: "action/edit_redo"
        menu: Edit
        action: Redo
      - key: "action/edit_cut"
        menu: Edit
        action: Cut
      - key: "action/edit_copy"
        menu: Edit
        action: Copy
      - key: "action/edit_paste"
        menu: Edit
        action: Paste
      - key: "action/edit_select_all"
        menu: Edit
        action: Select All
      - key: "action/edit_deselect"
        menu: Edit
        action: Deselect
      - key: "action/edit_find"
        menu: Edit
        action: Find
      - key: "action/edit_find_next"
        menu: Edit
        action: Find Next
      - key: "action/edit_find_last"
        menu: Edit
        action: Find last
      - key: "action/edit_replace"
        menu: Edit
        action: Replace
      - key: "action/view_actual_size"
        menu: View
        action: 100% Zoom
      - key: "action/view_fit_to_page"
        menu: View
        action: Fit To Page (zooming)
      - key: "action/view_fit_to_width"
        menu: View
        action: Fit To Width (zooming)
      - key: "action/view_fit_to_height"
        menu: View
        action: Fit To Height (zooming)
      - key: "action/view_zoom_in"
        menu: View
        action: Zoom In
      - key: "action/view_zoom_out"
        menu: View
        action: Zoom Out
      - key: "action/view_zoom"
        menu: View
        action: Zoom
      - key: "action/view_redisplay"
        menu: View
        action: Refresh
      - key: "action/go_up"
        menu: Go
        action: Up
      - key: "action/go_back"
        menu: Go
        action: Back
      - key: "action/go_forward"
        menu: Go
        action: Forward
      - key: "action/go_home"
        menu: Go
        action: Home
      - key: "action/go_previous"
        menu: Go
        action: Previous
      - key: "action/go_next"
        menu: Go
        action: Next
      - key: "action/go_goto"
        menu: Go
        action: Go To...
      - key: "action/go_goto_page"
        menu: Go
        action: Go To Page...
      - key: "action/go_goto_line"
        menu: Go
        action: Go To Line...
      - key: "action/go_first"
        menu: Go
        action: Go To Start
      - key: "action/go_last"
        menu: Go
        action: Go To End
      - key: "action/bookmarks"
        menu: Bookmarks
        action: Also disables action/bookmark_add and action/bookmark_edit
      - key: "action/bookmark_add"
        menu: Bookmarks
        action: Add Bookmark
      - key: "action/bookmark_edit"
        menu: Bookmarks
        action: Edit Bookmarks
      - key: "action/tools_spelling"
        menu: Tools
        action: Check Spelling
      - key: "action/options_show_menubar"
        menu: Settings
        action: Show/hide Menubar
      - key: "action/options_show_toolbar"
        menu: Settings
        action: 'Show/hide Toolbar, will also disable the "Toolbars" submenu if present'
      - key: "action/options_show_statusbar"
        menu: Settings
        action: Show/hide statusbar
      - key: "action/options_save_Settings"
        menu: Settings
        action: Save Settings
      - key: "action/options_configure"
        menu: Settings
        action: Configure application
      - key: "action/options_configure_keybinding"
        menu: Settings
        action: Configure Shortcuts
      - key: "action/options_configure_toolbars"
        menu: Settings
        action: Configure Toolbars
      - key: "action/options_configure_notifications"
        menu: Settings
        action: Configure Notifications
      - key: "action/fullscreen"
        menu: Settings
        action: Enter full screen mode
      - key: "action/help"
        menu: Help
        action: Not yet fully implemented
      - key: "action/help_contents"
        menu: Help
        action: Application handbook
      - key: "action/help_whats_this"
        menu: Help
        action: Go into "what's this" mode
      - key: "action/help_report_bug"
        menu: Help
        action: Report a bug
      - key: "action/help_about_app"
        menu: Help
        action: Show about application dialog
      - key: "action/help_about_kde"
        menu: Help
        action: Show about KDE dialog
  - name: KCalc
    description: By marking the kcalcrc config file as immutable, the "Configure" button will not be shown.
  - name: File Manager
    keys:
      - key: "action/editfiletype"
        action: Edit associated applications
      - key: "action/properties"
        action: File properties
      - key: "action/openwith"
        action: Open file with action
      - key: "action/openintab"
        action: Open link in a new tab
      - key: "action/kdesktop_rmb"
        action: RMB menu, see note below
      - key: action/iconview_preview
        action: |
          Show preview thumbnails in icons, though it leaves the actual setting untouched. To disable previews (as opposed to simply disabling the user to change the setting) you also need to add the following lines to konqiconviewrc:

          ```ini
          [Settings]
          PreviewsEnabled[$i]=false
          ```
      - key: "action/sharefile"
        action: Disables file sharing from the UI, but you may also want to disable filesharing altogether.
      - key: "action/sendURL"
        action: Send Link Address
      - key: "action/sendPage"
        action: Send File
      - key: "action/devnew"
        action: Create New -> Device
      - key: "action/incIconSize"
        action: Increase icon size
      - key: "action/decIconSize"
        action: Decrease icon size
      - key: "action/go"
        action: Entire go menu
      - key: "action/configdesktop"
        action: Configure desktop in RMB menu, see also Control Module Restrictions
      - key: "action/executeshellcommand"
        action: In Konqueror Tools menu, see also `shell_access`
      - key: "action/show_dot"
        action: |
          Disables the option to toggle showing hidden files, the actual setting remains unaffected. To disable showing hidden files, add the following lines to konqiconviewrc:

          ```ini
          [Settings]
          ShowDotFiles[$i]=false
          ```
  - name: Konsole
    description: These keys can appear in `kdeglobals`, `konsolepartrc` or `konsolerc`.
    keys:
      - key: action/konsole_rmb
        action: Context menus
      - key: action/settings
        action: Disable the entire settings menu
      - key: action/show_menubar
        action: Show/hide the menubar
      - key: action/show_toolbar
        action: Show/hide the toolbar
      - key: action/scrollbar
        action: Show/hide the scrollbar
      - key: action/bell
        action: Configure bell actions
      - key: action/font
        action: Configure font
      - key: action/keyboard
        action: Set keyboard type
      - key: action/schema
        action: Select the schema to use
      - key: action/size
        action: Set the terminal size
      - key: action/history
        action: Configure history
      - key: action/save_default
        action: Save settings as defaults
      - key: action/save_sessions_profile
        action: Save sessions profile
      - key: action/send_signal
        action: Send a signal to the current terminal
      - key: action/bookmarks
        action: Bookmarks menu
      - key: action/add_bookmark
        action: Add a bookmark
      - key: action/edit_bookmarks
        action: Edit bookmarks
      - key: action/clear_terminal
        action: Clear the current terminal
      - key: action/reset_clear_terminal
        action: Clear and reset the current terminal
      - key: action/find_history
        action: Find in history
      - key: action/find_next
        action: Find next item in history
      - key: action/find_previous
        action: Find previous item in history
      - key: action/save_history
        action: Save history to disk
      - key: action/clear_history
        action: Clear history of current terminal
      - key: action/clear_all_histories
        action: Clear histories of all terminals
      - key: action/detach_session
        action: Detach current tab
      - key: action/rename_session
        action: Rename current session
      - key: action/zmodem_upload
        action: ZModem uploading
      - key: action/monitor_activity
        action: Monitor current terminal for activity
      - key: action/monitor_silence
        action: Monitor current terminal for silence
      - key: action/send_input_to_all_sessions
        action: Replicate input to all sessions
      - key: action/close_session
        action: Close current terminal session
      - key: action/new_session
        action: Create a new terminal session
      - key: action/activate_menu
        action: Activate menubar
      - key: action/list_sessions
        action: Session list menu
      - key: action/move_session_left
        action: Shift tab to the left
      - key: action/move_session_right
        action: Shift tab to the right
      - key: action/previous_session
        action: Go to tab to the left
      - key: action/next_session
        action: Go to tab to the right
      - key: "action/switch_to_session_#"
        action: "Go to tab numbered #, where # is a number between 1 and 12 inclusive."
      - key: action/bigger_font
        action: Increase font size
      - key: action/smaller_font
        action: Decrease font size
      - key: action/toggle_bidi
        action: Turn bidirectional text support on or off
  - name: KWin
    keys:
      - key: action/kwin_rmb
        action: Context menus on window titlebar and frame
  - name: Plasma
    description: |
      Locking down the entire config with [$i] will cause everything to be
      immutable. Locking a Containment group will render that one group of
      widgets to be immutable, and locking a widget itself will cause it to
      not be movable as well as otherwise locked.
      In addition, the following resource restrictions are available:
    keys:
      - key: plasma/allow_configure_when_locked (since Plasma 4.4)
        action: |
          Whether widgets and containments can be configured when immutable / locked.
          The default is true as a convenience to users.
      - key: plasma/containment_actions (since KDE Frameworks 5.49)
        action: |
          Whether or not to allow Plasma mouse actions on desktop and panels (most notably
          context menus, but also mouse wheel to switch virtual desktops, etc.)
      - key: plasma/plasmashell/unlockedDesktop (since Plasma 5.0)
        action: |
          Whether to allow widgets in Plasma to be unlocked; when false, the following restrictions apply:
          -  Widgets cannot be unlocked
          -  Favorites and applications in the application launchers cannot be
          added, removed, rearranged, or otherwise altered (since Plasma 5.7)
          -  Application launchers in the task manager cannot be added or removed
           (since Plasma 5.8)
      - key: plasma-desktop/scripting_console (since Plasma 4.4)
        action: Whether the plasma desktop scripting console is accessible or not.
      - key: plasma-desktop/add_activities (>= 4.7.1)
        action: Whether the user may add new activities or not.

  - name: GHNS
    description: |
      Plasma offers to download new widgets, wallpapers, scripts, and other
      3rd party add-ons from the KDE Store using the KNewStuff (aka "Get Hot
      New Stuff") framework. The buttons are typically labeled "Get New
      ..." with a "star" icon. If this feature is undesirable it can be
      disabled using the following key:
    keys:
      - key: ghns (since KDE Frameworks 5.27)
        action: Whether the Download Dialog of Get Hot New Stuff can be accessed

  - name: Authorizing
    description: |
      Application `.desktop` files can have an additional
      field `X-KDE-AuthorizeAction`.

      If this field is present the `.desktop` file is
      only considered valid if the action(s) mentioned in this field has been
      authorized. If multiple actions are listed they should be separated by
      commas (',').

      If the `.desktop` file of an application lists one
      or more actions this way and the user has no authorization for even one
      of these actions then the application will not appear in the KDE menu,
      will not allow execution via that `.desktop` file and will not be used
      by KDE for opening files of associated mimetypes.

  - name: File Dialog
    description: |
      These keys disable actions that are found in the KDE file dialog. To use
      them, create a section in `kdeglobals` that looks
      like this:

      ```ini
      [KDE Action Restrictions][$i]
      action/<key>=false
      ```
    keys:
      - key: action/home
        action: Go to home directory
      - key: action/up
        action: Go to parent directory
      - key: action/back
        action: Go to previous directory
      - key: action/forward
        action: Go to next directory
      - key: action/reload
        action: Reload directory
      - key: action/mkdir
        action: Create new directory
      - key: action/toggleSpeedbar
        action: Show/hide sidebar
      - key: action/sorting menu
        action: Sorting options
      - key: action/short view
        action: Select short view
      - key: action/detailed view
        action: Select detailed view
      - key: action/show hidden
        action: Show/hide hidden files
      - key: action/preview
        action: Show/hide preview
      - key: action/separate dirs
        action: Show/hide separate directories
  - name: Printing
    description: |
      There are several keys that restrict various aspects of the KDE print
      dialog and printing system. To use them, create a configuration section
      like this:

      ```ini
      [KDE Resource Restrictions][$i]
      print/<resource key>=false
      ```

      Note how each of the printing keys start with `print` in the
      configuration file.
    keys:
      - key: print/copies
        action: Disables the panel that allows users to make more than one copy.
      - key: print/dialog
        action: |
          Disables the complete print dialog. Selecting the
          print option will immediately print the selected document using default
          settings. Make sure that a system-wide default printer has been selected.
          No application-specific settings are honored when this restriction is
          activated.
      - key: print/options
        action: Disables the button to select additional print options.
      - key: print/properties
        action: Disables the button to change printer properties or to add a new printer.
      - key: print/selection
        action: |
          Disables the options that allows selecting a
          (pseudo) printer or change any of the printer properties. Make sure that
          a proper default printer has been selected before disabling this option.
          Disabling this option also disables `print/system`, `print/options`
          and `print/properties`.
      - key: print/system
        action: |
          Disables the option to select the printing system backend, e.g.
          CUPS. It is recommended to disable this option once the correct
          printing system has been configured.
  - name: Resource Restrictions
    description: |
      KDE applications can take advantage of many types of resources such as
      configuration data, caches, plugin registries, etc. These are loaded
      from both system-wide as well as from per-user locations on disk. It is
      possible to restrict the use of the per-user resources directories,
      preventing users from adding to or altering existing shared resources.

      This is accomplished by creating a section like this in a configuration
      file:

      ```ini
      [KDE Resource Restrictions][$i]
      <resource key>=false
      ```

      The following resources can be used as keys and controlled in this
      manner:
    directories:
      - key: all
        directory: n/a
        provides: All resources listed in this table
      - key: autostart
        directory: share/autostart
        provides: Apps to start on login
      - key: data
        directory: share/app
        provides: Application data
      - key: data_<appname>
        directory: share/apps
        provides: Application data for the application named <appname>
      - key: html
        directory: share/doc/HTML
        provides: HTML files
      - key: "icon"
        directory: share/icon
        provides: Icons
      - key: "config"
        directory: share/config
        provides: Application configurations
      - key: "pixmap"
        directory: share/pixmaps
        provides: Images
      - key: "xdgdata-apps"
        directory: share/application
        provides: Application .desktop files
      - key: "sound"
        directory: share/sound
        provides: Sound files
      - key: "locale"
        directory: share/locale
        provides: Localization data
      - key: "services"
        directory: share/services
        provides: Protocols, plugins, kparts, control panels, etc. registry
      - key: "servicetypes"
        directory: share/servicestypes
        provides: Plugin definitions, referenced in services registry  entries
      - key: "mime"
        directory: share/mimelnk
        provides: Mimetype definitions
      - key: "wallpaper"
        directory: share/wallpapers
        provides: Desktop wallpaper images
      - key: "templates"
        directory: share/templates
        provides: Document templates
      - key: "exe"
        directory: bin
        provides: Executable files
      - key: "lib"
        directory: lib
        provides: Libraries

  - name: Screensavers
    description: |

      In kdeglobals in the `[KDE Action Restrictions]` group:
    keys:
      - key: opengl_screensavers
        action: Defines whether OpenGL screensavers are allowed to be used.
      - key: manipulatescreen_screensavers
        action: |
          Defines whether screensavers that manipulate an image of the screen
          (e.g. moving chunks of the screen around) are allowed to be used.
  - name: Automatic Logout
    description: |
      In `kscreensaverrc`:

      ```ini
      [ScreenSaver]
      AutoLogout=true
      AutoLogoutTimeout=600
      ```

      The timeout is the time in seconds that the user must be idle for before
      the logout process is automatically started. Be careful with this
      capability as it can lead to data loss if the user has unsaved files
      open.
  - name: Session Capability Restrictions
    description: |
      These keys apply to various capabilities associated with a desktop
      session and are not application specific. To use them, create a section
      in `kdeglobals` that looks like this:

      ```ini
      [KDE Action Restrictions][$i]
      <key>=false
      ```
    keys:
      - key: custom_config
        action: |
          Whether the `--config` command line option should be honored. The
          `--config` command line option can be used to circumvent locked-down
          configuration files.
      - key: editable_desktop_icons
        action: |
          Defines whether icons on the desktop can be moved
          around. In order to prevent adding, removing, or renaming icons, you should set the
          desktop folder read-only. *(since Plasma 5.14)
      - key: lineedit_text_completion
        action: |
          Defines whether input lines should have the potential to remember
          any previously entered data and make suggestions based on this when
          typing. When a single account is shared by multiple people you may
          wish to disable this out of privacy concerns.
      - key: lineedit_reveal_password
        action: |
          Defines whether password input fields may have a button that allows
          showing the password in plain text. *(since KDE Frameworks 5.30
          and/or Plasma 5.9)
      - key: action/lock_screen
        action: Defines whether the user will be able to lock the screen.
      - key: logout
        action: Defines whether the user will be able to logout from the Plasma session.
      - key: movable_toolbars
        action: |
          Defines whether toolbars may be moved around by the user.
          See also `action/options_show_toolbar`.
      - key: run_command
        action: |
          Defines whether the "Run Command" (Alt-F2) option is available.
          **Note:** To also disable desktop context menu run command **action/run_command** is required at [KDE Action Restrictions]
      - key: run_desktop_files
        action: |
          Defines whether users may execute desktop files that are not part of
          the default desktop, KDE menu, registered services and autostarting services.
          - The default desktop includes the files under
            `.local/share/kdesktop/Desktop` but **not**
            the files under `$HOME/Desktop`.
          - The KDE menu includes all files under `$KDEDIR/share/applnk` and `$XDGDIR/applications`
          - Registered services includes all files under `$KDEDIR/share/services`
          - Autostarting services include all files under `$KDEDIR/share/autostart` but **not** the
            files under `$KDEHOME/Autostart`
      - key: shell_access
        action: |
          Whether a shell suitable for entering random commands may be
          started. This also determines whether the "Run Command" option
          (Alt-F2) can be used to run shell-commands and arbitrary
          executables. Likewise, executables placed in the user's Autostart
          folder will no longer be executed. Applications can still be
          autostarted by placing `.desktop` files in the
          `.local/share/autostart` directory. See also
          `run_desktop_files`.

          You probably also want to activate the following resource
          restrictions:

          - "appdata_kdesktop" - To restrict the default desktop.
          - "apps" - To restrict the KDE menu.
          - "xdgdata-apps" - To restrict the KDE menu.
          - "services" - To restrict registered services.
          - "autostart" - To restrict autostarting services.

          Otherwise users can still execute .desktop files by placing them in
          e.g. `.local/share/kdesktop/Desktop`
      - key: skip_drm
        action: |
          Defines if the user may omit
          [DRM](https://en.wikipedia.org/wiki/Digital_rights_management)
          checking. At the time of writing, this primarily applies to document
          formats with a DRM mechanism (e.g. PDF).
      - key: action/start_new_session
        action: Defines whether the user may start a new session.
      - key: action/switch_user
        action: Defines whether user switching is allowed.

  - name: Telemetry
    description: |
      Whilst telemetry is disabled by default, a user can choose to enable it
      inside applications.

      To force global disabling set

      `/etc/xdg/KDE/UserFeedback.conf`

      ```ini
      [UserFeedback]
      Enabled=false
        ```
---

This article contains a listing of known keys that can be used with
Kiosk and what they do. How to actually use these keys and other
capabilities of Kiosk such as URL restrictions, creating assigning
profiles, etc. is covered in the [Introduction to
Kiosk](../introduction) article.

Which configuration file to put these entries in depends on whether you
wish to make them global to all applications or specific to one
application. To make the restrictions valid for all applications, put
them in kdeglobals. To enable a restriction for a specific applications
place them in the application-specific configuration, e.g. konquerorrc
for Konqueror.

## Application Action Restrictions

{{< deploy-kiosk-keys index=0 >}}

## KCalc

{{< deploy-kiosk-keys index=1 >}}

## File Manager

{{< deploy-kiosk-keys index=2 >}}

## Konsole

{{< deploy-kiosk-keys index=3 >}}

## KWin

{{< deploy-kiosk-keys index=4 >}}

## Plasma

{{< deploy-kiosk-keys index=5 >}}

### GHNS

{{< deploy-kiosk-keys index=6 >}}

## Authorizing

{{< deploy-kiosk-keys index=7 >}}

## File Dialog

{{< deploy-kiosk-keys index=8 >}}

## Printing

{{< deploy-kiosk-keys index=9 >}}

## Resource Restrictions

{{< deploy-kiosk-keys index=10 >}}

## Screensavers

{{< deploy-kiosk-keys index=11 >}}

### Automatic logout

{{< deploy-kiosk-keys index=12 >}}

## Session Capability Restrictions

{{< deploy-kiosk-keys index=13 >}}

## Telemetry

{{< deploy-kiosk-keys index=14 >}}
