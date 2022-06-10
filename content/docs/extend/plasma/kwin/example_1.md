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
## Your first (useful) script

In this tutorial we will be creating a script based on a suggestion by Eike Hein. In Eike’s words: “A quick use case question: For many years I’ve desired the behavior of disabling keep-above on a window with keep-above enabled when it is maximized, and re-enabling keep-above when it is restored. Is that be possible with kwin scripting? It’ll need the ability to trigger methods on state changes and store information above a specific window across those state changes, I guess.”

Other than the really functional and useful script idea, what is really great about this is that it makes for a perfect tutorial example. We get to cover most of the important aspects of KWin scripting while at the same time creating something useful.

So let’s get on with it…

### The basic outline

Design statement: For every window that is set to ‘Keep Above’ others, the window should not be above all windows when it is maximized.

To do so, this is how we’ll proceed:

1. Create an array of clients whose **Keep Above** property has been removed for maximized windows
2. Whenever a client is maximized, if it’s **Keep Above** property is set, remove the **Keep Above** property.
3. Whenever a client is restored, if it is in the ‘array’, set it’s **Keep Above** property.

### The basic framework

So, for first steps, let us just create an array:

```javascript
var keepAboveMaximized = [];
```

Now we need to know whenever a window got maximized. There are two approaches to achieve that: either connect to a signal emitted on the workspace object or to a signal of the client. As we need to track all Clients it is easier to just use the signal `clientMaximizeSet` on the workspace. This signal is emitted whenever the maximizationf state of a Client changes and passes the client and two boolean flags to the callback. The flags indicate whether the Client is maximized horizontally and/or vertically. If a client is maximized both horizontally and vertically it is considered as fully maximized. Let's try it:

```javascript
workspace.clientMaximizeSet.connect(function(client, h, v) {
  if (h && v) {
    print(client.caption + " is fully maximized");
  } else {
    print(client.caption + " is not maximized");
  }
});
```

Best give the script a try in the desktop scripting console and play with your windows. Remember right and middle clicking the maximize button changes the horizontal/vertical state of the window.

### Checking keep above

Now we actually want to do something with the maximized Client. We need to check whether the window is set as keep above. If it is so, we need to remove the keep above state and remember that we modified the Client. For better readability the callback is moved into an own method:

```javascript
function manageKeepAbove(client, h, v) {
  if (h && v) {
    // maximized
    if (client.keepAbove) {
      keepAboveMaximized.push(client);
      client.keepAbove = false;
    }
  }
}
```

This code checks whether the window is maximized, if that is the case we access the Client's `keepAbove` property which is a boolean. If the Client is keep above we append the Client to our global array `keepAboveMaximized` of Clients we modified. This is important to be able to reset the keep above state when the window gets restored again.

Last but not least we have to remove keep above which is a simple assignment to the Client's property. If you want to test it in the desktop scripting console remember to adjust the signal connection:

```javascript
workspace.clientMaximizeSet.connect(manageKeepAbove);
```

### Restoring it all

Now the last and most important part of it all. Whenever the client is restored, we must set it’s `‘Keep Above’` property if it was set earlier. To do this, we must simply extend our manageKeepAbove code to handle this scenario. In case the client is not maximized both vertically and horizontally, we check if the client is in our keepAboveMaximized array and if it is, we set its ‘Keep Above’ property, otherwise we don’t bother:

```javascript
function manageKeepAbove(client, h, v) {
  if (h && v) {
    // maximized
    if (client.keepAbove) {
      keepAboveMaximized[keepAboveMaximized.length] = client;
      client.keepAbove = false;
    }
  } else {
    // no longer maximized
    var found = keepAboveMaximized.indexOf(client);
    if (found != -1) {
      client.keepAbove = true;
      keepAboveMaximized.splice(found, 1);
    }
  }
}
```


### Configuration

Suppose we would like the script to only be applied to certain applications, or to exclude specific applications for the script to be applied to. It would be desirable for this to be configurable by the user.

#### Declaration

We start by specifying the configuration module in the metadata:

```javascript
"X-KDE-ConfigModule": "kwin/effects/configs/kcm_kwin4_genericscripted"
```

and then setting up the basic skeleton for the configuration declaration in a file `contents/config/main.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0 http://www.kde.org/standards/kcfg/1.0/kcfg.xsd">
    <kcfgfile name=""/>
    <group name="">
    </group>
</kcfg>
```

