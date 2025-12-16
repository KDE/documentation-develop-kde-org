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
    int rowCount(const QModelIndex &) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
private:
    QMap<QString, QStringList> m_list = {
        {"Feline", {"Tigress",   "Waai Fuu"}},
        {"Fox",    {"Carmelita", "Diane", "Krystal"}},
        {"Goat",   {"Sybil",     "Toriel"}}
    };
    static QString formatList(const QStringList& list);
};
