
#include "dialog.h"
#include "ui_dialog.h"
#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <QtGui>
#include <QPainter>
#include <QtCore>


void Dialog::TabButtonPolling(HPS *hps){
    uint32_t Status;

    m_bHPS_ButtonPressed = hps->IsButtonPressed();

    if (fpga->KeyRead(&Status))
        m_FPGA_KeyStatus = Status;

    if (fpga->SwitchRead(&Status))
        m_FPGA_SwitchStatus = Status;

}

void Dialog::TabButtonDraw(){
    int i, mask;
    QLabel *label_key[] = {ui->label_key0,ui->label_key1,ui->label_key2,ui->label_key3};
    QLabel *label_sw[] = {ui->label_sw0,ui->label_sw1,ui->label_sw2,ui->label_sw3,
                         ui->label_sw4,ui->label_sw5,ui->label_sw6,ui->label_sw7,
                         ui->label_sw8,ui->label_sw9};

    QPixmap pixmap;
    pixmap.load(m_bHPS_ButtonPressed?":/new/Myresource/SMALL_BUTTON_DOWN.bmp":":/new/Myresource/SMALL_BUTTON_UP.bmp" );
    ui->label_hps_key0->setPixmap( pixmap );

    // fpga key
    mask = 0x01;
    for(i=0;i<4;i++){
        // active-low
        pixmap.load((m_FPGA_KeyStatus & mask)?":/new/Myresource/BUTTON_UP.bmp":":/new/Myresource/BUTTON_DOWN.bmp" );
        label_key[i]->setPixmap( pixmap );
        mask <<= 1;

    }


    // fpga switch
    mask = 0x01;
    for(i=0;i<10;i++){
        pixmap.load((m_FPGA_SwitchStatus & mask)?":/new/Myresource/SW_up.bmp":":/new/Myresource/SW_down.bmp" );
        label_sw[i]->setPixmap( pixmap );
        mask <<= 1;

    }

}
