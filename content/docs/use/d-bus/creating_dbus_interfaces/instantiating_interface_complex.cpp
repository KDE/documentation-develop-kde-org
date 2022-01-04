#include "background.h"
#include "backgroundadaptor.h"

Background::Background(QObject* parent)
    : QObject(parent)
{
    new BackgroundAdaptor(this);
    QDBusConnection dbus = QDBusConnection::sessionBus();
    dbus.registerObject("/Background", this);
    dbus.registerService("org.foo.Background");
} 
