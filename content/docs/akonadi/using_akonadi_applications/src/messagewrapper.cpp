// SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>
// SPDX-License-Identifier: LGPL-3.0-or-later

//@@snippet_begin(wrapper)
// src/messagewrapper.cpp
#include "messagewrapper.h"

#include "quickmail.h"

#include <KLocalizedString>
#include <Akonadi/KMime/MessageParts>
#include <Session>
#include <MailTransportAkonadi/ErrorAttribute>
#include <ItemFetchJob>
#include <ItemFetchScope>
#include <algorithm>
#include <QDebug>

MessageWrapper::MessageWrapper(const Akonadi::Item &item, QObject *parent)
    : QObject(parent)
    , m_item(item)
{
    if (!item.isValid() || item.loadedPayloadParts().contains(Akonadi::MessagePart::Body)) {
        m_mail = item.payload<KMime::Message::Ptr>();
        Q_EMIT loaded();
    } else {
        m_mail = QSharedPointer<KMime::Message>::create();
        Akonadi::ItemFetchJob *job = createFetchJob(item);
        connect(job, &Akonadi::ItemFetchJob::result, [this](KJob *job) {
            if (job->error()) {
                // TODO
            } else {
                auto fetch = qobject_cast<Akonadi::ItemFetchJob *>(job);
                Q_ASSERT(fetch);
                if (fetch->items().isEmpty()) {
                    // TODO display mssage not found error
                } else {
                    m_mail = fetch->items().constFirst().payload<KMime::Message::Ptr>();
                    Q_EMIT loaded();
                }
            }
        });
    }
}
//@@snippet_end

QString MessageWrapper::from() const
{
    return m_mail->from()->asUnicodeString();
}

QStringList MessageWrapper::to() const
{
    const auto addresses = m_mail->to()->addresses();
    QList<QString> ret;
    std::transform(addresses.cbegin(), addresses.cend(),
                   std::back_inserter(ret), [](const QByteArray &addresss) {
                       return QString::fromUtf8(addresss);
                   });
    return ret;
}

QStringList MessageWrapper::cc() const
{
    const auto addresses = m_mail->cc()->addresses();
    QList<QString> ret;
    std::transform(addresses.cbegin(), addresses.cend(),
                   std::back_inserter(ret), [](const QByteArray &addresss) {
                       return QString::fromUtf8(addresss);
                   });
    return ret;
}

QString MessageWrapper::sender() const
{
    return m_mail->sender()->asUnicodeString();
}

QString MessageWrapper::subject() const
{
    if (m_mail->subject()) {
        return m_mail->subject()->asUnicodeString();
    } else {
        return i18n("(No subject)");
    }
}

QDateTime MessageWrapper::date() const
{
    if (m_mail->date()) {
        return m_mail->date()->dateTime();
    } else {
        return QDateTime();
    }
}

//@@snippet_begin(content)
QString MessageWrapper::content() const
{
    const auto plain = m_mail->mainBodyPart("text/plain");
    if (plain) {
        return plain->decodedText();
    }
    return m_mail->textContent()->decodedText();
}
//@@snippet_end

//@@snippet_begin(createFetchJob)
Akonadi::ItemFetchJob *MessageWrapper::createFetchJob(const Akonadi::Item &item)
{
    auto job = new Akonadi::ItemFetchJob(item, quickMail);
    job->fetchScope().fetchAllAttributes();
    job->fetchScope().setAncestorRetrieval(Akonadi::ItemFetchScope::Parent);
    job->fetchScope().fetchFullPayload(true);
    job->fetchScope().setFetchRelations(true); // needed to know if we have notes or not
    job->fetchScope().fetchAttribute<MailTransport::ErrorAttribute>();
    return job;
}
//@@snippet_end
