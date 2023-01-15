#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <KAboutData>
#include <KLocalizedContext>
#include <KLocalizedString>

#include "about.h"

int main(int argc, char *argv[])
{
    // enables High DPI scaling
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // create QApplication instance called "app"
    QApplication app(argc, argv);

    // set metadata relating to the application
    // QCoreApplication provides the event loop for applications, regardless if app has a GUI or not
    KLocalizedString::setApplicationDomain("helloworld");
    QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
    QCoreApplication::setApplicationName(QStringLiteral("Hello World"));

    KAboutData aboutData(
                         // The program name used internally.
                         QStringLiteral("helloworld"),
                         // A displayable program name string.
                         i18nc("@title", "Hello World"),
                         // The program version string.
                         QStringLiteral("1.0"),
                         // Short description of what the app does.
                         i18n("Hello world application"),
                         // The license this code is released under.
                         KAboutLicense::GPL,
                         // Copyright Statement.
                         i18n("(c) 2021"));
    aboutData.addAuthor(i18nc("@info:credit", "Your name"), i18nc("@info:credit", "Author Role"), QStringLiteral("your@email.com"), QStringLiteral("https://yourwebsite.com"));
    KAboutData::setApplicationData(aboutData);

    // lets us load an application from a qml file
    QQmlApplicationEngine engine;

    qmlRegisterSingletonType<AboutType>("org.kde.example", 1, 0, "AboutType", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return new AboutType();
    });

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
