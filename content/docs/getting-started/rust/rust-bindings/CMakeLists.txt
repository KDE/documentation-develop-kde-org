cmake_minimum_required(VERSION 3.28)

project(simplemdviewer)

find_package(ECM 6.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(ECMUninstallTarget)

include(ECMFindQmlModule)
ecm_find_qmlmodule(org.kde.kirigami REQUIRED)
ecm_find_qmlmodule(org.kde.kirigamiaddons.formcard REQUIRED)
find_package(KF6 REQUIRED COMPONENTS QQC2DesktopStyle)

set(CARGO_INNER_TARGET_DIR debug)
if(CMAKE_BUILD_TYPE STREQUAL "Release" OR CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
    set(CARGO_OPTIONS --release)
    set(CARGO_INNER_TARGET_DIR release)
endif()

add_custom_target(simplemdviewer
    ALL
    COMMAND cargo build --target-dir ${CMAKE_CURRENT_BINARY_DIR} ${CARGO_OPTIONS}
    BYPRODUCTS ${CMAKE_BINARY_DIR}/${CARGO_INNER_TARGET_DIR}
)

install(
    PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/${CARGO_INNER_TARGET_DIR}/simplemdviewer
    DESTINATION ${KDE_INSTALL_BINDIR}
)

install(FILES org.kde.simplemdviewer.desktop DESTINATION ${KDE_INSTALL_APPDIR})
install(FILES org.kde.simplemdviewer.metainfo.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
install(FILES org.kde.simplemdviewer.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
