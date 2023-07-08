#-------------------------------------------------
#
# Project created by QtCreator 2013-10-02T07:24:42
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ControlPanel
TEMPLATE = app


SOURCES += main.cpp\
        dialog.cpp \
    hps.cpp \
    ADLX345.cpp \
    tab_gsensor.cpp \
    fpga.cpp \
    tab_button.cpp \
    tab_hex.cpp \
    tab_ir.cpp

HEADERS  += dialog.h \
    hps.h \
    ADLX345.h \
    fpga.h

FORMS    += dialog.ui
INCLUDEPATH += /home/terasic/altera/13.1/embedded/ip/altera/hps/altera_hps/hwlib/include
DEPENDPATH += /home/terasic/altera/13.1/embedded/ip/altera/hps/altera_hps/hwlib/include

#QMAKE_CXXFLAGS += -std=gnu++11
QMAKE_CXXFLAGS += -std=c++0x

RESOURCES += \
    images/images.qrc
