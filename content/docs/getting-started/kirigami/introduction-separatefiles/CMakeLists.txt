add_executable(kirigami-hello)

ecm_add_qml_module(kirigami-hello
    URI "org.kde.tutorial"
)

ecm_target_qml_sources(kirigami-hello
    SOURCES
    Main.qml
)

target_sources(kirigami-hello
    PRIVATE
    main.cpp
)

target_link_libraries(kirigami-hello
    PRIVATE
    Qt6::Quick
    Qt6::Qml
    Qt6::Gui
    Qt6::QuickControls2
    Qt6::Widgets
    KF6::I18n
    KF6::CoreAddons
    kirigami-hello-components
)

install(TARGETS kirigami-hello ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

add_subdirectory(components)
