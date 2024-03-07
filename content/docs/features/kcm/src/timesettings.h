/**
 * SPDX-FileCopyrightText: Year Author <author@domain.com>
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#pragma once

#include <KQuickConfigModule>

class TimeSettings : public KQuickConfigModule
{
    Q_OBJECT
    public:
        TimeSettings(QObject *parent, const KPluginMetaData &data);
};
