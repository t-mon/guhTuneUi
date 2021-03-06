TEMPLATE = app

QT += qml quick network

SOURCES += main.cpp \
    core.cpp \
    guhclient.cpp

RESOURCES += qml.qrc    \
             images.qrc \

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    core.h \
    guhclient.h
