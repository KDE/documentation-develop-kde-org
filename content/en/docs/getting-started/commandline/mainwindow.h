#ifndef MAINWINDOW_H
#define MAINWINDOW_H
 
#include <KXmlGuiWindow>

class KTextEdit;
class KJob;
 
class MainWindow : public KXmlGuiWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = nullptr);
    void openFileFromUrl(const QUrl &inputFileName);

private:
    void setupActions();
    void saveFileToDisk(const QString &outputFileName);

private Q_SLOTS:
    void newFile();
    void openFile();
    void saveFile();
    void saveFileAs();
    
    void downloadFinished(KJob *job);

private:
    KTextEdit *textArea;
    QString fileName;
};

#endif // MAINWINDOW_H
