use cxx_qt_build::{CxxQtBuilder, QmlModule};

fn main() {
    CxxQtBuilder::new_qml_module(
        QmlModule::new("org.kde.simplemdviewer")
        .qml_file("src/qml/Main.qml")
    )
    .build();
}
