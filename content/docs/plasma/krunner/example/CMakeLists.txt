# Project Needs a name, of course
project(runnerexample)

set(KF5_MIN_VERSION "5.90")
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED)

add_definitions(${QT_DEFINITIONS})
include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})

# We add our source code here
set(example_SRCS homefilesrunner.cpp)

# Now make sure all files get to the right place
plasma_add_plugin(plasma_runner_example_homefiles ${example_SRCS})
target_link_libraries(plasma_runner_example_homefiles ${KDE4_PLASMA_LIBS}  ${KDE4_KIO_LIBS})

# Install the library and .desktop file
install(TARGETS plasma_runner_example_homefiles DESTINATION ${PLUGIN_INSTALL_DIR})
install(FILES plasma-runner-example-homefiles.desktop DESTINATION ${SERVICES_INSTALL_DIR})
