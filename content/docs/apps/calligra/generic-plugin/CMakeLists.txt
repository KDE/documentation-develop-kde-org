cmake_minimum_required(VERSION 3.16)
project(myplugin)

set(CMAKE_AUTOMOC ON)

find_package(ECM REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)

find_package(CalligraQt6 REQUIRED COMPONENTS flake)

add_definitions(-DTRANSLATION_DOMAIN=\"myplugin\")

set(myplugin_SRCS
    MyPlugin.cpp
    MyShapeFactory.cpp
    MyShape.cpp
    MyToolFactory.cpp
    MyTool.cpp
)

add_library(myplugin MODULE ${myplugin_SRCS})

target_link_libraries(myplugin CalligraQt6::flake)

install(TARGETS myplugin DESTINATION ${KDE_INSTALL_PLUGINDIR}/calligra/shapes)
