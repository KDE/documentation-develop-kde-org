#include "homefilesrunner.h"

#include <KConfigGroup>
#include <KIO/OpenUrlJob>
#include <KLocalizedString>
#include <KNotificationJobUiDelegate>
#include <QDir>
#include <QIcon>
#include <QMimeDatabase>

HomeFilesRunner::HomeFilesRunner(QObject *parent, const KPluginMetaData &data, const QVariantList &args)
    : AbstractRunner(parent, data, args)
{
    setPriority(LowPriority);
}

void HomeFilesRunner::init()
{
    reloadConfiguration();
    connect(this, &Plasma::AbstractRunner::prepare, this, []() {
        // Initialize data for the match session. This gets called from the main thread
    });
    connect(this, &Plasma::AbstractRunner::teardown, this, [this]() {
        // Cleanup data from the match session. This gets called from the main thread
        m_iconCache.clear();
    });
}

void HomeFilesRunner::reloadConfiguration()
{
    KConfigGroup c = config();
    m_triggerWord = c.readEntry("trigger", QString());
    if (!m_triggerWord.isEmpty()) {
        m_triggerWord.append(QLatin1Char(' '));
    }

    m_path = c.readPathEntry("path", QDir::homePath());
    QFileInfo pathInfo(m_path);
    if (!pathInfo.isDir()) {
        m_path = QDir::homePath();
    }

    QList<Plasma::RunnerSyntax> syntaxes;
    Plasma::RunnerSyntax syntax(QStringLiteral("%1:q:").arg(m_triggerWord), i18n("Finds files matching :q: in the %1 folder", m_path));
    syntaxes.append(syntax);
    setSyntaxes(syntaxes);
}

void HomeFilesRunner::match(Plasma::RunnerContext &context)
{
    QString query = context.query();
    if (query == QLatin1Char('.') || query == QLatin1String("..")) {
        return;
    }

    if (!m_triggerWord.isEmpty()) {
        if (!query.startsWith(m_triggerWord)) {
            return;
        }

        query.remove(0, m_triggerWord.length());
    }

    if (query.length() > 2) {
        query.prepend(QLatin1Char('*')).append(QLatin1Char('*'));
    }

    QMimeDatabase mimeDb;
    QDir dir(m_path);
    QList<Plasma::QueryMatch> matches;
    qWarning() << query << m_path;
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
        Plasma::QueryMatch match(this);
        match.setText(i18n("Open %1", path));
        match.setData(path);
        match.setId(path);
        if (m_iconCache.contains(path)) {
            match.setIcon(m_iconCache.value(path));
        } else {
            QIcon icon = QIcon::fromTheme(mimeDb.mimeTypeForFile(path).iconName());
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
    context.addMatches(matches);
}

void HomeFilesRunner::run(const Plasma::RunnerContext & /*context*/, const Plasma::QueryMatch &match)
{
    // KIO::OpenUrlJob autodeletes itself, so we can just create it and forget it!
    auto *job = new KIO::OpenUrlJob(QUrl::fromLocalFile(match.data().toString()));
    job->setUiDelegate(new KNotificationJobUiDelegate(KJobUiDelegate::AutoErrorHandlingEnabled));
    job->setRunExecutables(false);
    job->start();
}

K_PLUGIN_CLASS_WITH_JSON(HomeFilesRunner, "homefilesrunner.json")

#include "homefilesrunner.moc"
