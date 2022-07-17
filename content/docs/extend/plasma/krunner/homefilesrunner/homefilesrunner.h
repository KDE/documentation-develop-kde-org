#pragma once

#include <KRunner/AbstractRunner>

#include <QHash>
#include <QIcon>

class HomeFilesRunner : public Plasma::AbstractRunner
{
    Q_OBJECT

public:
    HomeFilesRunner(QObject *parent, const KPluginMetaData &data, const QVariantList &args);

    void match(Plasma::RunnerContext &context);
    void run(const Plasma::RunnerContext &context, const Plasma::QueryMatch &match);
    void reloadConfiguration();

protected Q_SLOTS:
    void init();
    void prepareForMatchSession();
    void matchSessionFinished();

private:
    QHash<QString, QIcon> m_iconCache;
    QString m_path;
    QString m_triggerWord;
};
