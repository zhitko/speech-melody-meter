import QtQuick 2.14
import QtQuick.Controls 2.14
import QtCharts 2.14

import "../../Components"
import "../../App"

PitchForm {
    id: root
    objectName: Enum.pagePitch

    property var waveSegments: []
    property var recordFullOctavesData: []
    property var octavesCategories: []
    property var optimazedCategories: []
    property int recordFullOctavesMax: 0

    property bool calculatedWaveSeries: false
    property bool calculatedPitchSeries: false

    property bool calculatedSegmentsSeries: false
    property bool calculatedFullPitchSeries: false

    property int minPitch: 0
    property int maxPitch: 1

    StackView.onActivated: {
        console.log("PitchForm.StackView.onActivated")
        Bus.hideAllBottomActions()
        Bus.showPlayButton = Bus.recordPath !== ""
        Bus.showSaveResultsButton = Bus.recordPath !== ""
        Bus.showRecordButton = true
        Bus.showOpenButton = true && Bus.canOpenButton

        loadSettings()

        initializeData()
    }

    function initializeData() {
        root.calculatedWaveSeries = false
        root.calculatedPitchSeries = false
        root.calculatedSegmentsSeries = false
        root.calculatedFullPitchSeries = false

        optimazedCategories = Bus.getOctavesOptimazedCategories()
        octavesCategories = Bus.getOctavesCategories()

        showOctaves()
        showOctavesMetrics()
        showOctavesMarks()
    }

    function showOctaves() {
        root.octavesSeries.clear()
        showRecordOctaves()
        showTemplateOctaves()
    }

    function showTemplateOctaves() {
        console.log("PitchForm.showTemplateOctaves")

        let octavesData = []

        let data = Bus.getTemplateOctavesData()
        console.log("getTemplateOctavesData", data)
        let max = 0
        for (let i=0; i< data.length - 1; i++) {
            console.log("value: ", data[i])
            octavesData.push(data[i])
            if (data[i] > max) max = data[i]
        }
        console.log("max", max)

        if (octavesCategorisY.max < max) {
            octavesCategorisY.max = max
        }

        octavesSeries.append("Template", octavesData)
    }

    function showRecordOctaves() {
        console.log("PitchForm.showRecordOctaves")

        let octavesData = []

        let data = Bus.getOctavesData()
        console.log("getOctavesData", data)
        if (data.length === 0) return;
        let max = 0
        for (let i=0; i< data.length - 1; i++) {
            console.log("value: ", data[i])
            octavesData.push(data[i])
            if (data[i] > max) max = data[i]
        }
        console.log("max", max)

        let octavesMax = data[data.length - 1]

        octavesCategorisX.categories = octavesCategories
        octavesMarksCategorisX.categories = octavesCategories
        octavesCategorisY.max = max

        octavesSeries.append("Record", octavesData)
    }

    function showOctavesMarks() {
        console.log("PitchForm.showOctavesMarks")
        root.octavesMarksSeries.clear()

        let recordData = Bus.getPitchOcavesMetrics(false)
        console.log("PitchForm.showOctavesMarks recordData", recordData)
        let recordSeries = []
        for (let i in octavesCategorisX.categories) {
            recordSeries.push(0)
        }
        if (!!recordData[0]) recordSeries[recordData[0]-1] = 1
        if (!!recordData[1]) recordSeries[recordData[1]-1] = 1
        if (!!recordData[2]) recordSeries[recordData[2]-1] = 1
        console.log("PitchForm.showOctavesMarks Record", recordSeries)
        root.octavesMarksSeries.append("Record", recordSeries)
    }

    function showOctavesMetrics() {
        console.log("PitchForm.showOctavesMetrics")

        let style = "font-size: 18pt;"
        let recordData = Bus.getPitchOcavesMetrics(false)
        root.rValue.text = qsTr("Center C(n): %1; \t C(F0): <span style='%3'>%2</span> Hz")
            .arg(recordData[0]).arg(recordData[3]).arg(style)
        root.dValue.text = qsTr("Band B(n): %1; \t B(F0): <span style='%3'>%2</span> Hz")
            .arg(recordData[4]).arg(recordData[5]).arg(style)
        root.aValue.text = qsTr("Asymmetry A(n): %1; \t A(F0): <span style='%3'>%2</span> Hz")
            .arg(recordData[6]).arg(recordData[7]).arg(style)

        Bus.setResultItem("5. C(F0)", recordData[3])
        Bus.setResultItem("4. B(F0)", recordData[5])
        Bus.setResultItem("3. A(F0)", recordData[7])
    }

    function addDataToSeries(serias, data) {
        serias.clear()
        for (let value in data){
            serias.append(data[value].x, data[value].y)
        }
    }

    NumberAnimation on settingsMargin {
        id: showAnimation
        from: hideAnimation.to
        to: hideAnimation.from
    }

    NumberAnimation on settingsMargin {
        id: hideAnimation
        from: 10
        to: -1 * settingsContentHeight
    }

    function loadSettings() {
        let settings = Bus.getSettingsMap()
        settingsF0MinValue.text = settings["HistogramF0min"]
        settingsDF0Value.text = settings["HistogramDF0"]
        settingsF0MaxValue.text = settings["HistogramF0max"]
        settingsNcValue.text = qsTr("Components Number - Nc: <span style='font-size: 18pt;'>%1</span>")
            .arg(settings["HistogramComponentsNumber"])
        root.settingsNeedApply = false
        root.maxCategoryItem.text = settingsF0MaxValue.text

        Bus.setResultItem("6. F0min", settings["HistogramF0min"])
        Bus.setResultItem("7. F0max", settings["HistogramF0max"])
        Bus.setResultItem("8. dF0", settings["HistogramDF0"])
        Bus.setResultItem("9. Nc", settings["HistogramComponentsNumber"])
    }

    settingsButton.onClicked: {
        root.settingsVisible = !root.settingsVisible
        if (root.settingsVisible) {
            showAnimation.start()
        } else {
            root.settingsNeedApply = false
            loadSettings()
            hideAnimation.start()
        }
    }

    settingsF0MinValue.onTextChanged: {
        root.settingsNeedApply = true
    }

    settingsDF0Value.onTextChanged: {
        root.settingsNeedApply = true
    }

    settingsF0MaxValue.onTextChanged: {
        root.settingsNeedApply = true
    }

    settingsApplyButton.button.onClicked: {
        Bus.setSettings("HistogramF0min", settingsF0MinValue.text)
        Bus.setSettings("HistogramDF0", settingsDF0Value.text)
        Bus.setSettings("HistogramF0max", settingsF0MaxValue.text)
        root.settingsNeedApply = false
        loadSettings()
        Bus.setTemplatePath("")
        initializeData()
    }
}