The applications to consider are most easily treated as a linebreak-separated string of window classes and would not contain anything by default, so we add a new configuration entry `applications` of type `String` which as its default value has an empty string:

```xml
...
    <group name="">
        <entry name="applications" type="String">
            <label>Linebreak-separated list of window classes</label>
            <default></default>
    	</entry>
    </group>
...
```

There are two possibilities on how how the exceptional applications could be treated: Either the script is applied to all applications except the one listed in the configuration (the list is an exclude list), or it is applied to only the applications listed in the configuration and nothing else (include list). We will assume the list to work as an exclude list by default but let the user opt in to it being an include list, and add two corresponding boolean configuration entries `excludeList` and `includeList`:

```xml
...
        <entry name="excludeList" type="Bool">
            <label>Apply the script to all applications except the ones in the list</label>
            <default>true</default>
    	</entry>
        <entry name="includeList" type="Bool">
            <label>Apply the script to only the applications in the list</label>
            <default>false</default>
    	</entry>
...
```

#### Graphical interface

It is not possible to set values for these configuration in the user KWin configuration file, but of course it would be much nicer if the script provided a graphical interface where the user can click buttons to adapt the settings. Using Qt Designer to set up new file from the widget template, filling in an object name an window title, and setting the widget to be layed out vertically,  gives the file `contents/ui/config.ui` this content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>MaximizedKeepAboveConfigForm</class>
 <widget class="QWidget" name="MaximizedKeepAboveConfigForm">
  <property name="geometry">
   <rect>
    <x>0</x>
    <y>0</y>
    <width>400</width>
    <height>200</height>
   </rect>
  </property>
  <property name="windowTitle">
   <string>Disable keep above when maximized</string>
  </property>
    <layout class="QVBoxLayout" name="verticalLayout"/>
 </widget>
 <resources/>
 <connections/>
</ui>
```

First we want the user to choose between exclude mode and include mode. Since these entries are boolean variables out of which exactly one should be true, the best UI element to use for this is radio buttons. We add them inside the vertical layout, give them a meaningful text and as the object name use `kcfg_` + the name of the entry as defined in the xml file, and set the first radio button to be checked by default. The UI file now looks as follows:

```xml
...
    <layout class="QVBoxLayout" name="verticalLayout">
     <item>
      <widget class="QRadioButton" name="kcfg_excludeList">
       <property name="text">
        <string>Apply the script to all except the following applications</string>
       </property>
       <property name="checked">
        <bool>true</bool>
       </property>
      </widget>
     </item>
     <item>
      <widget class="QRadioButton" name="kcfg_includeList">
       <property name="text">
        <string>Apply the script to only the following applications</string>
       </property>
      </widget>
     </item>
    </layout>
...
```

Next we add a plain text edit input widget which will hold the list of window classes stored as the entry `kcfg_application`, with a placeholder text explaining how the list is supposed to be entered:

```xml
...
     <item>
      <widget class="QPlainTextEdit" name="kcfg_applications">
       <property name="placeholderText">
        <string>Enter a list of window classes, one per line</string>
       </property>
      </widget>
     </item>
