#include <QApplication>
#include <KMessageBox>
#include <KAboutData>
#include <KLocalizedString>
#include <QCommandLineParser>

int main (int argc, char *argv[])
{
    using namespace Qt::Literals::StringLiterals;

    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("tutorial1");

    KAboutData aboutData(
        u"tutorial1"_s,
        i18n("Tutorial 1"),
        u"1.0"_s,
        i18n("Displays a KMessageBox popup"),
        KAboutLicense::GPL,
        i18n("(c) 2021"),
        i18n("Some text..."),
        u"https://example.com/"_s,
        u"submit@bugs.kde.org"_s);

    aboutData.addAuthor(
        i18n("Name"),
        i18n("Author Role"),
        u"your@email.com"_s,
        u"https://your.website.com"_s,
        u"OCS Username"_s);

    KAboutData::setApplicationData(aboutData);

    QCommandLineParser parser;
    aboutData.setupCommandLine(&parser);
    parser.process(app);
    aboutData.processCommandLine(&parser);

    KGuiItem primaryAction(
        i18n("Hello"), QString(),
        i18n("This is a tooltip"),
        i18n("This is a WhatsThis help text."));

    auto messageBox = KMessageBox::questionTwoActions(
        nullptr,
        i18n("Hello World"),
        i18n("Hello Title"),
        primaryAction, KStandardGuiItem::cancel());

    if (messageBox == KMessageBox::PrimaryAction)
    {
        return EXIT_SUCCESS;
    }
    else
    {
        return EXIT_FAILURE;
    }
}
