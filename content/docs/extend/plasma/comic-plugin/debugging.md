---
title: Testing and debuggin
weight: 3
---


## Testing the plugin

To test the plugin you need to install it first:

```bash
kpackagetool5 -t Plasma/Comic -i my_comic.comic
```

That will install the plugin to `~/.local/share/plasma/comics/my_comic`
You could also directly edit `~/.local/share/plasma/comics/my_comic/contents/code/main.js`, but be sure to write the changes back in your project.

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

Often it happens that your plugin won't work the first try and the following
debuggin can be painful as there is not that much output unless you use some
tricks.

Add print-statements in your main.es file to see what the values of different
variables are and where your plugin stops working. Here are some examples:

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

I add "****" in the print to find the output more easily.
Sometimes when I do not find the error at first sight I add a lot print statements like in the example above to find the error (e.g. written something wrong, forgot something etc.).

In case all that does not work and pageRetrieved is still called you could use

```js
print(data);
```

so that you can check if the data is correct and if it is what you expected.
