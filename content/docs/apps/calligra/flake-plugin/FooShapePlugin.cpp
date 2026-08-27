#include "FooShapePlugin.h"
#include "FooShapeFactory.h"

#include <KPluginFactory>

#include <KoShapeRegistry.h>

K_PLUGIN_FACTORY_WITH_JSON(FooShapePluginFactory, "calligra_shape_foo.json", registerPlugin<FooShapePlugin>();)

FooShapePlugin::FooShapePlugin(QObject *parent, const QVariantList &)
    : QObject(parent)
{
    // register the shape's factory
    KoShapeRegistry::instance()->add(new FooShapeFactory());
    // we could register more things here in this same plugin.
}

#include "FooShapePlugin.moc"
