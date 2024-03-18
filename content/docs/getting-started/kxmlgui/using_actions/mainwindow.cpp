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
    using namespace Qt::Literals::StringLiterals;

    QAction *clearAction = new QAction(this);
    clearAction->setText(i18n("&Clear"));
    clearAction->setIcon(QIcon::fromTheme(u"document-new-symbolic"_s));
    actionCollection()->addAction(u"clear"_s, clearAction);
    actionCollection()->setDefaultShortcut(clearAction, Qt::CTRL | Qt::Key_L);
    connect(clearAction, &QAction::triggered, textArea, &KTextEdit::clear);
    
    KStandardAction::quit(qApp, &QCoreApplication::quit, actionCollection());
    
    setupGUI(Default, u"texteditorui.rc"_s);
}
