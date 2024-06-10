add_executable(helloworld)

target_sources(helloworld PRIVATE
    main.cpp
    resources.qrc
)

target_link_libraries(helloworld
    Qt6::Quick
    Qt6::Qml
    Qt6::Gui
    Qt6::QuickControls2
    Qt6::Widgets
    KF6::Kirigami2
    KF6::I18n
    KF6::CoreAddons
)