...
```

Finally, it may be necessary to adjust the minimum width and height of the widget to fit the content.

#### Using the configuration

Now it is time to make use of the configuration in the script.

We read in the configuration entries by their names as defined in the kcfg:

```javascript
const excludeList = readConfig("excludeList", true);
const includeList = readConfig("includeList", false);
const applications = readConfig("applications", "").split("\n").map(entry => entry.toLowerCase().trim());
```

The list of applications comes as a newline-separated string of window classes, and we turn it into a list of strings by splitting by the newline character, then bring the entries into a consistent format by lowercasing the them and trimming possible whitspace from the ends.

The user configuration enters the script as a return condition at the beginning of the function which handles the maximized cllients:

```javascript
...
function manageKeepAbove(client, h, v) {
	// check for window classes specified in the user configuration
    // (return conditions here)
...
```

The client’s class name to be checked against the list of specified applications can be accessed as the property `client.resourceClass`. We exit the function call and do nothing about the client in the following cases:

- The list of applications is a exclude list, and the client’s class is among this list of applications to be excluded:

  ```javascript
  if (excludeList && applications.includes(client.resourceClass)) return;
  ```

- The list of applicaitons is an include list, and the client's class does not occur among this list of applications to be included:

  ```javascript
  if (includeList && !applications.includes(client.resourceClass)) return;
  ```


### Wrapping it up

In the end, our whole KWin script package looks as follows:

```
maximizedkeepabove
├── contents
│   ├── code
│   │   └── main.js
│   ├── config
│   │   └── main.xml
│   └── ui
│       └── config.ui
├── metadata.json
```

`metadata.json`

```json
{
    "KPlugin": {
        "Name": "Disable keep above when maximized",
        "Description": "Disables keep-above on a window when it is maximized, and reenables keep-above when it is restored",
        "Icon": "preferences-system-windows",

        "Authors": [
            {
                "Email": "username@gmail.com",
                "Name": "Firstname Lastname"
            }
        ],
        "Id": "maximizedkeepabove",
        "ServiceTypes": [
            "KWin/Script"
        ],
        "Version": "1.0",
        "Licsense": "GPLv3",
        "Website": "https://github.com/username/maximizedkeepabove"
    },
    "X-Plasma-API": "javascript",
    "X-Plasma-MainScript": "code/main.js",
    "X-KDE-ConfigModule": "kwin/effects/configs/kcm_kwin4_genericscripted"
}
```

`contents/code/main.js`

```javascript
// configuration
const excludeList = readConfig("excludeList", true);
const includeList = readConfig("includeList", false);
const applications = readConfig("applications", "").split("\n").map(entry => entry.toLowerCase().trim());

var keepAboveMaximized = new Array();

function manageKeepAbove(client, h, v) {
  // check for window classes specified in the user configuration
  if (excludeList && applications.includes(client.resourceClass)) return;
  if (includeList && !applications.includes(client.resourceClass)) return;

  if (h && v) {
    // maximized
    if (client.keepAbove) {
      keepAboveMaximized[keepAboveMaximized.length] = client;
      client.keepAbove = false;
    }
  } else {
    // no longer maximized
    var found = keepAboveMaximized.indexOf(client);
    if (found != -1) {
      client.keepAbove = true;
      keepAboveMaximized.splice(found, 1);
    }
  }
}

workspace.clientMaximizeSet.connect(manageKeepAbove);
```

`contents/config/main.xml`


```xml
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0 http://www.kde.org/standards/kcfg/1.0/kcfg.xsd">
    <kcfgfile name=""/>
    <group name="">
        <entry name="excludeList" type="Bool">
            <label>Apply the script to all applications except the ones in the list</label>
            <default>true</default>
    	</entry>
        <entry name="includeList" type="Bool">
            <label>Apply the script to only the applications in the list</label>
            <default>false</default>
    	</entry>
        <entry name="applications" type="String">
            <label>Comma-separated list of window classes</label>
            <default></default>
    	</entry>
    </group>
</kcfg>
```

`contents/ui/config.ui`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>MaximizedKeepAboveConfigForm</class>
 <widget class="QWidget" name="MaximizedKeepAboveConfigForm">
  <property name="geometry">
   <rect>
    <x>0</x>
    <y>0</y>
    <width>400</width>
    <height>200</height>
   </rect>
  </property>
  <property name="minimumSize">
   <size>
    <width>400</width>
    <height>200</height>
   </size>
  </property>
  <property name="windowTitle">
   <string>Disable keep above when maximized</string>
  </property>
    <layout class="QVBoxLayout" name="verticalLayout">
     <item>
      <widget class="QRadioButton" name="kcfg_excludeList">
       <property name="text">
        <string>Apply the script to all except the following applications</string>
       </property>
       <property name="checked">
        <bool>true</bool>
       </property>
      </widget>
     </item>
     <item>
      <widget class="QRadioButton" name="kcfg_includeList">
       <property name="text">
        <string>Apply the script to only the following applications</string>
       </property>
      </widget>
     </item>
     <item>
      <widget class="QPlainTextEdit" name="kcfg_applications">
       <property name="placeholderText">
        <string>Enter a list of window classes, one per line</string>
       </property>
      </widget>
     </item>
    </layout>
 </widget>
 <resources/>
 <connections/>
</ui>
```

### What next?

The script is of course very simple. For example, it does not take care of windows which are already present when the window manager starts. Or you may want to restrict the scope of the script to certain window types. It's up to you.
