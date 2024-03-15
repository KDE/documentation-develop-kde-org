---
title: Application icons in the System Tray
weight: 7
description: A reference list of application icons
---

Applications that use [KNotifierStatusItem::setIconByName()](https://api.kde.org/frameworks/knotifications/html/classKStatusNotifierItem.html#a9a48df4020cf548a0250a2ed4f388965) can have their icon in the system tray themed. Applications can have more than one icon (for example Konversation flashes between two different icons to highlight when your username is mentioned and the Discover notifier changes its icon depending on the status of its upgrade / installs).

Theming these icons requires firstly that your application uses `setIconByName`, and secondly that you call your SVG element by the same name (use `Ctrl+Shift-O` in Inkscape). Then you can just put your `.svg` in `~/.local/share/plasma/desktoptheme/[theme-name]/icons`.

The following is an attempt to list known icon names that may be themed by this method. Please add any other known icon names and the element ID here to help other people making themes:

### Amarok

* filename: **amarok.svg**
  * ID: **amarok**

### audio (for kmix, veromix, a.o.)

* filename: **audio.svg**
  * volume muted ID: **audio-volume-muted**
  * volume low ID: **audio-volume-low**
  * volume medium ID: **audio-volume-medium**
  * volume high ID: **audio-volume-high**

### battery

* filename: **battery.svg**
  * battery (always shown element) ID: **Battery**
  * on powerline ID: **AcAdapter**
  * no battery found ID: **Unavailable**
  * battery on 10% ID: **Fill10**
  * battery on 20% ID: **Fill20**
  * battery on 30% ID: **Fill30**
  * […]
  * battery on 90% ID: **Fill90**
  * battery on 100% ID: **Fill100**

### device (the device-notifier)

* filename: **device.svg**
  * ID: **device-notifier**

### input (mouse, keyboard, lock keys state)

* filename: **input.svg**
  * mouse battery ID: **input-mouse-battery**
  * keyboard battery ID: **input-keyboard-battery**
  * keyboard backlight level ID: **input-keyboard-brightness**
  * Caps Lock ID: **input-caps-on** (used for both on and off)
  * Num Lock ID: **input-num-on** (used for both on and off)

### Juk

* filename: **juk.svg**
  * ID: **juk**

### KGet

* filename: **kget.svg**
  * ID: **kget**

### Klipper

* filename: **klipper.svg**
  * ID: **klipper**

### Konversation

* filename: **konversation**
  * ID: **konversation**
* filename: **konv_message.svg** (new incoming message)
  * ID: **konv_message**

### Kopete

* filename: **kopete.svg**
  * offline ID: **kopete-offline**
  * online ID: **kopete**
  * other statuses are not supported atm

### Korgac

* filename: **korgac.svg**
  * ID: **korgac**

### Ktorrent

* filename: **ktorrent.svg**
  * ID: **ktorrent**

### message-indicator

* filename: **message-indicator.svg**
  * standard ID: **normal**
  * new message ID: **new**

### Nepomuk

* filename: **nepomuk.svg**
  * ID: **nepomuk**

### Network-management-plasmoid

* filename: **network.svg**
  * wired online ID: **network-wired-activated**
  * wired offline ID: **network-wired**
  * wless offline ID: **network-wireless-0**
  * wless on 20% ID: **network-wireless-20**
  * wless on 25% ID: **network-wireless-25**
  * wless on 40% ID: **network-wireless-40**
  * wless on 50% ID: **network-wireless-50**
  * wless on 60% ID: **network-wireless-60**
  * wless on 75% ID: **network-wireless-75**
  * wless on 80% ID: **network-wireless-80**
  * wless on 100% ID: **network-wireless-100**
  * mobile broadband on 0% ID: **network-mobile-0**
  * mobile broadband on 20% ID: **network-mobile-20**
  * mobile broadband on 40% ID: **network-mobile-40**
  * mobile broadband on 60% ID: **network-mobile-60**
  * mobile broadband on 80% ID: **network-mobile-80**
  * mobile broadband on 100% ID: **network-mobile-100**
  * mobile broadband with access technology on 0% ID: **network-mobile-0-[technology]**
  (The optional `[technology]` suffix can be: `gprs`, `edge`, `umts`, `hsdpa`, `hsupa`, `hspa`, `lte`)

### Night color

* filename: **redshift.svg**
  * on ID: **redshift-status-on**
  * off ID: **redshift-status-off**

### preferences (some apps like bluedevil, krandrtray, text-to-speech)

* filename: **preferences.svg**
  * bluedevil generic bluetooth ID: **preferences-system-bluetooth**
  * bluedevil online bluetooth ID: **preferences-system-bluetooth-activated**
  * bluedevil offline ID: **preferences-system-bluetooth-inactive**
  * text-to-speech ID: **preferences-desktop-text-to-speech**
  * krandrtray ID: **preferences-desktop-display-randr**
  * activity manager ID: **preferences-activities**

### Printer applet

* filename: **printer.svg**
  * ID: **printer**

### Quassel IRC

* filename: **quassel.svg**
  * quassel offline ID: **quassel-inactive**
  * quassel online ID: **quassel**
  * quassel new message ID: **quassel-message**

### PackageKit updates

* filename: **update.svg**
  * some security updates available ID: **update-high**
  * some important updates available ID: **update-medium**
  * some regular updates available ID: **update-low**
  * no update available (or checking) ID: **update-none**

### KWallet

* filename: **wallet.svg**
  * open ID: **wallet-open**
  * closed ID: **wallet-closed**
