cmake_minimum_required(VERSION 3.28)

project(simplemdviewer)

find_package(ECM 6.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(ECMUninstallTarget)

include(ECMFindQmlModule)
ecm_find_qmlmodule(org.kde.kirigami REQUIRED)
find_package(KF6 REQUIRED COMPONENTS QQC2DesktopStyle)
find_package(Corrosion REQUIRED)

corrosion_import_crate(MANIFEST_PATH Cargo.toml)

install(PROGRAMS ${CMAKE_BINARY_DIR}/simplemdviewer DESTINATION ${KDE_INSTALL_BINDIR})
install(FILES org.kde.simplemdviewer.desktop DESTINATION ${KDE_INSTALL_APPDIR})
install(FILES org.kde.simplemdviewer.metainfo.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
install(FILES org.kde.simplemdviewer.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
