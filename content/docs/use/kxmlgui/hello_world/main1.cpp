#include <QApplication>
#include <KMessageBox>

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);

    KGuiItem primaryAction(
        // Content text, Icon, Tooltip Text, WhatsThis text
        "Hello", QString(),
        "This is a tooltip",
        "This is a WhatsThis help text.");

    // If user clicks the Hello button, return EXIT_SUCCESS,
    // else return EXIT_FAILURE
    return KMessageBox::questionTwoActions(
        nullptr, "Hello World", "Hello Title",
        primaryAction, KStandardGuiItem::cancel())
        == KMessageBox::PrimaryAction ? EXIT_SUCCESS : EXIT_FAILURE;
}
