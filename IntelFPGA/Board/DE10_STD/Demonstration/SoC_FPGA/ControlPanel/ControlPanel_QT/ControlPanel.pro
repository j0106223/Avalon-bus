#-------------------------------------------------
#
# Project created by QtCreator 2017-02-06T03:37:46
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
    tab_ir.cpp \
    hps_lcd/terasic_spi.cpp \
    hps_lcd/lcd_graphic.cpp \
    hps_lcd/lcd_wcg12864_driver.cpp \
    hps_lcd/font.cpp \
    hps_audio.cpp

HEADERS  += dialog.h \
    hps.h \
    ADLX345.h \
    fpga.h \
    hps_lcd/hps_lcd.h \
    hps_lcd/terasic_spi.h \
    hps_0.h \
    hps_lcd/lcd_graphic.h \
    hps_lcd/lcd_wcg12864_driver.h \
    hps_lcd/font.h \
    hps_audio.h

LIBS += -L$$PWD/alsa/library -lasound

FORMS    += dialog.ui
INCLUDEPATH += alsa/include
INCLUDEPATH += /home/terasic/intelFPGA/16.1/embedded/ip/altera/hps/altera_hps/hwlib/include
INCLUDEPATH += /home/terasic/intelFPGA/16.1/embedded/ip/altera/hps/altera_hps/hwlib/include/soc_cv_av
DEPENDPATH += /home/terasic/intelFPGA/16.1/embedded/ip/altera/hps/altera_hps/hwlib/include

#QMAKE_CXXFLAGS += -std=gnu++11
#QMAKE_CXXFLAGS += -std=c++0x
QMAKE_CXXFLAGS += -std=c++11 -Dsoc_cv_av


RESOURCES += \
    images/images.qrc

DISTFILES += \
    qt5.5.1_for_intel_soc.tar.gz \
    ControlPanel \
    hps_lcd/hps_lcd.cpp.bak \
    hps_lcd/hps_lcd.h.bak \
    hps_lcd/LCD_WCG12864_Driver.c.bak \
    hps_lcd/LCD_WCG12864_Driver.h.bak \
    hps_lcd/spi.h.bak \
    hps_lcd/terasic_spi.cpp.bak \
    hps_lcd/terasic_spi.h.bak

