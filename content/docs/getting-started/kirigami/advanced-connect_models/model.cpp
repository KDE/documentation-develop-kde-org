#include "model.h"

int Model::rowCount(const QModelIndex &) const {
    return m_list.count();
}

QHash<int, QByteArray> Model::roleNames() const {
    QHash<int, QByteArray> map = {
            {TypeRole,   "type"},
            {WaifusRole, "waifus"}
    };
    return map;
}

QVariant Model::data(const QModelIndex &index, int role) const {
    const auto it = m_list.begin() + index.row();
    switch (role) {
        case TypeRole:
            return it.key();
        case WaifusRole:
            return formatList(it.value());
        default:
            return {};
    }
}

QString Model::formatList(const QStringList& list) {
    QString result;
    for (const QString& waifu : list) {
        result += waifu;
        if (list.last() != waifu) {
            result += ", ";
        }
    }
    return result;
}

bool Model::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!value.canConvert<QString>() && role != Qt::EditRole) {
        return false;
    }

    auto it = m_list.begin() + index.row();
    QString waifusUnformatted = value.toString();
    QStringList waifus = waifusUnformatted.split(", ");

    m_list[it.key()] = waifus;
    emit dataChanged(index, index);

    return true;
}

void Model::addType(const QString& typeName) {
    beginInsertRows(QModelIndex(), m_list.size() - 1, m_list.size() - 1);
    m_list.insert(typeName, {});
    endInsertRows();
    emit dataChanged(index(0), index(m_list.size() - 1));
}

void Model::deleteType(const QString &typeName, const int& rowIndex) {
    beginRemoveRows(QModelIndex(), rowIndex, rowIndex);
    m_list.remove(typeName);
    endRemoveRows();
    emit dataChanged(index(0), index(m_list.size() - 1));
}
