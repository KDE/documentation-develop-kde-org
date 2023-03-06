project(dbuschat)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
cmake_minimum_required(VERSION 3.0)
set(QT_MIN_VERSION "5.6.0")

################# Disallow in-source build #################

if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
   message(FATAL_ERROR "This application requires an out of source build. Please create a separate build directory.")
endif()

include(FeatureSummary)

################# Find dependencies #################

find_package(Qt5 COMPONENTS Widgets DBus REQUIRED)

################# build and install #################
set(dbuschat_SRCS
    ChatWindow.ui
    ChatWindow.cpp
    Chat.cpp
    Message.cpp
    Message.hpp
    ChatAdaptor.cpp
    ChatInterface.cpp
    )
add_executable(dbuschat main.cpp ${dbuschat_SRCS})
target_link_libraries(dbuschat
    Qt5::Widgets
    Qt5::DBus
    )

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
 
