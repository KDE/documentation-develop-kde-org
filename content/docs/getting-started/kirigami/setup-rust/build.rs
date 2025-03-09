use cxx_qt_build::{CxxQtBuilder, QmlModule};

fn main() {
    CxxQtBuilder::new()
        .qml_module(QmlModule {
            uri: "org.kde.tutorial",
            qml_files: &["src/qml/Main.qml"],
            rust_files: &["src/main.rs"],
            ..Default::default()
        })
        .build();
}
