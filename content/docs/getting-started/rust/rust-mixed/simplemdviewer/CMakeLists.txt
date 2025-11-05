cmake_minimum_required(VERSION 3.28)

project(simplemdviewer)

find_package(ECM 6.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(ECMUninstallTarget)

include(ECMFindQmlModule)
ecm_find_qmlmodule(org.kde.kirigami REQUIRED)
find_package(KF6 REQUIRED COMPONENTS QQC2DesktopStyle)
find_package(Qt6 REQUIRED
    COMPONENTS
    Core
    Gui
    Qml
    Widgets
    Quick
    QuickControls2
)

find_package(CxxQt QUIET)
if(NOT CxxQt_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        CxxQt
        GIT_REPOSITORY https://github.com/kdab/cxx-qt-cmake.git
        GIT_TAG 0.7
    )

    FetchContent_MakeAvailable(CxxQt)
endif()

cxx_qt_import_crate(
    MANIFEST_PATH Cargo.toml
    CRATES simplemdviewer_rs
    QT_MODULES
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Widgets
    Qt6::Quick
    Qt6::QuickControls2
)

cxx_qt_import_qml_module(simplemdviewer_rs_qml_module
    URI "org.kde.simplemdviewer"
    SOURCE_CRATE simplemdviewer_rs
)

# set(CARGO_INNER_TARGET_DIR debug)
# if(CMAKE_BUILD_TYPE STREQUAL "Release" OR CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
#     set(CARGO_OPTIONS --release)
#     set(CARGO_INNER_TARGET_DIR release)
# endif()
#
# add_custom_target(simplemdviewer
#     ALL
#     COMMAND cargo build --target-dir ${CMAKE_CURRENT_BINARY_DIR} ${CARGO_OPTIONS}
#     BYPRODUCTS ${CMAKE_BINARY_DIR}/${CARGO_INNER_TARGET_DIR}
# )

add_executable(simplemdviewer src/main.cpp)

target_link_libraries(simplemdviewer
    PRIVATE
    simplemdviewer_rs_qml_module
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Widgets
    Qt6::Quick
    Qt6::QuickControls2
)

install(
    TARGETS simplemdviewer
    DESTINATION ${KDE_INSTALL_BINDIR}
)

install(FILES org.kde.simplemdviewer.desktop DESTINATION ${KDE_INSTALL_APPDIR})
install(FILES org.kde.simplemdviewer.metainfo.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
install(FILES org.kde.simplemdviewer.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
