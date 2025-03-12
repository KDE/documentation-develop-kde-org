---
title: "Plasma Widget tutorial"
weight: 2
description: >
  Learn how to create a KDE Plasma widget.
aliases:
  - /docs/plasma/widget/
---

The KDE wiki has a [Getting Started and Hello World](https://techbase.kde.org/Development/Tutorials/Plasma5) tutorial which you can read as well.


## Default Widgets

### Learn By Example

You can learn by example by reading the default widgets located at:  
`/usr/share/plasma/plasmoids/`

You can fork an existing widget by copying the widget to where the downloaded widgets are installed to:  
`~/.local/share/plasma/plasmoids/`

To properly fork the widget, rename the new folder, then edit the `Id` in the `metadata.json` file to match the new folder name. You will also want to edit the `Name` in the `metadata.json` file as well so you can tell it apart from the widget you forked it from. You should delete all the translated `Name[fr]` lines as well. Delete the `metadata.desktop` if it exists.

Finally, run `plasmawindowed` to quickly test the newly forked widget.

```bash
cd /usr/share/plasma/plasmoids/
mkdir -p ~/.local/share/plasma/plasmoids
cp -r /usr/share/plasma/plasmoids/org.kde.plasma.analogclock/ ~/.local/share/plasma/plasmoids/
cd ~/.local/share/plasma/plasmoids/
mv ./org.kde.plasma.analogclock ./com.github.zren.myanalogclock
cd ./com.github.zren.myanalogclock
sed -i 's/Analog Clock/My Analog Clock/' ./metadata.json
sed -i 's/org.kde.plasma.analogclock/com.github.zren.myanalogclock/' ./metadata.json
sed -i '/^\s*"Name\[/ d' ./metadata.json
sed -i '/^\s*"Description\[/ d' ./metadata.json
rm ./metadata.desktop
plasmawindowed com.github.zren.myanalogclock
```

Please fix all trailing comma errors in metadata.json. For example, there should be no trailing comma after:  
`"Name": "Marco Martin",`

{{< readfile file="/content/docs/plasma/widget/snippet/plasma-doc-style.html" >}}
