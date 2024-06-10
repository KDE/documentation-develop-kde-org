add_library(kirigami-hello-components)

ecm_add_qml_module(kirigami-hello-components
    URI "org.kde.tutorial.components"
)

ecm_target_qml_sources(kirigami-hello-components
    SOURCES
    AddEditDialog.qml
    KountdownDelegate.qml
)

ecm_finalize_qml_module(kirigami-hello-components)

install(TARGETS kirigami-hello-components ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
