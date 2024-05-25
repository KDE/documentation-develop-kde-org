#include <QApplication>
#include <QCommandLineParser>
#include <KAboutData>
#include <KLocalizedString>
#include "mainwindow.h"

int main (int argc, char *argv[])
{
    using namespace Qt::Literals::StringLiterals;

    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("mainwindow");

    KAboutData aboutData(
        u"mainwindow"_s,
        i18n("Main Window"),
        u"1.0"_s,
        i18n("A simple text area"),
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
    parser.process(app);
    aboutData.processCommandLine(&parser);

    MainWindow *window = new MainWindow();
    window->show();

    return app.exec();
}
