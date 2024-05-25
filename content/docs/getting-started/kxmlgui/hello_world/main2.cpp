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
        u"helloworld"_s,
        // A displayable program name string. (displayName)
        i18n("Hello World tutorial"),
        // The program version string. (version)
        u"1.0"_s,
        // Short description of what the app does. (shortDescription)
        i18n("Displays a KMessageBox popup"),
        // The license this code is released under
        KAboutLicense::GPL,
        // Copyright Statement (copyrightStatement = QString())
        i18n("(c) 2024"),
        // Optional text shown in the About box.
        // Can contain any information desired. (otherText)
        i18n("Educational application..."),
        // The program homepage string. (homePageAddress = QString())
        u"https://apps.kde.org/someappname/"_s,
        // The bug report email address
        // (bugsEmailAddress = QLatin1String("submit@bugs.kde.org")
        u"submit@bugs.kde.org"_s);

    aboutData.addAuthor(
        // Author full name
        i18n("John Doe"),
        // Author role
        i18n("Tutorial learner"),
        // Author email
        u"john.doe@example.com"_s,
        // Author website
        u"https://john-doe.example.com"_s,
        // Username in store.kde.org (for avatar image)
        u"johndoe"_s);

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
