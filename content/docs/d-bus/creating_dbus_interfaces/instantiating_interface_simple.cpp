#include <QDBusConnection>
Background::Background(QObject* parent)
    : QObject(parent)
{
    // register DBus object at org.kde.myapp/foobar
    QDBusConnection::sessionBus().registerService("org.kde.myapp");
    QDBusConnection::sessionBus().registerObject("/foobar", this, QDBusConnection::ExportScriptableContents);

    ... // the rest of constructor
} 
