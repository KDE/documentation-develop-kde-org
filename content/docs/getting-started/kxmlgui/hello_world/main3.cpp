#include <QApplication>
#include <QCommandLineParser>
#include <KMessageBox>
#include <KAboutData>
#include <KLocalizedString>

int main (int argc, char *argv[])
{
    using namespace Qt::Literals::StringLiterals;

    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("tutorial1");

    KAboutData aboutData(
        u"helloworld"_s,
        i18n("Hello World tutorial"),
        u"1.0"_s,
        i18n("Displays a KMessageBox popup"),
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
