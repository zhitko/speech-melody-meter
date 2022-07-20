pragma Singleton
import QtQuick 2.14

import intondemo.backend 1.0

Item {
    id: root

    property var stackView
    property var settings

    property bool showRecordButton: false
    property bool canRecordButton: true
    property bool showPlayButton: false
    property bool showSaveResultsButton: false
    property bool canPlayButton: true
    property bool showOpenButton: false
    property bool showOpenTemplateButton: false
    property bool canOpenButton: !backend.isMobile()
    property bool canOpenTemplateButton: true

    property string currentPage: ""

    property string recordPath: ""
    property string templatePath: ""
    property var results: ({})

    Backend {
        id: backend
    }

    function getSettings() {
        console.log("Action.getSettings")
        return backend.getSettings()
    }

    function getSettingsMap() {
        console.log("Action.getSettingsMap")
        let settings = getSettings()
        let settingsMap = {}

        settings.forEach(setting => {
            settingsMap[setting.key] = setting.value
        });

        return settingsMap
    }

    function setSettings(name, value) {
        console.log("Action.setSettings", name, value)
        return backend.setSettings(name, value)
    }

    function getSavedResults() {
        console.log("Action.getSavedResults")
        return backend.getSavedResults()
    }

    function saveResults() {
        console.log("Action.getSavedResults")
        return backend.saveResult(results)
    }

    function setResultItem(key, value) {
        console.log("Action.addResult", key, value)
        results[key] = value
    }

    /*---------------------------------------------------------
      Actions
      ---------------------------------------------------------*/

    function setRecordPath(path) {
        root.templatePath = root.recordPath
        root.recordPath = path
        backend.moveRecordToTemplate()
    }

    function setTemplatePath(path) {
        root.templatePath = path
    }

    function startRecord() {
        console.log("Action.startRecord")

        setRecordPath(backend.startStopRecordWaveFile())

        root.canRecordButton = false
        root.canPlayButton = false
        root.canOpenTemplateButton = false
        root.canOpenButton = false
    }

    function stopRecord() {
        console.log("Action.stopRecord")
        backend.startStopRecordWaveFile()
        goPith()

        root.canRecordButton = true
        root.canOpenTemplateButton = true
        root.canPlayButton = true
        root.canOpenButton = true && !backend.isMobile()
    }

    function playRecord(playing) {
        console.log("Action.playRecord : ", playing)
        if (root.recordPath !== "") {
            console.log("Try play file : ", root.recordPath)
            backend.playWaveFile(root.recordPath, playing)
        }
    }

    function openFileDialog() {
        console.log("Action.openFileDialog")
        let newPath = backend.openFileDialog()
        console.log("Action.openFileDialog: newPath = ", newPath)
        let isChanged = root.recordPath !== newPath
        console.log("Action.openFileDialog: isChanged = ", isChanged)

        if (isChanged) {
            setRecordPath(newPath)
            goPith(true)
        }
    }

    function openTemplateFileDialog() {
        console.log("Action.openTemplateFileDialog")
        let newPath = backend.openFileDialog()
        console.log("Action.openTemplateFileDialog: newPath = ", newPath)
        let isChanged = root.templatePath !== newPath
        console.log("Action.openTemplateFileDialog: isChanged = ", isChanged)
        root.templatePath = newPath

        if (isChanged) {
            goPith(true)
        }
    }

    /*---------------------------------------------------------
      Data processing
      ---------------------------------------------------------*/

    function getRecordLength() {
        if (root.recordPath !== "") {
            return backend.getWaveLength(root.recordPath)
        } else {
            return 0
        }
    }

    function getWaveData() {
        if (root.recordPath !== "") {
            return backend.getWaveData(root.recordPath)
        } else {
            return []
        }
    }

    function getSegmentsByIntensity() {
        if (root.recordPath !== "") {
            return backend.getSegmentsByIntensity(root.recordPath)
        } else {
            return []
        }
    }

    function getPitchData() {
        if (root.recordPath !== "") {
            return backend.getPitchDataCutted(root.recordPath)
        } else {
            return []
        }
    }

    function getFullPitchData() {
        if (root.recordPath !== "") {
            return backend.getPitchFullData(root.recordPath)
        } else {
            return []
        }
    }

    function getPitchMinMax() {
        return backend.getPitchMinMax()
    }

    function getOctavesData() {
        if (root.recordPath !== "") {
            return backend.getPitchFrequencySegmentsCount(root.recordPath)
        } else {
            return []
        }
    }

    function getOctavesCategories() {
        return backend.getOctavesCategories()
    }

    function getOctavesOptimazedCategories() {
        return backend.getOctavesOptimazedCategories()
    }

    function getFullOctavesData() {
        if (root.recordPath !== "") {
            return backend.getPitchFrequencyCount(root.recordPath)
        } else {
            return []
        }
    }

    function getTemplateOctavesData() {
        if (root.templatePath !== "") {
            return backend.getTemplatePitchFrequencySegmentsCount(root.templatePath)
        } else {
            return []
        }
    }

    function getFullTemplateOctavesData() {
        if (root.templatePath !== "") {
            return backend.getTemplatePitchFrequencyCount(root.templatePath)
        } else {
            return []
        }
    }

    function getDerivativeData(isFull) {
        if (root.recordPath !== "") {
            return backend.getPitchDerivativeCount(root.recordPath, isFull)
        } else {
            return []
        }
    }

    function getTemplateDerivativeData(isFull) {
        if (root.templatePath !== "") {
            return backend.getTemplatePitchDerivativeCount(root.templatePath, isFull)
        } else {
            return []
        }
    }

    function getPitchOcavesMetrics(isFull) {
        if (root.recordPath !== "") {
            return backend.getPitchOcavesMetrics(root.recordPath, isFull)
        } else {
            return []
        }
    }

    function getTemplateOcavesMetrics(isFull) {
        if (root.templatePath !== "") {
            return backend.getTemplateOcavesMetrics(root.templatePath, isFull)
        } else {
            return []
        }
    }

    /*---------------------------------------------------------
      Navigation
      ---------------------------------------------------------*/

    function goToPage(page, params = {}, force = false) {
        if (currentPage !== page || force) {
            currentPage = page
            stackView.push(page, params)
            console.warn("Navigate to page: ", currentPage)
            validatePage()
        }
    }

    function goBack() {
        if (stackView.depth > 1)
        {
            stackView.pop()
            currentPage = stackView.currentItem.objectName
            console.warn("Back to page: ", currentPage)
            validatePage()
        }
    }

    function validatePage() {
        if (!currentPage) {
            console.warn("Current page do not have objectName: ", stackView.currentItem)
        }
    }

    function goHome() {
        goToPage(Enum.pageHome)
    }

    function goRecording() {
        goToPage(Enum.pageHome, {startRecording: true})
    }

    function goPith(force = false) {
        goToPage(Enum.pagePitch, {}, force)
    }

    function goSettings() {
        goToPage(Enum.pageSettings)
    }

    function goRecord() {
        goToPage(Enum.pageRecord)
    }

    function goResults() {
        goToPage(Enum.pageResults)
    }

    function goPolicy() {
        goToPage(Enum.pagePolicy)
    }

    /*---------------------------------------------------------
      Helpers
      ---------------------------------------------------------*/

    function hideAllBottomActions() {
        root.showRecordButton = false
        root.showPlayButton = false
        root.showOpenButton = false
        root.showSaveResultsButton = false
    }

    function getTimer(interval, parent) {
        let timer = Qt.createQmlObject("import QtQuick 2.0; Timer {}", parent)
        timer.interval = interval
        return timer
    }

}
