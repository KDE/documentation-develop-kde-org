#include <QApplication>
#include <QAction>
#include <QSaveFile>
#include <QFileDialog>
#include <QTextStream>
#include <QByteArray>

#include <KTextEdit>
#include <KLocalizedString>
#include <KActionCollection>
#include <KStandardAction>
#include <KMessageBox>
#include <KIO/StoredTransferJob>

#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : KXmlGuiWindow(parent), fileName(QString())
{
  textArea = new KTextEdit();
  setCentralWidget(textArea);
  
  setupActions();
}

void MainWindow::setupActions()
{
    using namespace Qt::Literals::StringLiterals;

    QAction *clearAction = new QAction(this);
    clearAction->setText(i18n("&Clear"));
    clearAction->setIcon(QIcon::fromTheme(u"document-new-symbolic"_s));
    actionCollection()->setDefaultShortcut(clearAction, Qt::CTRL | Qt::Key_L);
    actionCollection()->addAction(u"clear"_s, clearAction);
    connect(clearAction, &QAction::triggered, textArea, &KTextEdit::clear);
    
    KStandardAction::quit(qApp, &QCoreApplication::quit, actionCollection());
    KStandardAction::open(this, &MainWindow::openFile, actionCollection());
    KStandardAction::save(this, &MainWindow::saveFile, actionCollection());
    KStandardAction::saveAs(this, &MainWindow::saveFileAs, actionCollection());
    KStandardAction::openNew(this, &MainWindow::newFile, actionCollection());

    setupGUI(Default, u"texteditorui.rc"_s);
}

void MainWindow::newFile()
{
    fileName.clear();
    textArea->clear();
}

void MainWindow::saveFileToDisk(const QString &outputFileName)
{
    if (!outputFileName.isNull()) {
        QSaveFile file(outputFileName);
        file.open(QIODevice::WriteOnly);
        
        QByteArray outputByteArray;
        outputByteArray.append(textArea->toPlainText().toUtf8());

        file.write(outputByteArray);
        file.commit();

        fileName = outputFileName;
    }
}

void MainWindow::saveFileAs()
{
    saveFileToDisk(QFileDialog::getSaveFileName(this, i18n("Save File As")));
}

void MainWindow::saveFile()
{
    if (!fileName.isEmpty()) {
        saveFileToDisk(fileName);
    } else {
        saveFileAs();
    }
}

void MainWindow::openFile()
{
    const QUrl fileNameFromDialog = QFileDialog::getOpenFileUrl(this, i18n("Open File"));
    
    if (!fileNameFromDialog.isEmpty()) {
        KIO::Job *job = KIO::storedGet(fileNameFromDialog);
        fileName = fileNameFromDialog.toLocalFile();

        connect(job, &KJob::result, this, &MainWindow::downloadFinished);
        
        job->exec();
    }
}

void MainWindow::downloadFinished(KJob *job)
{
    if (job->error()) {
        KMessageBox::error(this, job->errorString());
        fileName.clear();
        return;
    }
    
    const KIO::StoredTransferJob *storedJob = qobject_cast<KIO::StoredTransferJob *>(job);
    
    if (storedJob) {
        textArea->setPlainText(QTextStream(storedJob->data(), QIODevice::ReadOnly).readAll());
    }
}
