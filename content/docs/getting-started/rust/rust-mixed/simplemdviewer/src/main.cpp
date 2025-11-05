#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QGuiApplication::setDesktopFileName(QStringLiteral("org.kde.simplemdviewer"));

    QApplication::setStyle(QStringLiteral("breeze"));
    if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE")) {
        QQuickStyle::setStyle(QStringLiteral("org.kde.desktop"));
    }

    QQmlApplicationEngine engine;
    engine.load("qrc:/qt/qml/org/kde/simplemdviewer/src/qml/Main.qml");

    return app.exec();
}
