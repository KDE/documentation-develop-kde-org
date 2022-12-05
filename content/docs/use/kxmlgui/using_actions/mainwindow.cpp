#include <QApplication>
#include <QAction>

#include <KTextEdit>
#include <KLocalizedString>
#include <KActionCollection>
#include <KStandardAction>

#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : KXmlGuiWindow(parent)
{
  textArea = new KTextEdit();
  setCentralWidget(textArea);
  
  setupActions();
}

void MainWindow::setupActions()
{
    QAction *clearAction = new QAction(this);
    clearAction->setText(i18n("&Clear"));
    clearAction->setIcon(QIcon::fromTheme("document-new"));
    actionCollection()->addAction("clear", clearAction);
    actionCollection()->setDefaultShortcut(clearAction, Qt::CTRL + Qt::Key_W);
    connect(clearAction, &QAction::triggered, textArea, &KTextEdit::clear);
    
    KStandardAction::quit(qApp, &QCoreApplication::quit, actionCollection());
    
    setupGUI(Default, "texteditorui.rc");
}
