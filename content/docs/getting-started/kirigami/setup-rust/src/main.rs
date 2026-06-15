use cxx_qt_lib::{QGuiApplication, QQmlApplicationEngine, QQuickStyle};
use cxx_qt_lib_extras::QApplication;
use std::env;

fn main() {
    let mut app = QApplication::new();
    let mut engine = QQmlApplicationEngine::new();

    // To associate the executable to the installed desktop file
    QGuiApplication::set_desktop_file_name(&"org.kde.kirigami_rust".into());
    // To ensure the style is set correctly
    let style = env::var("QT_QUICK_CONTROLS_STYLE");
    if style.is_err() {
        QQuickStyle::set_style(&"org.kde.desktop".into());
    }

    if let Some(engine) = engine.as_mut() {
        engine.load(&"qrc:/qt/qml/org/kde/tutorial/src/qml/Main.qml".into());
    }

    if let Some(app) = app.as_mut() {
        app.exec();
    }
}
