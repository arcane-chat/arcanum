#include <QGuiApplication>
#include <QWebEngineView>
#include <QString>
#include <QUrl>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QtWebEngine/qtwebengineglobal.h>
#include <iostream>

int main(int argc, char **argv) {
  QGuiApplication app(argc, argv);
  QtWebEngine::initialize();
  // QWebEngineView browser;
  // browser.show();
  // browser.load(QUrl(QString("https://google.com")));
  QQmlApplicationEngine engine;
  QString cwd = QDir::currentPath();
  engine.load(QUrl("file://" + cwd + "/main.qml"));
  return app.exec();
}
