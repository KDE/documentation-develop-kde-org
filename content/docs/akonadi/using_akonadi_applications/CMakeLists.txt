cmake_minimum_required(VERSION 3.8)

project(kmailquick)

set(QT_MIN_VERSION "5.14.0")
set(KF5_MIN_VERSION "5.70.0")
set(LIBKDEPIM_VERSION "5.16.0")



include(FeatureSummary)

################# set KDE specific information #################
find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(ECMPoQmTools)
include(KDEClangFormat)

################# Find dependencies #################
find_package(Qt5 ${QT_MIN_VERSION} REQUIRED COMPONENTS Core Gui Qml QuickControls2 Svg Sql)
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Kirigami2 I18n CoreAddons Declarative ItemModels KIO)

# Find KdepimLibs Package
find_package(KF5Akonadi ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5Libkdepim ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5AkonadiMime ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5Mime ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5MailCommon ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5MailTransport ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5MailTransportAkonadi ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5PimCommon ${LIBKDEPIM_VERSION} CONFIG REQUIRED)
find_package(KF5PimCommonAkonadi ${LIBKDEPIM_VERSION} CONFIG REQUIRED)

set(CMAKE_CXX_STANDARD 17)

################# build and install #################
add_subdirectory(src)

add_definitions(-DQT_NO_CAST_FROM_ASCII -DQT_NO_CAST_TO_ASCII -DQT_NO_URL_CAST_FROM_STRING)
add_definitions(-DQT_USE_QSTRINGBUILDER)
add_definitions(-DQT_NO_NARROWING_CONVERSIONS_IN_CONNECT)
add_definitions(-DQT_DISABLE_DEPRECATED_BEFORE=0x050d00)

#install(PROGRAMS org.kde.kmailquick.desktop DESTINATION ${KDE_INSTALL_APPDIR})
#install(FILES org.kde.kmailquick.appdata.xml DESTINATION ${KDE_INSTALL_METAINFODIR})

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

file(GLOB_RECURSE ALL_CLANG_FORMAT_SOURCE_FILES src/*.cpp src/*.h)
kde_clang_format(${ALL_CLANG_FORMAT_SOURCE_FILES})
        
