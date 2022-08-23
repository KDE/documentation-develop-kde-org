# SPDX-FileCopyrightText: Year Author <email@company.com>
#
# SPDX-License-Identifier: BSD-2-Clause

cmake_minimum_required(VERSION 3.0)

project(timekcm)

set(QT_MIN_VERSION "5.15.0")
set(KF5_MIN_VERSION "5.88.0")

find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Quick
    Svg
)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS
    I18n
    KCMUtils
    Declarative
    Config
)

set(timesettings_SRCS
    timesettings.cpp
    timesettings.h
)

add_library(kcm_time MODULE ${timesettings_SRCS})

target_link_libraries(kcm_time
    Qt5::Core
    KF5::CoreAddons
    KF5::I18n
    KF5::QuickAddons
)

install(TARGETS kcm_time DESTINATION ${KDE_INSTALL_PLUGINDIR}/plasma/kcms/systemsettings)

kpackage_install_package(package kcm_time kcms) # Install our QML kpackage.
