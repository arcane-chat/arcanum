#include <QGuiApplication>
#include <QWebEngineView>
#include <QString>
#include <QUrl>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QtWebEngine/qtwebengineglobal.h>
#include <QtWebChannel/QtWebChannel>
#include <QtQml>
#include <iostream>
#include <unistd.h>
#include <cstdio>

int main(int argc, char **argv) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();
    // QWebEngineView browser;
    // browser.show();
    // browser.load(QUrl(QString("https://google.com")));

    // QQuickStyle::setStyle(QStringLiteral("Material"));

    QQmlApplicationEngine engine;
    // engine.load(QUrl::fromLocalFile("main.qml"));
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    {
        // for(QObject* object : engine.rootObjects()) {
        //     if(object) {
        //         QQuickWebEngineView* webview
        //             = object->findChild<QQuickWebEngineView*>("web");
        //         qDebug() << "DEBUG2: " << (webview->url());
        //     }
        // }
        // usleep(5000000);
        // std::string temp = (webview->url()).toDisplayString().toStdString();
        // std::cerr << "DEBUG: " << temp << "\n";
        // usleep(5000000);
        // delete object;
    }

    return app.exec();
}
