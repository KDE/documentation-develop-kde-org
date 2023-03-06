#ifndef CHAT_HPP
#define CHAT_HPP

#include <QObject>
#include <QStringList>

class Message;

class Chat : public QObject
{
    Q_OBJECT

    Q_CLASSINFO("D-Bus Interface", "demo.Chat")
    Q_PROPERTY( QStringList users READ users)

signals:
    void userAdded(const QString& user);
    void userRemoved(const QString& user);

    void messageSent(const Message &message);

public slots:
    void addUser(const QString &user);
    void removeUser(const QString &user);

    void sendMessage(const Message &message);

public:
    Chat(QObject* parent = nullptr);
    virtual ~Chat();

    QStringList users() const;

private:
    QStringList m_users;
};
#endif // CHAT_HPP
