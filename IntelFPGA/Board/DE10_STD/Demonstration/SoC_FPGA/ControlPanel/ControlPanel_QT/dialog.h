#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QString>
#include "hps.h"
#include "fpga.h"
#include "hps_lcd/lcd_graphic.h"
#include "hps_audio.h"

namespace Ui {
class Dialog;
}

class Dialog : public QDialog
{
    Q_OBJECT

public:
    explicit Dialog(QWidget *parent = 0);
    ~Dialog();

private slots:
    void on_pushButton_LightAllLed_clicked();

    void on_pushButton_UnlightAllLed_clicked();
    void ClickLED();
    void TimerHandle();
    void MoveVideo();



    void on_spinBox_hex0_valueChanged(int arg1);

    void on_spinBox_hex1_valueChanged(int arg1);

    void on_spinBox_hex2_valueChanged(int arg1);

    void on_spinBox_hex3_valueChanged(int arg1);

    void on_spinBox_hex4_valueChanged(int arg1);

    void on_spinBox_hex5_valueChanged(int arg1);

    void on_tabWidget_currentChanged(int index);

    void on_tone_c_clicked();

    void on_tone_d_clicked();

    void on_tone_e_clicked();

    void on_tone_f_clicked();

    void on_tone_g_clicked();

    void on_tone_a_clicked();

    void on_tone_b_clicked();

    void on_checkBox_LCD_Backlight_clicked();

    void on_comboBox_LcdDemo_currentIndexChanged(int index);

private:
    Ui::Dialog *ui;
    QTimer *timer;
    HPS *hps;
    FPGA *fpga;
    LCD_GRAPHIC *hps_lcd;
    HPS_AUDIO *hps_audio;

    // button
    bool m_bHPS_ButtonPressed;
    uint32_t m_FPGA_KeyStatus;
    uint32_t m_FPGA_SwitchStatus;

    // gsensor
    bool m_bGsensorDataValid;
    int16_t m_X, m_Y, m_Z;

    // ir
    u_int64_t m_ir_rx_timeout[24];

    // ui
    void UI_LedSet(bool AllOn);
    void GetHexResourceName(int nIndex, QString &name);


    // hardware
    void HW_SetLed();

    // tab polling and draw
    void TabButtonPolling(HPS *hps);
    void TabButtonDraw();
    void TabHexDraw();
    void TabGsensorPolling(HPS *hps);
    void TabGsensorDraw();
    void TabIrPolling(FPGA *fpga);
    void TabIrDraw();
    void TabAdcPolling(FPGA *fpga);
    void TabAdcDraw();

protected: //virtual function
    virtual bool eventFilter(QObject* watched, QEvent* event);
    virtual void moveEvent(QMoveEvent * event);
};

#endif // DIALOG_H
