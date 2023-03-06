#ifndef MESSAGE_HPP
#define MESSAGE_HPP

#include <QtDBus>

class Message
{
public:
    Message();
    Message(const QString& user, const QString &message);
    Message(const Message &other);
    Message& operator=(const Message &other);
    ~Message();

    friend QDBusArgument &operator<<(QDBusArgument &argument, const Message &message);
    friend const QDBusArgument &operator>>(const QDBusArgument &argument, Message &message);

    QString getUser() const;
    QString getText() const;

    //register Message with the Qt type system
    static void registerMetaType();

private:
    QString m_user;
    QString m_text;
};

Q_DECLARE_METATYPE(Message)

#endif // MESSAGE_HPP
