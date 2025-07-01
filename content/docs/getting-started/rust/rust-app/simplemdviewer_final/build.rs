use cxx_qt_build::{CxxQtBuilder, QmlModule};

fn main() {
    CxxQtBuilder::new()
        .qml_module(QmlModule {
            uri: "org.kde.simplemdviewer",
            qml_files: &["src/qml/Main.qml"],
            rust_files: &["src/mdconverter.rs"],
            ..Default::default()
        })
        .build();
}
