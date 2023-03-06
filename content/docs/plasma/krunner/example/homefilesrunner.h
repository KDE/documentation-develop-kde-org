#pragma once

#include <KRunner/AbstractRunner>

#include <QHash>

#include <KIcon>

class HomeFilesRunner : public KRunner::AbstractRunner
{
    Q_OBJECT

public:
    HomeFilesRunner(QObject *parent, const QVariantList &args);

    void match(KRunner::RunnerContext &context);
    void run(const KRunner::RunnerContext &context, const KRunner::QueryMatch &match);
    void reloadConfiguration();

protected Q_SLOTS:
    void init();
    void prepareForMatchSession();
    void matchSessionFinished();

private:
    QHash<QString, KIcon> m_iconCache;
    QString m_path;
    QString m_triggerWord;
};
