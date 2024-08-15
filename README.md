# KDE Developer website

The [KDE Developer website](https://develop.kde.org) is built using [Hugo](https://gohugo.io/) and is hosted on [Invent](https://invent.kde.org/documentation/develop-kde-org).

It is home to the [development tutorials](https://develop.kde.org/docs/) and the [KDE Human Interface Guidelines](https://develop.kde.org/hig/).

# Contributing to the KDE Developer website

The source code for this website can be found at https://invent.kde.org/documentation/develop-kde-org.

To learn more about the formatting and custom tooling available to start contributing, see the [Formatting Guidelines](https://develop.kde.org/docs/contribute/formatting/).

To learn more about tutorial style and the use cases of the available tools, see the [Style Guidelines](https://develop.kde.org/docs/contribute/style/).

To learn how to submit a contribution, see [Submitting a Merge Request](https://community.kde.org/Infrastructure/GitLab#Submitting_a_merge_request).

## Before running the website

Download the latest Hugo release (extended version) from [here](https://github.com/gohugoio/hugo/releases) and clone this repo. Once you've cloned the site repo, enter the repo root folder.

Certain tutorials fetch examples directly from their respective repositories (library-specific ones, like KArchive or KAuth); to display them, you'll need to run a Python script.
Make sure you have the required dependencies installed on your system. We suggest using `venv` for this:

```
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Then, run this Python script:

```
python3 scripts/extract-plasma-applet-config-keys.py
```

## Running the website locally

From the repo's root folder, run:

```
hugo server
```

And open http://localhost:1313


## Extract icon metadata

Data for the icon galleries (i.e. `/frameworks/breeze-icons/`) must be extracted via `scripts/icon_extractor.py`.
The script is configured with the correct paths for this repository and therefore may be executed without additional arguments.
It expects breeze-icons and oxygen-icons to be installed on the system (the base install path can be configured, see below). If icons are not found, they will be fetched.

```
usage: icon_extractor.py [-h] [-i INPUT_BASE_DIR] [-j OUTPUT_METADATA_DIR] [-d OUTPUT_ICONS_DIR] [-w WORK_DIR] [-p] [-v]

options:
  -h, --help            show this help message and exit
  -i INPUT_BASE_DIR, --input-base-dir INPUT_BASE_DIR
                        Path to directory where the icon themes are installed. Multiple paths with colon (:) as seperator are supported. Default is $XDG_DATA_DIRS (default:
                        /home/konqi/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:/var/lib/snapd/desktop)
  -j OUTPUT_METADATA_DIR, --output-metadata-dir OUTPUT_METADATA_DIR
                        Path to directory where to write json metadata (default: data/icons)
  -d OUTPUT_ICONS_DIR, --output-icons-dir OUTPUT_ICONS_DIR
                        Path to directory where to copy icons (default: assets/icons)
  -w WORK_DIR, --work-dir WORK_DIR
                        Path to directory used as script workdir (default: scripts/icon-extractor-workdir)
  -p, --pretty          Pretty write output json metadata (default: False)
  -v, --verbose         Increase logging to debug (default: False)
```

## I18n
The Kirigami tutorials are internationalized and localized using [hugoi18n](https://invent.kde.org/websites/hugo-i18n).

## hugo-kde theme
This website uses a theme shared among KDE websites that are Hugo-based. If you have some issue that you think is not inside this repo, or if you just want to know more about the theme, have a look at [hugo-kde wiki](https://invent.kde.org/websites/hugo-kde/-/wikis/).
