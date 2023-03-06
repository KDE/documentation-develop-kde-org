# SPDX-FileCopyrightText: Year Author <email@company.com>
#
# SPDX-License-Identifier: BSD-2-Clause

cmake_minimum_required(VERSION 3.16)

project(timekcm)

set(QT_MIN_VERSION "5.15.0")
set(KF5_MIN_VERSION "5.97.0")

find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Quick
)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS
    I18n
    KCMUtils
    Declarative
    Config
)

kcoreaddons_add_plugin(kcm_time INSTALL_NAMESPACE "plasma/kcms/systemsettings")

target_sources(kcm_time PRIVATE timesettings.cpp)

target_link_libraries(kcm_time
    Qt5::Core
    KF5::CoreAddons
    KF5::I18n
    KF5::QuickAddons
)

kpackage_install_package(package kcm_time kcms)

kcmutils_generate_desktop_file(kcm_time)
