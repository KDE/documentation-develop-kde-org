#pragma once

#include <KTextEditor/Document>
#include <KTextEditor/MainWindow>
#include <KTextEditor/Plugin>
#include <KTextEditor/View>
#include <KXMLGUIClient>

#include <QTextBrowser>

// Forward declare
class MarkdownPreviewPluginView;

class MarkdownPreviewPlugin : public KTextEditor::Plugin
{
    Q_OBJECT
public:
    explicit MarkdownPreviewPlugin(QObject *parent, const QList<QVariant> & = QList<QVariant>())
        : KTextEditor::Plugin(parent)
    {
    }

    QObject *createView(KTextEditor::MainWindow *mainWindow) override;
};

class MarkdownPreviewPluginView : public QObject, public KXMLGUIClient
{
    Q_OBJECT
public:
    explicit MarkdownPreviewPluginView(MarkdownPreviewPlugin *plugin, KTextEditor::MainWindow *mainwindow);

    void onViewChanged(KTextEditor::View *v);

private:
    KTextEditor::MainWindow *m_mainWindow = nullptr;
    std::unique_ptr<QWidget> m_toolview;
    QTextBrowser *m_previewer = nullptr;
};
