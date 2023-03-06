// SPDX-FileCopyrightText: 2021 Simon Schmeisser <s.schmeisser@gmx.net>
// SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "mailmodel.h"

#include "messagewrapper.h"

#include <EntityTreeModel>
#include <KMime/Message>
#include <QQmlEngine>

MailModel::MailModel(QObject *parent)
    : QIdentityProxyModel(parent)
{
}

QHash<int, QByteArray> MailModel::roleNames() const
{
    return {
        {TitleRole, QByteArrayLiteral("title")},
        {SenderRole, QByteArrayLiteral("sender")},
        {MailRole, QByteArrayLiteral("mail")}
    };
}

QVariant MailModel::data(const QModelIndex &index, int role) const
{
    QVariant itemVariant = sourceModel()->data(mapToSource(index), Akonadi::EntityTreeModel::ItemRole);

    Akonadi::Item item = itemVariant.value<Akonadi::Item>();

    if (!item.hasPayload<KMime::Message::Ptr>()) {
         return QVariant();
    }
    const KMime::Message::Ptr mail = item.payload<KMime::Message::Ptr>();

    // NOTE: remember to update AkonadiBrowserSortModel::lessThan if you insert/move columns
    switch (role) {
    case TitleRole:
        if (mail->subject()) {
            return mail->subject()->asUnicodeString();
        } else {
            return QStringLiteral("(No subject)");
        }
    case SenderRole:
        if (mail->from()) {
            return mail->from()->asUnicodeString();
        } else {
            return QString();
        }
    case DateRole:
        if (mail->date()) {
            return mail->date()->asUnicodeString();
        } else {
            return QString();
        }
    case MailRole:
        {
            auto wrapper = new MessageWrapper(item);
            QQmlEngine::setObjectOwnership(wrapper, QQmlEngine::JavaScriptOwnership);
            return QVariant::fromValue(wrapper);
        }
    }

    return QVariant();
}
