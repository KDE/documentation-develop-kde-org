#include "KoFooShape.h"

KoFooShape::KoFooShape() = default;
KoFooShape::~KoFooShape() = default;


void KoFooShape::paint(QPainter &painter, const KoViewConverter &converter, KoShapePaintingContext &paintContext) {}
bool KoFooShape::loadOdf(const KoXmlElement &element, KoShapeLoadingContext &context) {}
void KoFooShape::saveOdf(KoShapeSavingContext &context) const {}
