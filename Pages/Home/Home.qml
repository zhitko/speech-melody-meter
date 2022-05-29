import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../App"

HomeForm {
    id: root
    objectName: Enum.pageHome

    property bool startRecording: false

    property int count: 0

    StackView.onActivated: {
        console.log("HomeForm.StackView.onActivated", root.startRecording)
        Bus.hideAllBottomActions()
        Bus.showOpenButton = true
        Bus.showOpenTemplateButton = true

        if (root.startRecording == true) {
            recordButton.checked = true
        }
    }

    pianoBtn.onClicked: {
        count ++
        if (count > 2) {
            Bus.recordPath = ":/Assets/audio.wav"
            Bus.goPith()
        }
    }

}
