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
                         // The program name used internally. (componentName)
                         QStringLiteral("texteditor"),
                         // A displayable program name string. (displayName)
                         i18n("TextEditor"),
                         // The program version string. (version)
                         QStringLiteral("1.0"),
                         // Short description of what the app does. (shortDescription)
                         i18n("A simple text area using QAction etc."),
                         // The license this code is released under
                         KAboutLicense::GPL,
                         // Copyright Statement (copyrightStatement = QString())
                         i18n("(c) 2015"),
                         // Optional text shown in the About box.
                         // Can contain any information desired. (otherText)
                         i18n("Some text..."),
                         // The program homepage string. (homePageAddress = QString())
                         QStringLiteral("https://mytexteditor.kde.org/"),
                         // The bug report email address
                         // (bugsEmailAddress = QLatin1String("submit@bugs.kde.org")
                         QStringLiteral("submit@bugs.kde.org"));
    aboutData.addAuthor(i18n("Name"), i18n("Task"), QStringLiteral("your@email.com"),
                        QStringLiteral("https://your.website.com"), QStringLiteral("OSC Username"));
    KAboutData::setApplicationData(aboutData);
 
    QCommandLineParser parser;
    aboutData.setupCommandLine(&parser);
    parser.addPositionalArgument(QStringLiteral("file"), i18n("Document to open"));

    parser.process(app);
    aboutData.processCommandLine(&parser);
    
    MainWindow *window = new MainWindow();
    window->show();

    if (parser.positionalArguments().count() > 0) {
        window->openFile(QUrl::fromUserInput(parser.positionalArguments().at(0), QDir::currentPath()));
    }
    
    return app.exec();
} 
