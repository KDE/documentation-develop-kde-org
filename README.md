# KDE Developer website

https://develop.kde.org

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

Data for the icon galleries (i.e. `/frameworks/breeze-icons/`) must be downloaded and extracted via `scripts/icon_extractor.py`.
The script is configured with the correct paths for this repository and therefore may be executed without additional arguments.

```
usage: icon_extractor.py [-h] [-j OUTPUT_METADATA_DIR] [-d OUTPUT_ICONS_DIR] [-w WORK_DIR] [-p] [-v]

optional arguments:
  -h, --help            show this help message and exit
  -j OUTPUT_METADATA_DIR, --output-metadata-dir OUTPUT_METADATA_DIR
                        Path to directory where to write json metadata (default: data/icons)
  -d OUTPUT_ICONS_DIR, --output-icons-dir OUTPUT_ICONS_DIR
                        Path to directory where to copy icons (default: assets/icons)
  -w WORK_DIR, --work-dir WORK_DIR
                        Path to directory used as script workdir (default: ./workdir)
  -p, --pretty          Pretty write output json metadata (default: False)
  -v, --verbose         Increase logging to debug (default: False)
```

# Contributing to the KDE Developer website

To learn more about the formatting and custom tooling available to start contributing, see [CONTRIBUTING.md](contributing.md).

To learn more about tutorial style and the use cases of the available tools, see [STYLE.md](style.md).

## I18n
The Kirigami tutorials are internationalized and localized using [hugoi18n](https://invent.kde.org/websites/hugo-i18n).

## hugo-kde theme
This website uses a theme shared among KDE websites that are Hugo-based. If you have some issue that you think is not inside this repo, or if you just want to know more about the theme, have a look at [hugo-kde wiki](https://invent.kde.org/websites/hugo-kde/-/wikis/).
