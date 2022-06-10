[Skip to content](https://invent.kde.org/documentation/develop-kde-org/-/blob/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend/plasma/kwin/_index.md#content-body)

# GitLab [![img](https://invent.kde.org/uploads/-/system/appearance/header_logo/1/kde-logo-white-blue-128x128.png) ](https://invent.kde.org/)

- [       Menu       ](https://invent.kde.org/documentation/develop-kde-org/-/blob/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend/plasma/kwin/_index.md#)

- [  ](https://invent.kde.org/projects/new)
- [ ](https://invent.kde.org/search?project_id=4359)
- [ ](https://invent.kde.org/dashboard/issues?assignee_username=nclarius)
- [  ](https://invent.kde.org/dashboard/merge_requests?assignee_username=nclarius)
- [ ](https://invent.kde.org/dashboard/todos)
- [ Help     ](https://invent.kde.org/help)
- [![Natalie Clarius](https://invent.kde.org/assets/no_avatar-849f9c04a3a0d0cea2424ae97b27447dc64a7dbfae83c036c45b403392f0e8ba.png)   ](https://invent.kde.org/nclarius)

- [ D   Developer Tutorial and Article Site  ](https://invent.kde.org/documentation/develop-kde-org)
- [    Project information  ](https://invent.kde.org/documentation/develop-kde-org/activity)
- [    Repository  ](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38)
- [    Issues  32 ](https://invent.kde.org/documentation/develop-kde-org/-/issues)
- [    Merge requests  9 ](https://invent.kde.org/documentation/develop-kde-org/-/merge_requests)
- [    CI/CD  ](https://invent.kde.org/documentation/develop-kde-org/-/pipelines)
- [    Deployments  ](https://invent.kde.org/documentation/develop-kde-org/-/releases)
- [    Analytics  ](https://invent.kde.org/documentation/develop-kde-org/-/value_stream_analytics)
- [    Wiki  ](https://invent.kde.org/documentation/develop-kde-org/-/wikis/home)
- [    Snippets  ](https://invent.kde.org/documentation/develop-kde-org/-/snippets)



- [![img](https://invent.kde.org/uploads/-/system/group/avatar/1572/avatar.png?width=15)Documentation](https://invent.kde.org/documentation)

- [Developer Tutorial and Article Site](https://invent.kde.org/documentation/develop-kde-org)

- ## [Repository](https://invent.kde.org/documentation/develop-kde-org/-/blob/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend/plasma/kwin/_index.md)







- [develop-kde-org ](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38)
- [content](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content)
- [docs](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs)
- [extend](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend)
- [plasma](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend/plasma)
- [kwin](https://invent.kde.org/documentation/develop-kde-org/-/tree/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend/plasma/kwin)
- [**_index.md** ](https://invent.kde.org/documentation/develop-kde-org/-/blob/5cd339650c10b6019feb4f2fb5a0613d85cd3c38/content/docs/extend/plasma/kwin/_index.md)

- [![Natalie Clarius's avatar](https://invent.kde.org/assets/no_avatar-849f9c04a3a0d0cea2424ae97b27447dc64a7dbfae83c036c45b403392f0e8ba.png)](https://invent.kde.org/nclarius)

  [Update _index.md](https://invent.kde.org/documentation/develop-kde-org/-/commit/734a125195784387d4d6ce6136dc038ff3cf7e85)

  [Natalie Clarius](https://invent.kde.org/nclarius) authored Apr 23, 2022, 2:11 AM

  734a1251

**_index.md**

14.6 KB







```yaml
title: KWin Scripting Tutorial
weight: 4
description: Learn how to programmatically manipulate windows with KWin scripts.
aliases:
  - /docs/plasma/kwin/
```
## Your second (useful) script

Suppose you want to create custom quick-tile zones and a have keyboard shortcuts to tile a window to quarters of the screen width, i.e. the left or right 25% or 75% of the screen.

### Client geometry

A client’s geometry is defined is defined by four components:

- Its position, given by two coordinates `x` and `y`. `x` is the horizontal offset of the left window edge from the left edge of the screen area, and `y` is the veritcal offset of the top window edge from the top edge of screen area. 
- Its size, given by `width` and `height`.

Alternatively, a client's geometry can be given in terms of the four edges `left`, `top`, `right`, `bottom`, where `left` and `top` are identical to `x` and `y` respectively, and `right` and `bottom` are equal to `x + width - 1` and `y + height - 1` respectively.

```plaintext
|       width        |
| x    | ... |       | x + width 
| left | ... | right |

-------------
h  y  top
e  ----------
i  ...
g
h  ----------
t     bottom
-------------
y + height
```



Note that position coordinates are relative to the area of all screens combined, not of the screen the window is on, meaning that e.g. on a multi-monitor setup with two 1920x1080 screens next to each other, a window 10px from the left edge of the right display will be at `x` = `1930` (= `1920 + 10`).

In the scripting API, a client’s geometry is given by the `frameGeometry` property. For convenience,`x`, `y`, `width`, `height` are also available as read-only properties directly of a client object, and the edge values are readable as properties of the `frameGeometry` . Try it out:

```javascript
print(workspace.activeClient.frameGeometry);
```

To modify a client’s geometry, the `x`, `y`, `width`, `height` properties of the `frameGeometry` property must be used.  Modifying the `x` and `y` values will move a client (from the left/top edge); modifying the `width` and `height` values will resize a client (from the right/bottom edge).

### Area geometry


Given a client, we can get the rectangle of the area it can take up on the current screen with

```javascript
workspace.clientArea(KWin.MaximizeArea, client)
```

This area is a recangle with the same properties as a client’s frame geometry.

On a related note, we could use this to test whether a client is maximized by checking whether the client’s geometry is the same as the screen area’s:

```javascript
function isMaximized(client) {
    return client.frameGeometry == workspace.clientArea(KWin.MaximizeArea, client);
}
```

### Putting it together

We can now define functions to set the with of a client to a certain proportion of the screen area as follows:

```javascript
function setOneQuarterWidth(client) {
    let area = workspace.clientArea(KWin.MaximizeArea, client);
    client.frameGeometry.width = Math.round(0.25 * area.width);
}

function setThreeQuarterWidth(client) {
    let area = workspace.clientArea(KWin.MaximizeArea, client);
    client.frameGeometry.width = Math.round(0.75 * area.width);
}
```

And to tile it the left or right side of the screen:

```javascript
function setLeft(client) {
    let area = workspace.clientArea(KWin.MaximizeArea, client);
    // client stats horizontally at the left edge of the screen
    client.frameGeometry.x = area.x;
}

function setRight(client) {
    let area = workspace.clientArea(KWin.MaximizeArea, client);
    // client starts horizontally at the distance of its width from the right edge of the screen
    client.frameGeometry.x = area.x + area.width - client.width;
}
```

### Setting up shortcuts

Finally, we can register keyboard shortcuts to tile the active client to one of the four possible rectangles:

```javascript
registerShortcut("Quick Tile Window to the Left 25%",
                 "Quick Tile Window to the Left 25%",
                 "Meta+Alt+A",
                 () => {
                     let active = workspace.activeClient;
                     setOneQuarterWidth(active);
                     setLeft(active);
                 });

registerShortcut("Quick Tile Window to the Left 75%",
                 "Quick Tile Window to the Left 75%",
                 "Meta+Alt+S",
                 () => {
                     let active = workspace.activeClient;
                     setThreeQuarterWidth(active);
                     setLeft(active);
                 });

registerShortcut("Quick Tile Window to the Right 75%",
                 "Quick Tile Window to the Right 75%",
                 "Meta+Alt+D",
                 () => {
                     let active = workspace.activeClient;
                     setThreeQuarterWidth(active);
                     setRight(active);
                 });

registerShortcut("Quick Tile Window to the Right 25%",
                 "Quick Tile Window to the Right 25%",
                 "Meta+Alt+F",
                 () => {
                     let active = workspace.activeClient;
                     setOneQuarterWidth(active);
                     setRight(active);
                 });
```

These shortcuts can later be configured by the user in the system settings.

