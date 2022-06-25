import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../App"
import "../../Components/"
import "../../Components/Buttons"
import "../../Components/FontAwesome"

Page {
    id: root

    property alias recordButton: recordButton
    property alias pianoBtn: pianoBtn

    title: qsTr("Home")

    Label {
        id: welcomeText
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        text: qsTr("Welcome to Speech Melody Meter")
        font.pointSize: 20
        wrapMode: Text.WordWrap
        horizontalAlignment: "AlignHCenter"
    }

    Image {
        id: wave
        anchors.top: welcomeText.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        fillMode: Image.Tile
        horizontalAlignment: Image.AlignLeft
        height: 100
        source: "qrc:///Assets/Images/wave_long.png"
    }

    Image {
        id: piano
        anchors.top: wave.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        fillMode: Image.Tile
        horizontalAlignment: Image.AlignLeft
        height: 120
        source: "qrc:///Assets/Images/piano-keys.png"
        ToolButton {
            id: pianoBtn
            anchors.top: piano.top
            anchors.bottom: piano.bottom
        }
    }

    AnimatedRecordButton {
        id: recordButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: piano.bottom
        anchors.topMargin: 10
        height: 200
        width: 200
    }

    Label {
        id: recordButtonHint
        anchors.top: recordButton.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        text: recordButton.checked ? qsTr("Click to stop recording") : qsTr("Click to start recording")
        font.pointSize: 15
        wrapMode: Text.WordWrap
        horizontalAlignment: "AlignHCenter"
    }
}
