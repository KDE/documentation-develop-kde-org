#pragma once

#include <QObject>
#include <KAboutData>

class AboutType : public QObject
{
    Q_OBJECT
    Q_PROPERTY(KAboutData aboutData READ aboutData CONSTANT)

public:
    // [[nodiscard]]: Compiler-Warnung, wenn Funktion von einer "discard-value-expression" aufgerufen wird
    // https://en.cppreference.com/w/cpp/language/expressions#Discarded-value_expressions
    [[nodiscard]] KAboutData aboutData() const
    {
        return KAboutData::applicationData();
    }
};
