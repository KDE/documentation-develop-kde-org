#include <QApplication>
#include <KMessageBox>

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);

    KGuiItem yesButton("Hello", QString(),
                        "This is a tooltip",
                        "This is a WhatsThis help text.");

    return KMessageBox::questionYesNo(0, "Hello World", "Hello", yesButton)
        == KMessageBox::Yes? EXIT_SUCCESS: EXIT_FAILURE;
}
