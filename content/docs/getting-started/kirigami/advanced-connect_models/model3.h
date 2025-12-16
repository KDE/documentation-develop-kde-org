#pragma once

#include <QAbstractListModel>
#include <qqmlintegration.h>

class Model : public QAbstractListModel {
    Q_OBJECT
    QML_ELEMENT
public:
    enum Roles {
        SpeciesRole = Qt::UserRole,
        CharactersRole
    };

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &) const override;

private:
    QMap<QString, QStringList> m_list = {
            {"Feline", {"Tigress",   "Waai Fuu"}},
            {"Fox",    {"Carmelita", "Diane", "Krystal"}},
            {"Goat",   {"Sybil",     "Toriel"}}
    };
};
