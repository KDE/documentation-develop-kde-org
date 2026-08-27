#pragma once

#include <KoShape.h>

class SomeDataClass; // whatever data backs your shape

class KoFooShape : public KoShape
{
public:
    KoFooShape();
    ~KoFooShape() override;

    // absolutely necessary:
    void paint(QPainter &painter, const KoViewConverter &converter, KoShapePaintingContext &paintContext) override;
    bool loadOdf(const KoXmlElement &element, KoShapeLoadingContext &context) override;
    void saveOdf(KoShapeSavingContext &context) const override;

private:
    SomeDataClass *m_dataClass;
};
