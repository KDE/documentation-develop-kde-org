#include "mainwindow.h"

#include <KTextEdit>

MainWindow::MainWindow(QWidget *parent) : KXmlGuiWindow(parent)
{
    textArea = new KTextEdit();
    setCentralWidget(textArea);
    setupGUI();
}
