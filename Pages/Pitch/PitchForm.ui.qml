import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Styles 1.4
import QtCharts 2.3
import QtQuick.Layouts 1.14

import "../../App"
import "../../Components"
import "../../Components/FontAwesome"

Page {
    id: root
    property alias octavesSeries: octavesSeries
    property alias octavesMarksSeries: octavesMarksSeries
    property alias octavesCategorisX: octavesCategorisX
    property alias octavesCategorisY: octavesCategorisY
    property alias octavesMarksCategorisX: octavesMarksCategorisX
    property alias octavesMarksCategorisY: octavesMarksCategorisY
    property alias settingsButton: settingsButton

    property alias rValue: rValue
    property alias aValue: aValue
    property alias dValue: dValue

    property bool settingsVisible: true
    property bool settingsNeedApply: false
    property alias settingsMargin: settingsLayout.anchors.topMargin
    property alias settingsContentHeight: settingsLayout.contentHeight

    property alias settingsF0MinValue: settingsF0MinValue
    property alias settingsDF0Value: settingsDF0Value
    property alias settingsF0MaxValue: settingsF0MaxValue
    property alias settingsNcValue: settingsNcValue
    property alias settingsApplyButton: settingsApplyButton
    property alias maxCategoryItem: maxCategoryItem

    width: Config.pageWidth
    height: Config.pageHeight
    title: qsTr("Speech Fundamental Frequencies - F0 [Hz]")

    Rectangle {
        id: settingsFrame

        color: Colors.blue

        anchors.top: parent.top
        anchors.bottom: settingsButtonFrame.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    GridLayout {
        id: settingsLayout

        columns: 6

        property int contentHeight: 40

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 25

        Text {
            id: settingsF0MinLabel
            text: qsTr("F0min:")
            color: "white"
            Layout.minimumHeight: 40
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            font.pointSize: 14
        }

        TextField {
            id: settingsF0MinValue
            text: "0"
            Layout.fillWidth: true
            color: "white"
            validator: IntValidator{bottom: 0; top: 9999;}
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
        }

        Text {
            id: settingsDF0Label
            text: qsTr("dF0:")
            color: "white"
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
        }

        TextField {
            id: settingsDF0Value
            text: "1"
            Layout.fillWidth: true
            color: "white"
            validator: IntValidator{bottom: 1; top: 9999;}
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
        }

        Text {
            id: settingsF0MaxLabel
            text: qsTr("F0max:")
            color: "white"
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
        }

        TextField {
            id: settingsF0MaxValue
            text: "1"
            Layout.fillWidth: true
            color: "white"
            validator: IntValidator{bottom: 1; top: 9999;}
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
        }

        FontAwesomeToolButton {
            id: settingsApplyButton

            visible: settingsNeedApply
            width: 40
            height: 40
            Layout.fillWidth: true
            font.family: FontAwesome.solid
            font.pixelSize: 40
            icon: FontAwesome.icons.faCheckCircle
            Layout.bottomMargin: 5
            Layout.columnSpan: 6
        }
    }

    Rectangle {
        id: settingsButtonFrame
        height: 25

        color: settingsFrame.color
        radius: 5

        anchors.top: settingsLayout.bottom
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        Rectangle {
            anchors.fill: parent
            anchors.bottomMargin: settingsButtonFrame.radius
            color: settingsButtonFrame.color

            ToolButton {
                id: settingsButton
                anchors.fill: parent
                anchors.topMargin: settingsButtonFrame.radius
                text: qsTr("Basic Parameters Of Histograme")
                font.pointSize: 14
                contentItem: Text {
                    text: settingsButton.text
                    font: settingsButton.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }
            Text {
                text: settingsVisible ? qsTr("\u25B2") : qsTr("\u25BC")
                color: "white"
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }

    ColumnLayout {
        id: mainLayout
        anchors.top: settingsLayout.bottom
        anchors.topMargin: 30
        anchors.right: parent.right
        anchors.left: parent.left

        spacing: 10

        RowLayout {
            Layout.fillWidth: true

            Rectangle {
                id: ncBar
                color: Colors.varmillion
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                id: settingsNcValue
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: qsTr("0")
                textFormat: Text.RichText
                font.pointSize: 12
            }

            Rectangle {
                color: ncBar.color
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Rectangle {
                id: rBar
                color: Colors.blue
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                id: rValue
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: qsTr("0")
                textFormat: Text.RichText
                font.pointSize: 12
            }

            Rectangle {
                color: rBar.color
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Rectangle {
                id: dBar
                color: Colors.light_green
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                id: dValue
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: qsTr("0")
                textFormat: Text.RichText
                font.pointSize: 12
            }

            Rectangle {
                color: dBar.color
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Rectangle {
                id: aBar
                color: Colors.raspberry
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                id: aValue
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: qsTr("0")
                textFormat: Text.RichText
                font.pointSize: 12
            }

            Rectangle {
                color: aBar.color
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    ChartView {
        id: octavesMarks
        height: 50

        anchors.bottom: parent.bottom
        anchors.left: octaves.left
        anchors.right: octaves.right

        margins.bottom: 0
        margins.top: 0
        margins.left: 30
        margins.right: 0

        legend.visible: false

        BarSeries {
            id: octavesMarksSeries
            barWidth: 1
            axisX: BarCategoryAxis {
                id: octavesMarksCategorisX
                labelsFont.pointSize: 0
                visible: false
            }
            axisY: ValueAxis {
                id: octavesMarksCategorisY
                labelsFont.pointSize: 8
                max: 1
                min: 0
                tickCount: 2
                visible: false
            }
        }
    }

    ChartView {
        id: octaves
        height: 300

        anchors.top: mainLayout.bottom
        anchors.bottom: octavesMarks.top
        anchors.left: mainLayout.left
        anchors.right: mainLayout.right

        margins.bottom: 0
        margins.top: 0
        margins.left: 0
        margins.right: 0

        legend.visible: false

        BarSeries {
            id: octavesSeries
            barWidth: 1
            axisX: BarCategoryAxis {
                id: octavesCategorisX
                labelsFont.bold: true
                labelsFont.pointSize: 8
                labelsVisible: false
            }
            axisY: ValueAxis {
                id: octavesCategorisY
                max: 1
                min: 0
                labelsFont.bold: true
            }
        }
    }

    ListView {
        id: newCategories
        orientation: ListView.Horizontal
        height: 30
        width: octaves.plotArea.width
        anchors.left: octaves.left
        anchors.leftMargin: octaves.plotArea.x
        anchors.bottom: octaves.bottom
        model: optimazedCategories
        delegate: Rectangle {
            width: ListView.view.width / optimazedCategories.length + (index === 0 ? 1 : 0)
            height: 30
            color: 'lightgray'
            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: 1
                anchors.leftMargin: index === 0 ? 1 : 0
                Label {
                    anchors.fill: parent
                    text: optimazedCategories[index]
                    font.pointSize:  10
                    horizontalAlignment: "AlignLeft"
                    anchors.leftMargin: 5
                    verticalAlignment: "AlignVCenter"
                }
            }
        }
    }

    Label {
        id: maxCategoryItem
        anchors.right: newCategories.right
        anchors.rightMargin: 5
        anchors.verticalCenter: newCategories.verticalCenter
        text: ""
        font.pointSize:  10
        verticalAlignment: "AlignVCenter"
    }
}
