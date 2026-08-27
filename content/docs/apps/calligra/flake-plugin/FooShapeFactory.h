#pragma once

#include <KoShapeFactoryBase.h>

class FooShapeFactory : public KoShapeFactoryBase
{
public:
    FooShapeFactory();
    ~FooShapeFactory() override = default;

    KoShape *createDefaultShape(KoDocumentResourceManager *documentResources = nullptr) const override;
    KoShape *createShape(const KoProperties *params, KoDocumentResourceManager *documentResources = nullptr) const override;
    bool supports(const KoXmlElement &element, KoShapeLoadingContext &context) const override;
};
