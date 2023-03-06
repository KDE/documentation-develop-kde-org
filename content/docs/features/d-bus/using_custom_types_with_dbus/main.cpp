#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusConnectionInterface>
#include <QApplication>

#include "Chat.hpp"
#include "ChatAdaptor.h"
#include "ChatInterface.h"
#include "ChatWindow.hpp"
#include "Message.hpp"

#define CHAT_SERVICE "demo.dbus.chat"
#define CHAT_PATH "/chat"

int main(int argc, char *argv[])
{
    /*
      Register the Message type first thing, so Qt knows how to handle
      it before an Adaptor/Interface is even constructed.

      It should be ok to register it further down, as long as no
      Message marshaling or unmarshaling takes place, but this is
      definitely the safest way of doing things.
    */
    Message::registerMetaType();

    QApplication a(argc, argv);
    Chat* pChat = NULL;
    ChatAdaptor* pChatAdaptor = NULL;

    /*
      Create a Chat instance and register it with the session bus only if
      the service isn't already available.
    */
    QDBusConnection connection = QDBusConnection::sessionBus();
    if (!connection.interface()->isServiceRegistered(CHAT_SERVICE))
    {
        pChat = new Chat(&a);
        pChatAdaptor = new ChatAdaptor(pChat);

        if (!connection.registerService(CHAT_SERVICE))
        {
            qFatal("Could not register service!");
        }

        if (!connection.registerObject(CHAT_PATH, pChat))
        {
            qFatal("Could not register Chat object!");
        }
    }

    demo::Chat chatInterface(CHAT_SERVICE, CHAT_PATH, connection);

    ChatWindow w(chatInterface);
    w.show();

    int ret = a.exec();

    //cleanup
    if (pChat)
    {
        delete pChat;
    }
    if (pChatAdaptor)
    {
        delete pChatAdaptor;
    }

    return ret;
}
