cmake_minimum_required(VERSION 3.16)
project(runnerexample)

set(KF5_MIN_VERSION "5.90")

# Include the Extra-CMake-Modules project
find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(FeatureSummary)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS I18n Config Runner KIO Notifications)

# This takes care of building and installing the plugin
kcoreaddons_add_plugin(plasma_runner_example_homefiles SOURCES homefilesrunner.cpp INSTALL_NAMESPACE "kf5/krunner")
# We need to link the KRunner and other used libraryies  to it
target_link_libraries(plasma_runner_example_homefiles
    KF5::I18n
    KF5::ConfigCore
    KF5::Runner
    KF5::KIOWidgets
    KF5::Notifications
)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS ConfigWidgets)
kcoreaddons_add_plugin(kcm_homefilesrunner SOURCES kcm_homefilesrunner.cpp INSTALL_NAMESPACE kf5/krunner/kcms)
target_link_libraries(kcm_homefilesrunner KF5::ConfigCore KF5::ConfigWidgets)
