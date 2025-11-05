use cxx_qt_lib::{QGuiApplication, QQmlApplicationEngine, QQuickStyle, QString, QUrl, QByteArray};
use cxx_qt_lib_extras::QApplication;
use cxx_kde_frameworks::kcrash::KCrash;
use cxx_kde_frameworks::kcoreaddons::{KAboutData, License};
use cxx_kde_frameworks::ki18n::{i18nc, KLocalizedContext, KLocalizedString};
use std::env;

mod mdconverter;

fn main() {
    let mut app = QApplication::new();
    KCrash::initialize();
    KLocalizedString::set_application_domain(&QByteArray::from("simplemdviewer"));

    // To associate the executable to the installed desktop file
    QGuiApplication::set_desktop_file_name(&QString::from("org.kde.simplemdviewer"));

    // To ensure the style is set correctly
    if env::var("QT_QUICK_CONTROLS_STYLE").is_err() {
        QQuickStyle::set_style(&QString::from("org.kde.desktop"));
    }

    let about_data = KAboutData::from(
        // componentName
        QString::from("org.kde.simplemdviewer"),
        // displayName
        i18nc("@title", "Simplemdviewer"),
        // version
        QString::from("1.0"),
        // shortDescription
        QString::from("Rust application to test KDE Frameworks bindings"),
        // license
        License::GPL_V3
    );
    KAboutData::set_application_data(&about_data);

    let mut engine = QQmlApplicationEngine::new();
    if let Some(mut engine) = engine.as_mut() {
        KLocalizedContext::initialize_engine(engine.as_mut().as_qqmlengine());
        engine.load(&QUrl::from(
            "qrc:/qt/qml/org/kde/simplemdviewer/src/qml/Main.qml"
        ));
    }

    if let Some(app) = app.as_mut() {
        app.exec();
    }
}
