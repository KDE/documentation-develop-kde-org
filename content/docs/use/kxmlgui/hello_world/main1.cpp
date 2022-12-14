#include <QApplication>
#include <KMessageBox>

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);

    KGuiItem yesButton(// Content text, Icon, Tooltip Text, WhatsThis text
        "Hello", QString(),
        "This is a tooltip",
        "This is a WhatsThis help text.");

    // If user clicks Yes button, return EXIT_SUCCESS, else return EXIT_FAILURE
    return KMessageBox::questionYesNo(0, "Hello World", "Hello", yesButton)
        == KMessageBox::Yes ? EXIT_SUCCESS : EXIT_FAILURE;
}
