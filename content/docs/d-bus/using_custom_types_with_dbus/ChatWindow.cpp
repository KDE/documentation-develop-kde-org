#include "ChatWindow.hpp"
#include "ui_ChatWindow.h"

#include <QtGui/QCloseEvent>
#include <QInputDialog>
#include <QMessageBox>

#include "Message.hpp"

ChatWindow::ChatWindow(demo::Chat& chatInterface, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ChatWindow),
    m_userName(),
    m_users(),
    m_chatInterface(chatInterface)
{
    ui->setupUi(this);

    QStringList userList = chatInterface.users();
    m_users.setStringList(userList);
    m_users.sort(0);

    connect(&m_chatInterface, SIGNAL(userAdded(QString)), SLOT(chat_userAdded(QString)));
    connect(&m_chatInterface, SIGNAL(userRemoved(QString)), SLOT(chat_userRemoved(QString)));
    connect(&m_chatInterface, SIGNAL(messageSent(Message)), SLOT(chat_messageSent(Message)));

    connect(ui->lneMessage, SIGNAL(returnPressed()), SLOT(sendMessage()));
    connect(ui->btnSend, SIGNAL(released()), SLOT(sendMessage()));

    bool ok;
    m_userName = QInputDialog::getText(this, "Username?", "User name:", QLineEdit::Normal, QDir::home().dirName(), &ok, Qt::Dialog);

    if (!ok)
    {
        QApplication::exit();
        qFatal("Cancelled");
    }

    if (userList.contains(m_userName))
    {
        QMessageBox::critical(this, "Invalid Username", "Username " + m_userName + " is already taken");
        QApplication::exit();
        qFatal("Duplicate username");
    }

    m_chatInterface.addUser(m_userName);

    setWindowTitle("Chat -- " + m_userName);

    ui->lstUsers->setModel(&m_users);
}

ChatWindow::~ChatWindow()
{
    delete ui;
}

void ChatWindow::closeEvent(QCloseEvent *event)
{
    QMainWindow::closeEvent(event);

    if (event->isAccepted())
    {
        m_chatInterface.removeUser(m_userName);
    }
}

void ChatWindow::sendMessage()
{
    Message message(m_userName, ui->lneMessage->text());
    m_chatInterface.sendMessage(message);

    ui->lneMessage->clear();
}

void ChatWindow::chat_userAdded(const QString &user)
{
    QStringList users = m_users.stringList();
    users.append(user);
    users.sort();
    m_users.setStringList(users);
}

void ChatWindow::chat_userRemoved(const QString &user)
{
    QStringList users = m_users.stringList();
    users.removeOne(user);
    m_users.setStringList(users);
}

void ChatWindow::chat_messageSent(const Message &message)
{
    ui->txtChat->appendPlainText(message.getUser() + " : " + message.getText());
}
