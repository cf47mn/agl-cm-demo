TARGET = agl-cm-demo
QT = quick aglextras

HEADERS += FileIO.hpp

SOURCES = main.cpp

RESOURCES += \
    agl-cm-demo.qrc

include(app.pri)
