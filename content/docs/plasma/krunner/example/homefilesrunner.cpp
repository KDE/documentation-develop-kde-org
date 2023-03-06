#include "homefilesrunner.h"

HomeFilesRunner::HomeFilesRunner(QObject *parent, const QVariantList &args)
    : AbstractRunner(parent, args)
{
    setIgnoredTypes(Plasma::RunnerContext::NetworkLocation |
                    Plasma::RunnerContext::Executable |
                    Plasma::RunnerContext::ShellCommand);
    setSpeed(SlowSpeed);
    setPriority(LowPriority);
    setHasRunOptions(true);
}

void HomeFilesRunner::init()
{
    reloadConfiguration();
    connect(this, SIGNAL(prepare()), this, SLOT(prepareForMatchSession()));
    connect(this, SIGNAL(teardown()), this, SLOT(matchSessionFinished()));
}

void HomeFilesRunner::matchSessionFinished()
{
    m_iconCache.clear();
}

void HomeFilesRunner::match(Plasma::RunnerContext &context)
{
    QString query = context.query();
    if (query == QCharLatin1('.') || query == QStringLiteral("..")) {
        return;
    }

    if (!m_triggerWord.isEmpty()) {
        if (!query.startsWith(m_triggerWord)) {
            return;
        }

        query.remove(0, m_triggerWord.length());
    }

    if (query.length() > 2) {
        query.prepend('*').append('*');
    }

    QDir dir(m_path);
    QList<KRunner::QueryMatch> matches;

    for (const QString &file : dir.entryList(QStringList(query))) {
        const QString path = dir.absoluteFilePath(file);
        if (!path.startsWith(m_path)) {
            // this file isn't in our directory; looks like we got a query with some
            // ..'s in it!
            continue;
        }
        if (!context.isValid()) {
            return;
        }

        KRunner::QueryMatch match(this);
        match.setText(i18n("Open %1", path));
        match.setData(path);
        match.setId(path);
        if (m_iconCache.contains(path)) {
            match.setIcon(m_iconCache.value(path));
        } else {
            KIcon icon(KMimeType::iconNameForUrl(path));
            m_iconCache.insert(path, icon);
            match.setIcon(icon);
        }

        if (file.compare(query, Qt::CaseInsensitive)) {
            match.setRelevance(1.0);
            match.setType(Plasma::QueryMatch::ExactMatch);
        } else {
            match.setRelevance(0.8);
        }

        matches.append(match);
    }

    context.addMatches(context.query(), matches);
}

//snippet_begin(export)
K_EXPORT_PLASMA_RUNNER(example-homefiles, HomeFilesRunner)

#include "homefilesrunner.moc"
//@@snippet_end
