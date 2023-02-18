#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <KAboutData>
#include <KLocalizedContext>
#include <KLocalizedString>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    KLocalizedString::setApplicationDomain("helloworld");
    QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
    QCoreApplication::setApplicationName(QStringLiteral("Hello World"));

    KAboutData aboutData(
        QStringLiteral("helloworld"),
        i18nc("@title", "Hello World"),
        QStringLiteral("1.0"),
        i18n("Hello world application"),
        KAboutLicense::GPL,
        i18n("(c) 2021"));

    aboutData.addAuthor(
        i18nc("@info:credit", "Your name"),
        i18nc("@info:credit", "Author Role"),
        QStringLiteral("your@email.com"),
        QStringLiteral("https://yourwebsite.com"));

    // Set aboutData as information about the app
    KAboutData::setApplicationData(aboutData);

    // Register a singleton that will be accessible from QML.
    qmlRegisterSingletonType(
        "org.kde.example", // How the import statement should look like
        1, 0, // Major and minor versions of the import
        "About", // The name of the QML object
        [](QQmlEngine* engine, QJSEngine *) -> QJSValue {
            // Here we retrieve our aboutData and give it to the QML engine
            // to turn it into a QML type
            return engine->toScriptValue(KAboutData::applicationData());
        }
    );

    // Load an application from a QML file
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
