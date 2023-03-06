#include <QApplication>
#include <QCommandLineParser>
#include <KAboutData>
#include <KLocalizedString>
#include "mainwindow.h"
 
int main (int argc, char *argv[])
{
    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("mainwindow");
    
    KAboutData aboutData(
        QStringLiteral("mainwindow"),
        i18n("Main Window"),
        QStringLiteral("1.0"),
        i18n("A simple text area"),
        KAboutLicense::GPL,
        i18n("(c) 2015"),
        i18n("Some text..."),
        QStringLiteral("https://example.kde.org/"),
        QStringLiteral("submit@bugs.kde.org"));

    aboutData.addAuthor(i18n("Name"), i18n("Task"),
        QStringLiteral("your@email.com"),
        QStringLiteral("https://your.website.com"),
        QStringLiteral("OSC Username"));

    KAboutData::setApplicationData(aboutData);
 
    QCommandLineParser parser;
    aboutData.setupCommandLine(&parser);
    parser.process(app);
    aboutData.processCommandLine(&parser);
    
    MainWindow *window = new MainWindow();
    window->show();
    
    return app.exec();
}
