// SPDX-FileCopyrightText: 2020 Carl Schwan <carlschwan@kde.org>
// SPDX-License-Identifier: GPL-3.0-or-later

#pragma once

#include <QObject>

namespace Akonadi {
    class CollectionFilterProxyModel;
    class EntityMimeTypeFilterModel;
    class Session;
}

class KDescendantsProxyModel;
class QItemSelectionModel;

class MailModel;

/**
 * Main class of the project and used as Singleton to communicate with
 * QML.
 */
class QuickMail : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
    Q_PROPERTY(KDescendantsProxyModel *descendantsProxyModel READ descendantsProxyModel CONSTANT)
    Q_PROPERTY(MailModel *folderModel READ folderModel NOTIFY folderModelChanged)

public:
    QuickMail(QObject *parent = nullptr);
    ~QuickMail() override = default;

    bool loading() const;
    KDescendantsProxyModel *descendantsProxyModel() const;
    MailModel *folderModel() const;
    Akonadi::Session *session() const;

    Q_INVOKABLE void loadMailCollection(const int &index);

Q_SIGNALS:
    void loadingChanged();
    void folderModelChanged();

private:
    bool m_loading;
    Akonadi::Session *m_session;
    KDescendantsProxyModel *m_descendantsProxyModel;

    //folders
    QItemSelectionModel *m_collectionSelectionModel;
    MailModel *m_folderModel;
};

Q_GLOBAL_STATIC(QuickMail, quickMail)
