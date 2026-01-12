#pragma once

#include <QAbstractListModel>
#include <qqmlintegration.h>

class Model : public QAbstractListModel {
    Q_OBJECT
    QML_ELEMENT
public:

private:
    QMap<QString, QStringList> m_list = {
            {"Feline", {"Tigress",   "Waai Fuu"}},
            {"Fox",    {"Carmelita", "Diane", "Krystal"}},
            {"Goat",   {"Sybil",     "Toriel"}}
    };
};
