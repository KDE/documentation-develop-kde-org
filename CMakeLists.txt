# SPDX-FileCopyrightText: 2022 Alessio Mattiazzi <alem99393@gmail.com>
# SPDX-LicenseIdentifier: BSD-2-Clause

cmake_minimum_required(VERSION 3.14)

project(url-checker)

enable_testing()

find_package(Python REQUIRED)

add_subdirectory(tests)

install(
    DIRECTORY "content"
    DESTINATION "."
)
