#include "model.h"

int Model::rowCount(const QModelIndex &) const {
    return m_list.count();
}