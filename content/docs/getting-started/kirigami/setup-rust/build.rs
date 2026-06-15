use cxx_qt_build::{CxxQtBuilder, QmlModule};

fn main() {
    CxxQtBuilder::new_qml_module(
        QmlModule::new("org.kde.tutorial")
            .qml_files(&["src/qml/Main.qml"])
    )
    .build();
}