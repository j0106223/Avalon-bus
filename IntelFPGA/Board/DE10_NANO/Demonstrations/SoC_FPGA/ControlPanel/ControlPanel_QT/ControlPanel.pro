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
    tab_button.cpp

HEADERS  += dialog.h \
    hps.h \
    ADLX345.h \
    fpga.h

FORMS    += dialog.ui
INCLUDEPATH += /home/terasic/altera/16.0/embedded/ip/altera/hps/altera_hps/hwlib/include
INCLUDEPATH += /home/terasic/altera/16.0/embedded/ip/altera/hps/altera_hps/hwlib/include/soc_cv_av
DEPENDPATH += /home/terasic/altera/16.0/embedded/ip/altera/hps/altera_hps/hwlib/include

#QMAKE_CXXFLAGS += -std=gnu++11
QMAKE_CXXFLAGS += -std=c++11 -Dsoc_cv_av

RESOURCES += \
    images/images.qrc
