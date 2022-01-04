#include "Chat.hpp"

Chat::Chat(QObject* parent) :
        QObject(parent)
{
}

Chat::~Chat()
{
}

void Chat::addUser(const QString &user)
{
    if (!m_users.contains(user))
    {
        m_users.append(user);

        emit userAdded(user);
    }
}

void Chat::removeUser(const QString &user)
{
    if (m_users.contains(user))
    {
        m_users.removeOne(user);

        emit userRemoved(user);
    }
}

void Chat::sendMessage(const Message &message)
{
    Q_EMIT messageSent(message);
}

QStringList Chat::users() const
{
    return m_users;
}
