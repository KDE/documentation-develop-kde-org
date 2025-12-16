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
