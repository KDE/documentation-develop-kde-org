// SPDX-FileCopyrightText: 2021 Simon Schmeisser <s.schmeisser@gmx.net>
// SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>
// SPDX-License-Identifier: GPL-3.0-or-later

#pragma once

#include <QObject>
#include <QIdentityProxyModel>
#include <QItemSelectionModel>

class MailModel : public QIdentityProxyModel
{
    Q_OBJECT
public:
    enum AnimalRoles {
        TitleRole = Qt::UserRole + 1,
        SenderRole,
        DateRole,
        MailRole,
    };

    explicit MailModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
};
