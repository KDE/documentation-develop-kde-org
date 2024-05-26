#include <KTextEdit>
#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : KXmlGuiWindow(parent)
{
    textArea = new KTextEdit();
    setCentralWidget(textArea);
    setupGUI();
}
