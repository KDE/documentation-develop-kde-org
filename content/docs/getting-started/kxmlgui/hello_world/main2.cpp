#include <QApplication>
#include <KMessageBox>
#include <KAboutData>
#include <KLocalizedString>

int main (int argc, char *argv[])
{
    using namespace Qt::Literals::StringLiterals;

    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("tutorial1");

    KAboutData aboutData(
        // The program name used internally. (componentName)
        u"tutorial1"_s,
        // A displayable program name string. (displayName)
        i18n("Tutorial 1"),
        // The program version string. (version)
        u"1.0"_s,
        // Short description of what the app does. (shortDescription)
        i18n("Displays a KMessageBox popup"),
        // The license this code is released under
        KAboutLicense::GPL,
        // Copyright Statement (copyrightStatement = QString())
        i18n("(c) 2021"),
        // Optional text shown in the About box.
        // Can contain any information desired. (otherText)
        i18n("Some text..."),
        // The program homepage string. (homePageAddress = QString())
        u"https://example.com/"_s,
        // The bug report email address
        // (bugsEmailAddress = QLatin1String("submit@bugs.kde.org")
        u"submit@bugs.kde.org"_s);

    aboutData.addAuthor(
        i18n("Name"),
        i18n("Author Role"),
        u"your@email.com"_s,
        u"https://your.website.com"_s,
        u"OCS Username"_s);

    KAboutData::setApplicationData(aboutData);

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
