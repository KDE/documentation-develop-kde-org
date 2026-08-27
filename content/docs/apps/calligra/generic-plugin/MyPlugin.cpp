#include "MyPlugin.h"

#include <KPluginFactory>

#include <KoShapeRegistry.h>
#include <KoToolRegistry.h>

#include "MyShapeFactory.h"
#include "MyToolFactory.h"

K_PLUGIN_FACTORY_WITH_JSON(MyPluginFactory, "myplugin.json", registerPlugin<MyPlugin>();)

MyPlugin::MyPlugin(QObject *parent, const QVariantList &)
    : QObject(parent)
{
    KoShapeRegistry::instance()->add(new MyShapeFactory());
    KoToolRegistry::instance()->add(new MyToolFactory());
}

#include "MyPlugin.moc"
