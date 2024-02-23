#include "model.h"

int Model::rowCount(const QModelIndex &) const {
    return m_list.count();
}

QHash<int, QByteArray> Model::roleNames() const {
    QHash<int, QByteArray> map = {
            {SpeciesRole,   "species"},
            {CharactersRole, "characters"}
    };
    return map;
}

QVariant Model::data(const QModelIndex &index, int role) const {
    const auto it = m_list.begin() + index.row();
    switch (role) {
        case SpeciesRole:
            return it.key();
        case CharactersRole:
            return formatList(it.value());
        default:
            return {};
    }
}

QString Model::formatList(const QStringList& list) {
    QString result;
    for (const QString& character : list) {
        result += character;
        if (list.last() != character) {
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
    QString charactersUnformatted = value.toString();
    QStringList characters = charactersUnformatted.split(", ");

    m_list[it.key()] = characters;
    emit dataChanged(index, index);

    return true;
}

void Model::addSpecies(const QString& species) {
    beginInsertRows(QModelIndex(), m_list.size() - 1, m_list.size() - 1);
    m_list.insert(species, {});
    endInsertRows();
    emit dataChanged(index(0), index(m_list.size() - 1));
}

void Model::deleteSpecies(const QString &species, const int& rowIndex) {
    beginRemoveRows(QModelIndex(), rowIndex, rowIndex);
    m_list.remove(species);
    endRemoveRows();
    emit dataChanged(index(0), index(m_list.size() - 1));
}
