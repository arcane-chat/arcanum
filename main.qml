import QtQuick 2.0
import QtQuick.Window 2.0
import QtWebEngine 1.2

Window {
    width: 800
    height: 600
    visible: true
    WebEngineView {
        id: webview
        anchors.fill: parent
        url: "https://google.com"
    }
}
