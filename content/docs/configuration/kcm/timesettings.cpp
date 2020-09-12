/**
 * SPDX-FileCopyrightText: Year Author <author@domain.com>
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#include "timesettings.h"

#include <KPluginFactory>
#include <KLocalizedString>
#include <KAboutData>

K_PLUGIN_CLASS_WITH_JSON(TimeSettings, "metadata.json")

TimeSettings::TimeSettings(QObject *parent, const QVariantList &args)
    : KQuickAddons::ManagedConfigModule(parent, args)
{
    KAboutData *aboutData = new KAboutData(QStringLiteral("kcm_time"),
        i18nc("@title", "Time"),
        QStringLiteral("0.1"),
        QStringLiteral(""),
        KAboutLicense::LicenseKey::GPL_V2,
        i18nc("@info:credit", "Copyright Year Author"));

    aboutData->addAuthor(i18nc("@info:credit", "Author"),
                        i18nc("@info:credit", "Author"),
                        QStringLiteral("author@domain.com"));

    setAboutData(aboutData);
    setButtons(Help | Apply | Default);
}

#include "timesettings.moc"
