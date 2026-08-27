cmake_minimum_required(VERSION 3.16)
project(fooshape)

set(CMAKE_AUTOMOC ON)

find_package(ECM 6 REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)

find_package(CalligraQt6 REQUIRED COMPONENTS flake)

add_definitions(-DTRANSLATION_DOMAIN=\"calligra_shape_foo\")

add_library(calligra_shape_foo MODULE
    KoFooShape.cpp
    FooShapeFactory.cpp
    FooShapePlugin.cpp
)

target_link_libraries(calligra_shape_foo CalligraQt6::flake)

install(TARGETS calligra_shape_foo DESTINATION ${KDE_INSTALL_PLUGINDIR}/calligra/shapes)
