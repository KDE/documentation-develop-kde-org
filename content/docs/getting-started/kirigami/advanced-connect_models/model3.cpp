#include "model.h"

int Model::rowCount(const QModelIndex &) const {
    return m_list.count();
}

QHash<int, QByteArray> Model::roleNames() const {
    return {
        {SpeciesRole,   "species"},
        {CharactersRole, "characters"}
    };
}

QVariant Model::data(const QModelIndex &index, int role) const {
    const auto it = std::next(m_list.begin(), index.row());
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
