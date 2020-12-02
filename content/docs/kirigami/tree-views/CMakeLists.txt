# SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
#
# SPDX-License-Identifier: BSD-3-Clauses

cmake_minimum_required(VERSION 3.8)

project(tree-view-example VERSION "1.0")

set(QT_MIN_VERSION "5.14.0")
set(KF5_MIN_VERSION "5.70.0")

include(FeatureSummary)

################# set KDE specific information #################
find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMPoQmTools)

find_package(Qt5 ${QT_MIN_VERSION} REQUIRED COMPONENTS Core Gui Qml QuickControls2 Svg)
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Kirigami2 ItemModels I18n)

add_executable(tree-view-example
    main.cpp
    res.qrc)

target_link_libraries(tree-view-example
    Qt5::Core
    Qt5::Gui
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    Qt5::Svg
    KF5::I18n
    KF5::ItemModels)

install(TARGETS tree-view-example ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
