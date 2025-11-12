// SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>
// SPDX-License-Identifier: LGPL-3.0-or-later
#pragma once

#include <KMime/Message>
#include <Item>

namespace Akonadi {
    class ItemFetchJob;
}

/// Simple wrapper around a KMime::Message for QML consumption.
//@@snippet_begin(wrapper)
class MessageWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString from READ from NOTIFY loaded);
    Q_PROPERTY(QStringList to READ to NOTIFY loaded);
    Q_PROPERTY(QStringList cc READ cc NOTIFY loaded);
    Q_PROPERTY(QString sender READ sender NOTIFY loaded);
    Q_PROPERTY(QString subject READ subject NOTIFY loaded);
    Q_PROPERTY(QDateTime date READ date NOTIFY loaded);
    Q_PROPERTY(QString content READ content NOTIFY loaded);
public:
    explicit MessageWrapper(const Akonadi::Item &item, QObject *parent = nullptr);

    QString from() const;
    QStringList to() const;
    QStringList cc() const;
    QString sender() const;
    QString subject() const;
    QDateTime date() const;
    QString content() const;

Q_SIGNALS:
    void loaded();

private:
    Akonadi::ItemFetchJob *createFetchJob(const Akonadi::Item &item);
    Akonadi::Item m_item;
    KMime::Message::Ptr m_mail;
};
//@@snippet_end
