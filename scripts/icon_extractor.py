#!/usr/bin/env python
#
# SPDX-FileCopyrightText: 2020 David Barchiesi <david@barchie.si>
# SPDX-FileCopyrightText: 2024 Julius Künzel <jk.kdedev@smartlab.uber.space>
#
# SPDX-License-Identifier: GPL-3.0-or-later

import os
import sys
import json
import argparse
import re
import gzip
import logging
import shutil

from ciutilities.components import Package
import tarfile


ICON_THEMES = {
    'breeze': {
        'sub_path': 'breeze',
        'project_path': 'breeze-icons',
        'branch': 'master'
    },
    'oxygen': {
        'sub_path': 'oxygen/base',
        'project_path': 'oxygen-icons',
        'branch': 'master'
    }
}


class SetEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, set):
            return list(obj)

        return json.JSONEncoder.default(self, obj)


def parse_args(out_metadata, out_icons):
    if out_metadata:
        output_metadata_dir_kwargs = {
            'default': out_metadata
        }
    else:
        output_metadata_dir_kwargs = {
            'required': True
        }

    if out_icons:
        output_icons_dir_kwargs = {
            'default': out_icons
        }
    else:
        output_icons_dir_kwargs = {
            'required': True
        }

    workdir_default = './icon-extractor-workdir'
    if len(sys.path) > 0 and sys.path[0]:
        workdir_default = os.path.normpath(os.path.join(sys.path[0], './icon-extractor-workdir/'))

    input_dir_default = os.environ.get('XDG_DATA_DIRS', '')

    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-i', '--input-base-dir', default=input_dir_default, help='Path to directory where the icon themes are installed. Multiple paths with colon (:) as seperator are supported. Default is $XDG_DATA_DIRS')
    parser.add_argument('-j', '--output-metadata-dir', help='Path to directory where to write json metadata', **output_metadata_dir_kwargs)
    parser.add_argument('-d', '--output-icons-dir', help='Path to directory where to copy icons', **output_icons_dir_kwargs)
    parser.add_argument('-w', '--work-dir', default=workdir_default, help='Path to directory used as script workdir')
    parser.add_argument('-p', '--pretty', action='store_true', help='Pretty write output json metadata')
    parser.add_argument('-v', '--verbose', action='store_true', help='Increase logging to debug')
    return parser.parse_args()


def get_dirs(path):
    with os.scandir(path) as it:
        for entry in it:
            if not entry.name.startswith('.') and entry.is_dir():
                yield (entry.name, entry.path)


def iterate_icons(icon_theme_path):
    # Size folders are one of the following types: 128x128, 16, 22@2x, symbolic
    size_folder_matcher = re.compile(r'^(\d+|\d+x\d+|\d+x?@\d+x|symbolic|scalable)$')

    # Iterate first level under icon_theme_path. Could be size folders or context
    # folders
    for dir_name, dir_path in get_dirs(icon_theme_path):
        if size_folder_matcher.match(dir_name):
            # Icon theme structure is of "theme/size/context" kind
            size = dir_name
        else:
            # Icon theme structure is of "theme/context/size" kind
            category_name = dir_name

        # Iterate second level of icon_theme_path. If above was size folders, we should
        # have context folders on this level. Otherwise, parent should be context and sizes
        # should be on this level
        for subdir_name, subdir_path in get_dirs(dir_path):
            if size_folder_matcher.match(subdir_name):
                # Icon theme structure is of "theme/context/size" kind
                size = subdir_name
            else:
                # Icon theme structure is of "theme/size/context" kind
                category_name = subdir_name

            # Iterate third level of icon_theme_path. Regardless of the above cases, we
            # are on the icon level
            with os.scandir(subdir_path) as it:
                for entry in it:
                    if not entry.name.startswith('.') and entry.is_file():
                        yield (category_name, size, entry.name, entry.path)


def get_printable_name(name):
    if not name:
        return ''
    return os.path.splitext(name)[0]


ICON_LAST_BEST_SIZE = {}
def is_size_better(category, icon, size):
    result = re.search(r'^((\d+)|(\d+)x(\d+)|(\d+)x?@\d+x)$', size)
    if result: # we have a numeric match
        if result.group(2): # simple size, take it
            extrapolated_size = int(result.group(2))
        elif result.group(3) and result.group(4): # '26x26', the biggest of the two
            extrapolated_size = max(int(result.group(3)), int(result.group(4)))
        elif result.group(5): # '26@2x', take the int on the left side of the '@'
            extrapolated_size = int(result.group(5))
    elif size == 'symbolic': # symbolic should be pretty small so worst possible choice
        extrapolated_size = 1
    elif size == 'scalable': # 'scalable' should be best choice
        extrapolated_size = 666

    previous_size = ICON_LAST_BEST_SIZE.get(category + icon, 0)
    if extrapolated_size > previous_size:
        ICON_LAST_BEST_SIZE[category + icon] = extrapolated_size
        return True

    return False


