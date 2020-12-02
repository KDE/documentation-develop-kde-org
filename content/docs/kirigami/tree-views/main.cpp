/**
 * Copied from https://doc.qt.io/archives/qt-5.10/qtquickcontrols-filesystembrowser-main-cpp.html
 * Copyright (C) 2018 The Qt Company Ltd.
 * SPDX-License-Identifier: BSD-3-Clause
 */
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QFileSystemModel>

class FileSystemModel : public QFileSystemModel {
    Q_OBJECT
public:
    explicit DisplayFileSystemModel(QObject *parent = Q_NULLPTR)
        : QFileSystemModel(parent) {
            setRootPath(QDir::homePath());
            setResolveSymlinks(true);
        }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<FileSystemModel>("org.kde.filesystembrowser", 1, 0, "FileSystemModel");
    engine.load(QUrl(QStringLiteral("qrc:main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

#include "main.moc"
