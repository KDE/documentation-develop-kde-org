#ifndef CHATWINDOW_HPP
#define CHATWINDOW_HPP

#include <QMainWindow>
#include <QStringListModel>

#include "ChatInterface.h"

namespace Ui
{
    class ChatWindow;
}

class QCloseEvent;

class ChatWindow : public QMainWindow
{
    Q_OBJECT

public:
    ChatWindow(demo::Chat& chatInterface, QWidget *parent = nullptr);
    virtual ~ChatWindow();

protected:
    virtual void closeEvent(QCloseEvent *event);

private:
    ChatWindow(const ChatWindow &other);
    ChatWindow& operator=(const ChatWindow &other);

    Ui::ChatWindow *ui;

    QString m_userName;

    QStringListModel m_users;

    demo::Chat &m_chatInterface;

private slots:
    void sendMessage();

    void chat_userAdded(const QString &user);
    void chat_userRemoved(const QString &user);
    void chat_messageSent(const Message &message);
};

#endif // CHATWINDOW_HPP
