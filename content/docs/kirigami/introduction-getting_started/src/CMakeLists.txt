set(helloworld_SRCS
    main.cpp
    resources.qrc
)
add_executable(helloworld ${helloworld_SRCS})
target_link_libraries(helloworld Qt5::Quick Qt5::Qml Qt5::Gui Qt5::QuickControls2 KF5::Kirigami2 KF5::I18n KF5::CoreAddons KF5::WidgetsAddons)
