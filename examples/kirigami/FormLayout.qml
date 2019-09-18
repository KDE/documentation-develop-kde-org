import QtQuick 2.11
import org.kde kirigami 2.9 as Kirigami

...
Kirigami.FormLayout {
    id: formLayout

    // General
    Controls.CheckBox {
        Kirigami.FormData.label: i18nd("kcmmouse", "General:")
        id: leftHanded
        text: i18nd("kcmmouse", "Left handed mode")
    }

    Controls.CheckBox {
        id: middleEmulation
        text: i18nd("kcmmouse", "Press left and right buttons for middle-click")
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
    }

    // Acceleration
    Controls.Slider {
        Kirigami.FormData.label: i18nd("kcmmouse", "Pointer speed:")
        id: accelSpeed

        from: 1
        to: 11
        stepSize: 1
    }

    Layouts.ColumnLayout {
        id: accelProfile
        spacing: Kirigami.Units.smallSpacing
        Kirigami.FormData.label: i18nd("kcmmouse", "Acceleration profile:")
        Kirigami.FormData.buddyFor: accelProfileFlat

        Controls.RadioButton {
            id: accelProfileFlat
            text: i18nd("kcmmouse", "Flat")    
        }

        Controls.RadioButton {
            id: accelProfileAdaptive
            text: i18nd("kcmmouse", "Adaptive")
        }
    }

    Item {
        Kirigami.FormData.isSection: false
    }
}
