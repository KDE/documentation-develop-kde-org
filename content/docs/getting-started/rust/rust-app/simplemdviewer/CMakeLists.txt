cmake_minimum_required(VERSION 3.28)

project(simplemdviewer)

find_package(ECM 6.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(ECMUninstallTarget)

include(ECMFindQmlModule)
ecm_find_qmlmodule(org.kde.kirigami REQUIRED)
find_package(KF6 REQUIRED COMPONENTS QQC2DesktopStyle)

add_custom_target(simplemdviewer
    ALL
    COMMAND cargo build --target-dir ${CMAKE_CURRENT_BINARY_DIR}
)

install(
    PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/debug/simplemdviewer
    DESTINATION ${KDE_INSTALL_BINDIR}
)
