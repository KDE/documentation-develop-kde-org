#pragma once

#include <QAbstractListModel>

class Model : public QAbstractListModel {
Q_OBJECT;

private:
    QMap<QString, QStringList> m_list = {
            {"Feline", {"Tigress",   "Waai Fuu"}},
            {"Fox",    {"Carmelita", "Diane", "Krystal"}},
            {"Goat",   {"Sybil",     "Toriel"}}
    };

    static QString formatList(const QStringList &list);

public:
    enum Roles {
        TypeRole = Qt::UserRole,
        WaifusRole
    };

    int rowCount(const QModelIndex &) const override;

    QHash<int, QByteArray> roleNames() const override;

    QVariant data(const QModelIndex &index, int role) const override;

    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    Q_INVOKABLE void addType(const QString &typeName);

    Q_INVOKABLE void deleteType(const QString &typeName, const int &rowIndex);
};