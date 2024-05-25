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
        i18n("(c) 2024"),
        i18n("Educational application..."),
        u"https://apps.kde.org/someappname/"_s,
        u"submit@bugs.kde.org"_s);

    aboutData.addAuthor(
        i18n("John Doe"),
        i18n("Tutorial learner"),
        u"john.doe@example.com"_s,
        u"https://john-doe.example.com"_s,
        u"johndoe"_s);

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
