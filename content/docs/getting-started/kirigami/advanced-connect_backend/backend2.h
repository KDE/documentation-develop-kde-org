#pragma once

#include <QObject>
#include <qqmlintegration.h>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QString introductionText READ introductionText WRITE setIntroductionText NOTIFY introductionTextChanged)
public:
    explicit Backend(QObject *parent = nullptr);
    QString introductionText() const;
    void setIntroductionText(const QString &introductionText);
    Q_SIGNAL void introductionTextChanged();
private:
    QString m_introductionText = QStringLiteral("Hello World!");
};
