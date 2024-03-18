#include <QApplication>
#include <QCommandLineParser>
#include <QDir>
#include <QUrl>

#include <KAboutData>
#include <KLocalizedString>

#include "mainwindow.h"

int main (int argc, char *argv[])
{
    using namespace Qt::Literals::StringLiterals;

    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("texteditor");
    KAboutData aboutData(
        u"texteditor"_s,
        i18n("Text Editor"),
        u"1.0"_s,
        i18n("A simple text area using QAction etc."),
        KAboutLicense::GPL,
        i18n("(c) 2015"),
        i18n("Some text..."),
        u"https://example.kde.org/"_s,
        u"submit@bugs.kde.org"_s);

    aboutData.addAuthor(i18n("Name"), i18n("Task"),
        u"your@email.com"_s,
        u"https://your.website.com"_s,
        u"OSC Username"_s);

    KAboutData::setApplicationData(aboutData);
 
    QCommandLineParser parser;
    aboutData.setupCommandLine(&parser);
    parser.addPositionalArgument(u"file"_s, i18n("Document to open"));

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
