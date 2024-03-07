# SPDX-FileCopyrightText: Year Author <email@company.com>
#
# SPDX-License-Identifier: BSD-2-Clause

kcmutils_add_qml_kcm(kcm_time)
target_sources(kcm_time PRIVATE
   timesettings.cpp
   timesettings.h
)
target_link_libraries(kcm_time PRIVATE
    Qt::Quick
    KF6::CoreAddons
    KF6::KCMUtils
    KF6::I18n
)
