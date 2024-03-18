cmake_minimum_required(VERSION 3.20)

project(mainwindow)

set(QT_MIN_VERSION "6.6.0")
set(KF_MIN_VERSION "6.0.0")

find_package(ECM ${KF_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(FeatureSummary)

find_package(Qt6 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Core    # QCommandLineParser, QStringLiteral
    Widgets # QApplication 
)

find_package(KF6 ${KF_MIN_VERSION} REQUIRED COMPONENTS
    CoreAddons      # KAboutData
    I18n            # KLocalizedString
    XmlGui          # KXmlGuiWindow
    TextWidgets     # KTextEdit
)
    
add_executable(mainwindow)

target_sources(mainwindow
    PRIVATE
    main.cpp
    mainwindow.cpp)

target_link_libraries(mainwindow
    Qt6::Widgets
    KF6::CoreAddons
    KF6::I18n
    KF6::XmlGui
    KF6::TextWidgets
)

install(TARGETS mainwindow ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
