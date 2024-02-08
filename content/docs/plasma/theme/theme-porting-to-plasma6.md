---
title: Porting themes to Plasma 6
weight: 9
description: An overview of common changes needed for old themes to work properly on Plasma 6.
authors:
 - SPDX-FileCopyrightText: 2024 Benjamin Flesch <bf@deutsche-cyberberatung.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

With Plasma 6, various breaking changes affect existing Plasma look-and-feel themes.

## Strict Theme Packaging

All themes are now handled as a `kpackage`, which means that a **manifest.json** file is required. The manifest.json file of a Plasma theme needs the JSON key `"KPackageStructure": "Plasma/LookAndFeel"` to be set, otherwise it will not be shown in the Plasma "Global Themes" settings.

## No Symlinks allowed

Due to the new kpackage format, symlinks cannot be used to load a Plasma theme anymore. All Plasma 6 global themes must be placed in one of the two main folders `/usr/share/plasma/look-and-feel` and `~/.local/share/plasma/look-and-feel`.

## Renamed QML Imports```

Various QML imports have been renamed, so all existing Plasma 5 theme QML files need to be edited in order to reflect that. There is documentation about [Plasma 6 name changes affecting widgets](https://develop.kde.org/docs/plasma/widget/porting_kf6/) and more info can be found in other places such as the [Plasma 6 source code repository](https://invent.kde.org/plasma/plasma-workspace).

Notable changes are renaming of `QtGraphicalEffects` to `Qt5Compat.GraphicalEffects` and of `PlasmaCore.DataSource` to `org.kde.plasma.plasma5support.DataSource`, but there are many others.

## Changes for desktop layout scripts

The layout scripts such as `contents/layouts/org.kde.plasma.desktop-layout.js` have not changed very much. The API mostly stays the same. The version of the Plasma Javascript Scripting API which is frequently used in boilerplate code such as `var plasma = getApiVersion(1);` has not been changed. However, the configuration options for panels and widgets have been adapted due to the introduction of new features, such as the floating panel setting. Further details should be looked up in the [Plasma 6 source code repository](https://invent.kde.org/plasma/plasma-workspace).

## Changes for custom Lock Screens (LockScreen.qml)

Custom Lock Screens of your theme are normally placed in `contents/lockscreen/LockScreen.qml` and need to be adapted for Plasma 6. The handling of the kscreenlocker-provided `authenticator` object has been changed due to support for passwordless authentication. If your Plasma 5 theme is using a `Connections { target: authenticator }`, the event listeners for that connection need to be adapted for Plasma 6. The listener `onPrompt` was changed to `onPromptChanged`, and `onInfoMessage`/`onErrorMessage` were changed to `onInfoMessageChanged`/`onErrorMessageChanged`.

The Plasma 6 LockScreen authentication process is initiated with `authenticator.startAuthenticating()` instead of the previously used `authenticator.tryUnlock()`. The `onPromptForSecret` event listener was renamed to `onPromptForSecretChanged`. The transmission of the actual password via `authenticator.respond(myPasswordInput.text)` remains the same as before.

## Changes for custom WindowSwitchers (KWin TabBox)

If your theme uses a WindowSwitcher element (which is called a `TabBox` within KWin), please note that it is also affected by the renaming of QML imports. There are some specific KWin renames that might affect custom WindowSwitchers such as from `KWin.WindowThumbnailItem` to `KWin.WindowThumbnail` which are mostly documented in the [kwin source code repostiory](https://invent.kde.org/plasma/kwin). 

## Changes for SDDM Login Themes

If your plasma 6 theme also has a custom SDDM login theme, please remember that its QML imports need also be adapted to the QT6 changes. For example `import QtGraphicalEffect` should become a `import Qt5Compat.GraphicalEffects` in order to work with QT6. As SDDM themes are not the main focus of this article, theme creators should consult the SDDM documentation for further details.