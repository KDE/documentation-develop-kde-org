#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <KLocalizedContext>
#include <KDescendantsProxyModel>
#include "mailmodel.h"
#include "quickmail.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QCoreApplication::setOrganizationName("KDE");
    QCoreApplication::setOrganizationDomain("kde.org");
    QCoreApplication::setApplicationName("KMailQuick");

    QQmlApplicationEngine engine;

    qRegisterMetaType<MailModel*>("MailModel*");
    qRegisterMetaType<KDescendantsProxyModel*>("KDescendantsProxyModel*");
    qmlRegisterSingletonInstance<QuickMail>("org.kde.quickmail.private", 1, 0, "QuickMail", quickMail);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
