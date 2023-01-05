# SPDX-FileCopyrightText: 2022 Alessio Mattiazzi <alem99393@gmail.com>
# SPDX-LicenseIdentifier: BSD-2-Clause

cmake_minimum_required(VERSION 3.14)

add_test(
  NAME url-checker
  COMMAND ${Python_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/url-checker.py
  WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}"
)

install(
  DIRECTORY data
  DESTINATION "."
)
