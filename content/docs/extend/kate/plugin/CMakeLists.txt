cmake_minimum_required(VERSION 3.16)
project(markdownpreview VERSION 1.0)

find_package(ECM ${KF5_DEP_VERSION} QUIET REQUIRED NO_MODULE)

list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)

find_package(Qt${QT_MAJOR_VERSION}Widgets CONFIG REQUIRED)

set(KF5_DEP_VERSION "5.90")
find_package(KF5 ${KF5_DEP_VERSION}
    REQUIRED COMPONENTS
        CoreAddons # Core addons on top of QtCore
        I18n # For localization
        TextEditor # The editor component
)

# This line defines the actual target
kcoreaddons_add_plugin(markdownpreview # your plugin name here
    INSTALL_NAMESPACE "ktexteditor")

target_sources(
  markdownpreview
  PRIVATE
  plugin.h
  plugin.cpp
)

# This makes the plugin translatable
target_compile_definitions(markdownpreview PRIVATE TRANSLATION_DOMAIN="markdownpreview")

target_link_libraries(markdownpreview
    PRIVATE
    KF5::CoreAddons KF5::I18n KF5::TextEditor
)