def get_categories(icon_theme_path):
    categories = {}
    for (category_name, size, icon_name, icon_path) in iterate_icons(icon_theme_path):
        logging.debug(f'Processing icon "{icon_path}"')
        category = categories.get(category_name, {})

        icon = category.get(icon_name)
        if not icon:
            icon = {
                'name': get_printable_name(icon_name),
                'sizes': {}
            }
        icon_size_path = os.path.relpath(icon_path, icon_theme_path)
        icon['sizes'][size] = icon_size_path

        if is_size_better(category_name, icon_name, size):
            logging.debug(f'Using size {size} as preview_path for {icon_name}')
            icon['preview_path'] = icon_size_path

        category[icon_name] = icon
        categories[category_name] = category

    return categories


def icon_extractor(icons_root, output_icons, output_metadata, pretty_json=False):
    logging.info(f'Extracting from {icons_root} to {output_metadata} and {output_icons}')
    categories = get_categories(icons_root)

    # Copy icons
    if os.path.exists(output_icons):
        shutil.rmtree(output_icons)
    for dir_name, dir_path in get_dirs(icons_root):
        dir_path_out = os.path.join(output_icons, dir_name)
        shutil.copytree(dir_path, dir_path_out, symlinks=True)

    # Uncompress svgz
    for category in categories:
        icon_filenames = list(categories[category])
        for icon_filename in icon_filenames:
            if not icon_filename.endswith('svgz'):
                continue

            icon = categories[category].pop(icon_filename)

            preview_path_svg = os.path.splitext(icon['preview_path'])[0] + '.svg'
            icon['preview_path'] = preview_path_svg

            for size in icon['sizes']:
                # In svgz paths
                icon_path_svgz = icon['sizes'][size]
                icon_path_svgz_out = os.path.join(output_icons, icon_path_svgz)

                # Out svg paths
                icon_path_svg = os.path.splitext(icon_path_svgz)[0] + '.svg'
                icon_path_svg_out = os.path.join(output_icons, icon_path_svg)

                # Replace compressed svg with uncompressed one
                logging.debug(f'Uncompressing {icon_path_svgz_out}')
                with gzip.open(icon_path_svgz_out) as compressed:
                    with open(icon_path_svg_out, 'wb') as uncompressed:
                        uncompressed.write(compressed.read())
                os.remove(icon_path_svgz_out)

                icon['sizes'][size] = icon_path_svg

            icon_filename_svg = os.path.splitext(icon_filename)[0] + '.svg'
            categories[category][icon_filename_svg] = icon

    # Write resulting json metadata
    with open(output_metadata, 'w') as outfile:
        indent = None
        if pretty_json:
            indent = 4
        json.dump(categories, outfile, cls=SetEncoder, indent=indent)

    icon_total = 0
    for category in categories:
        icon_total += len(categories[category])
    logging.info(f'Processed {icon_total} icons in {icons_root}')


if __name__ == '__main__':
    detected_out_metadata = None
    detected_out_icons = None
    if len(sys.path) > 0 and sys.path[0]:
        detected_out_metadata = os.path.normpath(os.path.join(sys.path[0], '../data/icons/'))
        detected_out_icons = os.path.normpath(os.path.join(sys.path[0], '../assets/themeicons/'))

    args = parse_args(detected_out_metadata, detected_out_icons)

    if args.verbose:
        log_level = logging.DEBUG
    else:
        log_level = logging.INFO
    logging.basicConfig(format='%(levelname)s: %(message)s', level=log_level)

    # Create workdir where all icons will be processed
    if not os.path.exists(args.work_dir):
        os.mkdir(args.work_dir)

    localCachePath = os.environ.get('KDECI_CACHE_PATH', '/tmp')
    gitlabInstance = os.environ.get('KDECI_GITLAB_SERVER', 'https://invent.kde.org/')
    gitlabToken    = os.environ.get('KDECI_GITLAB_TOKEN')
    packageProject = os.environ.get('KDECI_PACKAGE_PROJECT', 'teams/ci-artifacts/suse-qt6.9')

    packageRegistry = Package.Registry(localCachePath, gitlabInstance, gitlabToken, packageProject)

    for theme_name in ICON_THEMES:
        theme = ICON_THEMES[theme_name]

        data_dirs = args.input_base_dir.split(":")

        icon_root = None
        for data_dir in data_dirs:
            path_candidate = os.path.join(data_dir, theme['sub_path'])
            if os.path.exists(path_candidate):
                icon_root = path_candidate
                break

            path_candidate = os.path.join(data_dir, 'icons', theme['sub_path'])
            if os.path.exists(path_candidate):
                icon_root = path_candidate
                break

        if not icon_root:
            logging.info(f"Icon files for theme \"{theme_name}\" not found, fetching them now")

            dependenciesToUnpack = packageRegistry.retrieveDependencies({theme['project_path']: theme['branch']})

            # And then unpack them
            for packageContents, packageMetadata in dependenciesToUnpack:
                # Open the archive file
                archive = tarfile.open( name=packageContents, mode='r' )
                # Extract it's contents into the install directory
                archive.extractall( path=args.work_dir )

                icon_root = os.path.join(args.work_dir, 'share/icons', theme['sub_path'])


        # Call icon extractor script
        icon_output_data = os.path.join(args.output_icons_dir, theme_name)
        icon_output_metadata = os.path.join(args.output_metadata_dir, theme_name) + '.json'
        icon_extractor(icon_root, icon_output_data, icon_output_metadata, args.pretty)
