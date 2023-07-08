#include "dialog.h"
#include "ui_dialog.h"
#include <stdio.h>
#include <QPainter>
#include <QtCore>
//#include <stdio.h>
#include <sys/time.h>
//#include <unistd.h>
#include "fpga.h"


#define DISP_DUR        3000
#define BUTTON_CNT      24


static
u_int64_t GetTickCount(){
    u_int64_t lGetTickCount;
    timeval ts;

    gettimeofday(&ts,0);
    lGetTickCount = (u_int64_t)(ts.tv_sec * 1000 + (ts.tv_usec / 1000));

    return lGetTickCount;
}


void Dialog::TabIrPolling(FPGA *fpga){
    const int nMaxCnt = 10;
    int cnt = 0, i;
    bool bDone = false;
    u_int32_t scancode;
    u_int8_t id;
    bool bFind;

    u_int8_t szMap[] = {
        0x0F, // 0
        0x13, // 1
        0x10, // 2
        0x12, // 3

        0x01, // 4
        0x02, // 5
        0x03, // 6
        0x1A, // 7

        0x04, // 8
        0x05, // 9
        0x06, // A
        0x1E, // B

        0x07, // C
        0x08, // D
        0x09, // E
        0x1B, // F

        0x11, // 10
        0x00, // 11
        0x17, // 12
        0x1F, // 13

        0x16, // 14
        0x14, // 15
        0x18, // 16
        0x0C
    };

    //qDebug() << "IR Polling";

    do{
        if (cnt++ < nMaxCnt && fpga->IrIsDataReady()){
            //qDebug() << "IR data ready";

            if (fpga->IrDataRead(&scancode)){
                id = (scancode >> 16 ) & 0xFF;

                //qDebug() << "id:" << id << "\r\n";

                bFind = false;
                for(i=0;i<(int)(sizeof(szMap)/sizeof(szMap[0])) && !bFind;i++){
                    if (szMap[i] == id){
                        bFind = true;
                        m_ir_rx_timeout[i] = GetTickCount() + DISP_DUR; // 3 scond
                    }

                }

            }else{
                bDone = true;
            }
        }else{
            bDone = true;
        }

    }while(!bDone);


}

void Dialog::TabIrDraw(){
    u_int64_t currentTime = GetTickCount();



    QPixmap pixmap;
    pixmap.load(":/new/Myresource/IR_RX.bmp");
    // pixmap.fill(QColor("transparent"));


    QPainter painter(&pixmap);

    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setBrush(QBrush(Qt::lightGray, Qt::NoBrush));

    for(int i=0;i<BUTTON_CNT;i++){
        if (currentTime < m_ir_rx_timeout[i]){
            int nPenSize;
            nPenSize = (m_ir_rx_timeout[i] - currentTime)*6/DISP_DUR;
            if (nPenSize > 5)
                nPenSize = 5;

            // draw
            QRect rc(0,0,10,10);
            rc.translate(14 + (i%4)*19, 12 + i/4*20);

            painter.setPen(QPen(Qt::green, nPenSize, Qt::SolidLine, Qt::RoundCap));
            painter.drawEllipse(rc);
            //
            //m_ir_rx_count_down[i] --;
        }
    }



    ui->label_ir_controller->setPixmap(pixmap);

    return;
}

