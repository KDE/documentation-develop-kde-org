#include <QApplication>
#include <KMessageBox>

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);

    KGuiItem primaryAction(
        // Content text, Icon
        QStringLiteral("Hello"), QString(),
        // Tooltip text
        QStringLiteral("This is a tooltip"),
        // WhatsThis text
        QStringLiteral("This is a WhatsThis help text."));

    auto messageBox = KMessageBox::questionTwoActions(
        // Parent
        nullptr,
        // MessageBox contents
        QStringLiteral("Hello World"),
        // MessageBox title
        QStringLiteral("Hello Title"),
        // Primary action, Secondary action
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
