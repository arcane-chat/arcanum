import QtQuick 2.0
import QtQuick.Window 2.0
import QtWebEngine 1.2

Window {
    width: 800
    height: 600
    visible: true
    WebEngineView {
        id: webview
        objectName: "web"
        anchors.fill: parent
        url: "file:///nix/store/0p37y27yih0gk2k8zqfcfv2n4zhas9rs-vm-test-run-arcanum-test/log.html"
        // url: "https://google.com"
    }
}
