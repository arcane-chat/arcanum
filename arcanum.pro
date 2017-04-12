CONFIG += debug qml_debug

TEMPLATE = app
TARGET = arcanum
INCLUDEPATH += .
RESOURCES = arcanum.qrc

QT += gui widgets webengine webenginewidgets webchannel

# Input
SOURCES += src/main.cpp
INSTALLS += target
target.path = /${out}/bin
