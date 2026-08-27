#pragma once

#include <QObject>
#include <QVariantList>

class MyPlugin : public QObject
{
    Q_OBJECT
public:
    MyPlugin(QObject *parent, const QVariantList &);
};
