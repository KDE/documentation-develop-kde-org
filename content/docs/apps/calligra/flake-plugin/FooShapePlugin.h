#pragma once

#include <QObject>
#include <QVariantList>

class FooShapePlugin : public QObject
{
    Q_OBJECT
public:
    FooShapePlugin(QObject *parent, const QVariantList &);
};
