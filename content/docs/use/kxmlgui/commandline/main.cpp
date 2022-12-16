#include <cstdlib>
#include <QApplication>
#include <QCommandLineParser>
#include <QDir>
#include <QUrl>

#include <KAboutData>
#include <KLocalizedString>

#include "mainwindow.h"

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("texteditor");
    KAboutData aboutData(
        QStringLiteral("texteditor"),
        i18n("TextEditor"),
        QStringLiteral("1.0"),
        i18n("A simple text area using QAction etc."),
        KAboutLicense::GPL,
        i18n("(c) 2015"),
        i18n("Some text..."),
        QStringLiteral("https://mytexteditor.kde.org/"),
        QStringLiteral("submit@bugs.kde.org"));

    aboutData.addAuthor(i18n("Name"), i18n("Task"), QStringLiteral("your@email.com"),
                        QStringLiteral("https://your.website.com"),
                        QStringLiteral("OSC Username"));

    KAboutData::setApplicationData(aboutData);
 
    QCommandLineParser parser;
    aboutData.setupCommandLine(&parser);
    parser.addPositionalArgument(QStringLiteral("file"), i18n("Document to open"));

    parser.process(app);
    aboutData.processCommandLine(&parser);
    
    MainWindow *window = new MainWindow();
    window->show();

    if (parser.positionalArguments().count() > 0) {
        window->openFileFromUrl(QUrl::fromUserInput(
            parser.positionalArguments().at(0),
            QDir::currentPath()));
    }
    
    return app.exec();
} 
