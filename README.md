# KDE Developer website

## Running the website locally

Download the latest Hugo release (extended version) from [here](https://github.com/gohugoio/hugo/releases)
 and clone this repo.

Once you've cloned the site repo, from the repo root folder, run:

```
hugo server
```

## Creating an new article

Your accept that your contribution are licensed under the CC-BY-SA-4.0.

Each page of the website is located in `content`, for the documentation specific pages, there are
located at `content/docs`. To add a new articles just create a new makrdown file called `_index.md`
there at the location there you want to have it. e.g. for
https://developer.kde.org/docs/getting-started/installation, you need to create a file called
`content/docs/getting-started/installation/_index.md`.

This is the structure of a file:

```
---
title: Installation of the development libraries # title of the page
titleLink: Installation # title in the sidebar
description:
  > In this tutorial you will learn.... # Short summary of the page (displayed in the google description and as subtitle)
weight: 1 # ordering of the articles in the section
---

## Introduction

Normal markdown content
```

## Hugo shortcodes

There is also some custom commands that can be used to create more complex content. For the moment there is three of them available,
but more can be added if needed.

### alert

```
{{< alert title="Note" color="info" >}}
Text you want to display in the alert
{{< /alert >}}
```

Availble colors are `success`, `warning`, `error` and `info`.

### readfile

Read a file and apply syntax highlight on it. There is two option argument:

**start:** Defines the first line that should be displayed 

**lines:** Defines how many lines should be displayed.

```
{{< readfile file="/content/docs/getting-started/main_window/mainwindow.h" highlight="cpp" start="41" lines="13" >}}
```

### api-link

Currently does nothing but in the future should be able to create a link to the api documentation.

```
{{< api-link module="kxmlgui" link="KXmlGuiWindow" >}}
```
