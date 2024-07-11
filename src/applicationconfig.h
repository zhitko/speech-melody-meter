#ifndef APPLICATIONCONFIG_H
#define APPLICATIONCONFIG_H

#include <QString>
#include <QStringList>
#include <QGuiApplication>
#include <QDir>
#include <QStandardPaths>

namespace ApplicationConfig {
    static const QString DataPath = "data";
    static const QString RecordsPath = "records";
    static const QString TestsPath = "tests";

    static QString GetFullDataPath()
    {
#ifdef ANDROID
        QString recordsPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
//        QString recordsPath = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::DataPath);
        QString recordsPath = QDir(dataPath).absoluteFilePath(ApplicationConfig::RecordsPath);
#endif
        return recordsPath;
    }

    static QString GetFullTestsPath()
    {
#ifdef ANDROID
        QString testsPath = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::DataPath);
        QString testsPath = QDir(dataPath).absoluteFilePath(ApplicationConfig::TestsPath);
#endif
        return testsPath;
    }

    static const QString WaveFileExtension = "*.wav";

    static const QStringList WaveFileFilter = { WaveFileExtension };

    static const QString SettingsPath = "settings.ini";

    static QString GetFullSettingsPath()
    {
#ifdef ANDROID
        QString appPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::SettingsPath);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::SettingsPath);
#endif
        return dataPath;
    }

    static const QString ResultsPath = "results.csv";

    static QString GetFullResultsPath()
    {
#ifdef ANDROID
        QString appPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::ResultsPath);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::ResultsPath);
