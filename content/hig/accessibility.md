---
title: "Accessibility and inclusiveness"
weight: 11
aliases:
- /hig/accessibility/
- /hig/accessibility/checklist/
---

## Accessibility
Following this guide will give you an app that's already quite accessible. Nonetheless, it's important to test your app in a way that simulates sensitivities or impairments you may not possess yourself. Use the following techniques:

### Keyboard
Unplug your mouse or disable your touchpad and attempt to interact with every UI element solely with the keyboard. Make sure the item with default focus makes sense, and each item with active focus looks visibly different from selected items in inactive views. Make sure no truly important text is only seen in a hover tooltip.

Name items in such a manner that the distinctive parts come first, so they are easier to select with the keyboard. For example, in a list of countries on continents, write "Germany (Europe)" instead of "Europe/Germany".

### Pointing device
Unplug or don't use your keyboard, and attempt to interact with every UI element solely with left-clicks from a pointing device and the virtual keyboard. Verify that all drag-and-drops show a preview of the dragged item and either succeed or show the “can't drag here” cursor.

### Touchscreen
If you have a touch-capable device, try using it exclusively. Verify that everything works and that the virtual keyboard appears only at the right times. Verify that hover tooltips also appear on press-and-hold.

### Color
Change the system-wide color scheme to something other than what you regularly use to verify that everything adapts as expected.

### Text size
Increase the system-wide font size to 14 and verify that visual relationships are preserved and text doesn't get cut off.

### Audio
Unplug or mute your speakers and verify that no information is only communicated via audio.

### Screen Reader
Turn off your screen and attempt to use the app with the Orca screen reader. It should say something intelligible and distinct for all elements. For GUI elements, it should say the label and type, e.g.: “File, Menu” or “Create New Folder, Button”. Verify that all tooltip text is read by the screen reader via the `Accessible` attached properties and that no labels are used more than once in the same window.

### Animations
Globally disable animations and verify that all animated UI elements either transition instantly (e.g. for a pushing a new page) or display a static image (e.g. for a loading spinner). Avoid blinking UI elements other than the text insertion point.

See the [Qt accessibility documentation](https://doc.qt.io/qt-6/accessible.html) for more information.


## Inclusiveness
Being accessible is not enough; your app must also feel _inclusive_ to avoid turning away potential users.

As with accessibility, following this guide will already give you an app that's quite inclusive. But there are a few more things to keep in mind as well.

### Assumptions
Avoid implicit references to or assumptions about the user with respect to:
- Physical abilities
- Age
- Gender or sexual orientation
- Ethnicity or national origin
- Mode of living
- Life experiences
- Level of education
- Religious, political, or philosophical views
- Economic resources
- Level of technical skill
- Etc.

### Negative language
Prefer neutral language over language referencing death, violence, crime, prejudice, stereotypes, or evil history. For example:
- Kill → Close
- Execute → Run
- Abort → Exit
- Fatal → Critical, major
- End of life → End of support
- Force → Require
- Illegal → Unauthorized
- Crippled, gimped → Broken, nonfunctional
- Slave → Worker, job
- Wiped out → Cleared
