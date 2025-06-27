use std::pin::Pin;

use cxx_qt_lib::QString;

#[cxx_qt::bridge]
mod ffi {

    unsafe extern "C++" {
        include!("cxx-qt-lib/qstring.h");
        type QString = cxx_qt_lib::QString;
    }

    #[auto_cxx_name]
    unsafe extern "RustQt" {
        #[qobject]
        #[qml_element]
        #[qproperty(QString, source_text)]
        type MdConverter = super::MdConverterStruct;

        #[qinvokable]
        fn md_format(self: Pin<&mut MdConverter>) -> QString;
    }
}

#[derive(Default)]
pub struct MdConverterStruct {
    source_text: QString,
}

impl ffi::MdConverter {
    pub fn md_format(self: Pin<&mut Self>) -> QString {
        QString::from(&markdown::to_html(&self.source_text().to_string()))
    }
}