#endif
        return dataPath;
    }

    static const QString SETTINGS_VERSION_KEY = "version";
    static const QString SETTINGS_VERSION_VALUE = "10";

    static const int RecordingFrequency =  8000;
    static const int RecordingBitsPerSample =  16;
    static const int RecordingChannelsCount =  1;
    static const QString RecordingAudioFormat = "audio/pcm";
    static const QString RecordingFileFormat = ".wav";
    static const QString RecordingContainerFormat = "audio/x-wav";
    static const QString RecordingFileNameTemplate = "dd.MM.yyyy.hh.mm.ss.zzz";

    static const QString SETTINGS_NAME = "name";
    static const QString SETTINGS_DESC = "description";
    static const QString SETTINGS_VAL = "value";
    static const QString SETTINGS_TYPE = "type";
    static const QString SETTINGS_VISIBLE = "visible";
    static const QString SETTINGS_EDITABLE = "editable";

    static const QString SETTINGS_TYPE_INTEGER = "int";
    static const QString SETTINGS_TYPE_DOUBLE = "double";
    static const QString SETTINGS_TYPE_BOOL = "bool";
    static const QString SETTINGS_TYPE_LIST_DELIMETER = ";";
    static const QString SETTINGS_TYPE_DOUBLE_LIST = "double_list";

    static const QString SETTINGS_PITCH_ALGORITHM = "PitchAlgorithm";
    static const QString SETTINGS_PITCH_OUTPUT_FORMAT = "PitchOutputFormat";
    static const QString SETTINGS_PITCH_FRAME_SHIFT = "PitchFrameShift";
    static const QString SETTINGS_PITCH_RAPT_THRESHOLD = "PitchRaptThrehold";
    static const QString SETTINGS_PITCH_SWIPE_THRESHOLD = "PitchSwipeThrehold";
    static const QString SETTINGS_PITCH_SAMPLING_FREQUENCY = "PitchSamplingFrequency";
    static const QString SETTINGS_PITCH_MINIMUM_F0 = "PitchMinimumF0";
    static const QString SETTINGS_PITCH_MAXIMUM_F0 = "PitchMaximumF0";
    static const QString SETTINGS_PITCH_NORMALIZED = "PitchNormalized";
    static const QString SETTINGS_PITCH_OCTAVES = "PitchOctavesSeries";
    static const QString SETTINGS_PITCH_OCTAVES_ENABLED = "PitchOctavesSeriesEnabled";
    static const QString SETTINGS_PITCH_NORMALIZE_BY_OCTAVES = "PitchNormalizeOctavesSeries";
    static const QString SETTINGS_HISTOGRAM_THRESHOLD = "HistogramsThreshold";
    static const QString SETTINGS_HISTOGRAM_COMPONENTS_NUMBER = "HistogramComponentsNumber";
    static const QString SETTINGS_HISTOGRAM_F0MIN = "HistogramF0min";
    static const QString SETTINGS_HISTOGRAM_F0POWK = "HistogramF0pow";
    static const QString SETTINGS_HISTOGRAM_F0MAX = "HistogramF0max";
    static const QString SETTINGS_HISTOGRAM_DF0 = "HistogramDF0";

    static const QString SETTINGS_OCTAVES_HISTOGRAM_MEAN = "OctavesHistagramMean";

    static const QString SETTINGS_SEGMENTS_FRAME = "SegmentsFrame";
    static const QString SETTINGS_SEGMENTS_SHIFT = "SegmentsShift";
    static const QString SETTINGS_SEGMENTS_SMOOTH_FRAME = "SegmentsSmoothFrame";
    static const QString SETTINGS_SEGMENTS_SEGMENTS_LENGTH_LIMIT = "SegmentsLengthLimit";

    static const QString SETTINGS_TRUE = "true";
    static const QString SETTINGS_FALSE = "false";

    const static std::map<QString, std::map<QString, QString> > DEFAULT_SETTINGS = {
        {SETTINGS_SEGMENTS_FRAME,{
             {SETTINGS_NAME, "Intensity Frame"},
             {SETTINGS_DESC, "Intensity frame length used to calculate segments"},
             {SETTINGS_VAL, "240"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_SEGMENTS_SHIFT,{
             {SETTINGS_NAME, "Intensity Shift"},
             {SETTINGS_DESC, "Intensity frame shift used to calculate segments"},
             {SETTINGS_VAL, "120"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_SEGMENTS_SMOOTH_FRAME,{
             {SETTINGS_NAME, "Intensity Smooth Frame"},
             {SETTINGS_DESC, "Frame length used for smoothing intensity to segments calculation"},
             {SETTINGS_VAL, "120"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_SEGMENTS_SEGMENTS_LENGTH_LIMIT,{
             {SETTINGS_NAME, "Segments Length Limit"},
             {SETTINGS_DESC, "Segments length limit in millisec"},
             {SETTINGS_VAL, "15"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},

        {SETTINGS_PITCH_ALGORITHM,{
             {SETTINGS_NAME, "Pitch Algorithm"},
             {SETTINGS_DESC, "Algorithm used for extraction of pitch. \n[0: RAPT, 1: SWIPE, 2: Reaper, 3: World, 4: NumAlgorithms]"},
             {SETTINGS_VAL, "0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_OUTPUT_FORMAT,{
             {SETTINGS_NAME, "Pitch Output format"},
             {SETTINGS_DESC, "Output format. \n[0:pitch, 1:F0, 2:log(F0), 3: NumOutputFormats]"},
             {SETTINGS_VAL, "1"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_FRAME_SHIFT,{
             {SETTINGS_NAME, "Pitch Frame shift"},
             {SETTINGS_DESC, "Frame shift"},
             {SETTINGS_VAL, "60"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_RAPT_THRESHOLD,{
             {SETTINGS_NAME, "Pitch RAPT threhold"},
             {SETTINGS_DESC, "Voiced/unvoiced threhold (used only for RAPT algorithm)"},
             {SETTINGS_VAL, "0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_SWIPE_THRESHOLD,{
             {SETTINGS_NAME, "Pitch SWIPE threhold"},
             {SETTINGS_DESC, "Voiced/unvoiced threhold (used only for SWIPE algorithm)"},
             {SETTINGS_VAL, "0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_SAMPLING_FREQUENCY,{
             {SETTINGS_NAME, "Pitch Sampling frequency"},
             {SETTINGS_DESC, "Sampling frequency (kHz)"},
             {SETTINGS_VAL, "8.0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_MINIMUM_F0,{
             {SETTINGS_NAME, "Pitch Minimum F0"},
             {SETTINGS_DESC, "Minimum fundamental frequency to search for (Hz)"},
             {SETTINGS_VAL, "30.0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_MAXIMUM_F0,{
             {SETTINGS_NAME, "Pitch Maximum F0"},
             {SETTINGS_DESC, "Maximum fundamental frequency to search for (Hz)"},
             {SETTINGS_VAL, "1000.0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_NORMALIZED,{
             {SETTINGS_NAME, "Pitch Normalization"},
             {SETTINGS_DESC, "Normalize Pitch data"},
             {SETTINGS_VAL, "true"},
             {SETTINGS_TYPE, SETTINGS_TYPE_BOOL},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_NORMALIZE_BY_OCTAVES,{
             {SETTINGS_NAME, "Pitch Normalization By Octaves"},
             {SETTINGS_DESC, "Normalize Pitch data by ocataves"},
             {SETTINGS_VAL, "false"},
             {SETTINGS_TYPE, SETTINGS_TYPE_BOOL},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_OCTAVES_HISTOGRAM_MEAN,{
             {SETTINGS_NAME, "Octaves Histagram Mean"},
             {SETTINGS_DESC, "Apply mean values for octaves histogram"},
             {SETTINGS_VAL, "false"},
             {SETTINGS_TYPE, SETTINGS_TYPE_BOOL},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},

        {SETTINGS_PITCH_OCTAVES,{
             {SETTINGS_NAME, "Pitch Octaves Series"},
             {SETTINGS_DESC, "Pitch frequency segments"},
             {SETTINGS_VAL, "0;10;15;20;25;30;35;40;45;50;55;60;65;70;75;80;85;90;95;100;105;110;115;120;125;130;135;140;145;150;155;160;165;170;175;180;185;190;195;200;205;210;215;220;225;230;235;240;245;250;255;260;265;270;275;280;285;290;295;300;305;310;315;320;325;330;335;340;345;350;355;360;365;370;375;380;385;390;395;400;405;410;415;420;425;430;435;440;445;450;455;460;465;470;475;480;485;490;495;500"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE_LIST},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_PITCH_OCTAVES_ENABLED,{
             {SETTINGS_NAME, "Pitch Octaves Series Enabled"},
             {SETTINGS_DESC, "Use manual Octaves Series"},
             {SETTINGS_VAL, "false"},
             {SETTINGS_TYPE, SETTINGS_TYPE_BOOL},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_HISTOGRAM_THRESHOLD,{
             {SETTINGS_NAME, "Histograms Threshold"},
             {SETTINGS_DESC, "(0,00 – 1,00)"},
             {SETTINGS_VAL, "0.0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_DOUBLE},
             {SETTINGS_VISIBLE, SETTINGS_TRUE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_HISTOGRAM_COMPONENTS_NUMBER,{
             {SETTINGS_NAME, "Histogram Components Number"},
             {SETTINGS_DESC, "(1 – 100)"},
             {SETTINGS_VAL, "101"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_FALSE}
        }},
        {SETTINGS_HISTOGRAM_F0MIN,{
             {SETTINGS_NAME, "Histogram Min Value - F0min"},
             {SETTINGS_DESC, "Start histogram components Hz"},
             {SETTINGS_VAL, "0"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_HISTOGRAM_F0MAX,{
             {SETTINGS_NAME, "Histogram Max Value - F0max"},
             {SETTINGS_DESC, "End histogram components Hz"},
             {SETTINGS_VAL, "500"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_HISTOGRAM_DF0,{
             {SETTINGS_NAME, "Histogram Scale Step - dF0"},
             {SETTINGS_DESC, "Histogram components indent Hz"},
             {SETTINGS_VAL, "10"},
             {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
             {SETTINGS_VISIBLE, SETTINGS_FALSE},
             {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }},
        {SETTINGS_HISTOGRAM_F0POWK,{
            {SETTINGS_NAME, "Histogram Segments Level"},
            {SETTINGS_DESC, "Applied to Left and Right Segments"},
            {SETTINGS_VAL, "2"},
            {SETTINGS_TYPE, SETTINGS_TYPE_INTEGER},
            {SETTINGS_VISIBLE, SETTINGS_FALSE},
            {SETTINGS_EDITABLE, SETTINGS_TRUE}
        }}
    };

    static QString SettingsKey(QString group, QString key){
        return group + "/" + key;
    }

    static QString SettingsNameKey(QString group){
        return SettingsKey(group, SETTINGS_NAME);
    }

    static QString SettingsDescKey(QString group){
        return SettingsKey(group, SETTINGS_DESC);
    }

    static QString SettingsValueKey(QString group){
        return SettingsKey(group, SETTINGS_VAL);
    }

    static QString SettingsTypeKey(QString group){
        return SettingsKey(group, SETTINGS_TYPE);
    }

    static QString SettingsVisibleKey(QString group){
        return SettingsKey(group, SETTINGS_VISIBLE);
    }

    static QString SettingsEditableKey(QString group){
        return SettingsKey(group, SETTINGS_EDITABLE);
    }
}

#endif // APPLICATIONCONFIG_H
