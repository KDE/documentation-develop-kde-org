#include "FooShapeFactory.h"
#include "KoFooShape.h"

#include <KLocalizedString>
#include <KoXmlNS.h>
#include <KoXmlReader.h>

FooShapeFactory::FooShapeFactory()
    : KoShapeFactoryBase("FooShape", i18n("Foo Shape"))
{
    setToolTip(i18n("A foo shape"));
}

KoShape *FooShapeFactory::createDefaultShape(KoDocumentResourceManager *documentResources) const
{
    KoFooShape *fooShape = new KoFooShape();
    // set defaults
    return fooShape;
}

KoShape *FooShapeFactory::createShape(const KoProperties *params, KoDocumentResourceManager *documentResources) const
{
    KoFooShape *fooShape = new KoFooShape();
    // use the params
    return fooShape;
}

bool FooShapeFactory::supports(const KoXmlElement &element, KoShapeLoadingContext &context) const
{
    Q_UNUSED(context);
    // return true for whichever ODF element(s) this shape knows how to load,
    // e.g. a custom draw:frame with a draw:foo child
    return element.localName() == "foo" && element.namespaceURI() == KoXmlNS::draw;
}
