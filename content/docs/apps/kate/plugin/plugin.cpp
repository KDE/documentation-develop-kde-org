#include "plugin.h"

#include <KLocalizedString>
#include <KPluginFactory>
#include <QHBoxLayout>
#include <QIcon>

K_PLUGIN_FACTORY_WITH_JSON(MarkdownPreviewPluginFactory, "plugin.json", registerPlugin<MarkdownPreviewPlugin>();)

QObject *MarkdownPreviewPlugin::createView(KTextEditor::MainWindow *mainWindow)
{
    return new MarkdownPreviewPluginView(this, mainWindow);
}

MarkdownPreviewPluginView::MarkdownPreviewPluginView(MarkdownPreviewPlugin *plugin, KTextEditor::MainWindow *mainwindow)
    : m_mainWindow(mainwindow)
{
    m_toolview.reset(m_mainWindow->createToolView(plugin, // pointer to plugin
                                                  "markdownpreview", // just an identifier
                                                  KTextEditor::MainWindow::Right, // we want to create a toolview on the right side
                                                  QIcon::fromTheme("preview"),
                                                  i18n("Markdown Preview"))); // Name of the toolview

    m_previewer = new QTextBrowser(m_toolview.get());
    m_toolview->layout()->addWidget(m_previewer);

    // Connect the view changed signal to our slot
    connect(m_mainWindow, &KTextEditor::MainWindow::viewChanged, this, &MarkdownPreviewPluginView::onViewChanged);
}

void MarkdownPreviewPluginView::onViewChanged(KTextEditor::View *v)
{
    if (!v || !v->document()) {
        return;
    }

    if (v->document()->highlightingMode().toLower() == "markdown") {
        m_previewer->setMarkdown(v->document()->text());
    }
}

#include "plugin.moc"
