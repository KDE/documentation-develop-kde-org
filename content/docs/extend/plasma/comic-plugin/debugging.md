---
title: Testing and debugging
weight: 3
# Rewrite of KDE4 version for Plasma 5
SPDX-FileCopyrightText: 2022 Alexander Lohnau <alexander.lohnau@gmx.de>
---


## Testing the plugin

To test the plugin you need to install it first:

```bash
kpackagetool5 -t Plasma/Comic -i my_comic.comic
```

That will install the plugin to `~/.local/share/plasma/comics/my_comic`
You can also directly edit `~/.local/share/plasma/comics/my_comic/contents/code/main.js`, but be sure to write the changes back in your project.

To test your plugin type:

```bash
plasmoidviewer -a org.kde.plasma.comic
```

and enable plugin in the settings. That way the plugin will be loaded and you will see the debug output in the terminal.
Comic strips will be cached at `~/.local/share/plasma_engine_comic/` so if you change the applet it might be good to clean the cache before further testing by:

```bash
rm -r ~/.local/share/plasma_engine_comic/
```

## Debugging the plugin

Sometimes your plugin won't work on the first attempt, and debugging might be difficult because there isn't a lot of output unless you employ specific tricks.

To observe the values of various variables and where your plugin breaks, add print-statements to your main.js file. Here are a few instances:

```js
function init() {
    ...
    var url = "XY" + comic.identifier;
    print("***url: " + url);
    ...
}

function pageRetrieved(id: string, data) {
    if (id === comic.page) {
        print("****in comic.page");
        ...
        print("****a");
        ...
        print("****b");
        ...
        print("****id: " + comic.identifier);
    }
}
```

To make it easier to find the output, I add "****" to the print.
Sometimes when I do not immediately spot the issue, I add more print statements, as in the example above, to help me locate issue (e.g. written something wrong, forgot something etc.).

If none of that succeeds and pageRetrieved is still called, try using
```js
print(data);
```

so that you can check if the data is correct.
