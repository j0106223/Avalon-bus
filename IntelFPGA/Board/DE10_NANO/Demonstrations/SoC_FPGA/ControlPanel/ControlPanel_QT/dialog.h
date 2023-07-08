#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QString>
#include "hps.h"
#include "fpga.h"

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

private:
    Ui::Dialog *ui;
    QTimer *timer;
    HPS *hps;
    FPGA *fpga;

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
    void TabGsensorPolling(HPS *hps);
    void TabGsensorDraw();

protected: //virtual function
    virtual bool eventFilter(QObject* watched, QEvent* event);
};

#endif // DIALOG_H
