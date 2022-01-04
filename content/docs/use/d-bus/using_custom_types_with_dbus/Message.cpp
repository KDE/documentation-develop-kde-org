#include "Message.hpp"

Message::Message() :
        m_user(),
        m_text()
{
}

Message::Message(const QString &user, const QString &text) :
        m_user(user),
        m_text(text)
{
}

Message::Message(const Message &other) :
        m_user(other.m_user),
        m_text(other.m_text)
{
}

Message& Message::operator=(const Message &other)
{
    m_user = other.m_user;
    m_text = other.m_text;

    return *this;
}

Message::~Message()
{
}

QString Message::getUser() const
{
    return m_user;
}

QString Message::getText() const
{
    return m_text;
}

void Message::registerMetaType()
{
    qRegisterMetaType<Message>("Message");

    qDBusRegisterMetaType<Message>();
}

QDBusArgument &operator<<(QDBusArgument &argument, const Message& message)
{
    argument.beginStructure();
    argument << message.m_user;
    argument << message.m_text;
    argument.endStructure();

    return argument;
}

const QDBusArgument &operator>>(const QDBusArgument &argument, Message &message)
{
    argument.beginStructure();
    argument >> message.m_user;
    argument >> message.m_text;
    argument.endStructure();

    return argument;
}
