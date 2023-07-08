#include "dialog.h"
#include "ui_dialog.h"
#include <stdio.h>
#include <QPainter>
#include <QtCore>


// QRect: http://qt-project.org/doc/qt-5.0/qtcore/qrect.html
// QPoint: http://qt-project.org/doc/qt-5.0/qtcore/qpoint.html





void Dialog::TabGsensorPolling(HPS *hps){
    int16_t X,Y,Z;
    m_bGsensorDataValid = hps->GsensorQuery(&X, &Y, &Z);
    //m_bGsensorDataValid = 1;
    //X = 0;
    //Y = 0;
    //Z = 1000;

    if (m_bGsensorDataValid){
        char szText[64];
        sprintf(szText, "X=%d mg\r\n", X);

        ui->label_X->setText(szText);

        sprintf(szText, "Y=%d mg\r\n", Y);
        ui->label_Y->setText(szText);

        sprintf(szText, "Z=%d mg\r\n", Z);
        ui->label_Z->setText(szText);

        //
        m_X = X;
        m_Y = Y;
        m_Z = Z;

      //  ui->tabGsensor->update();

    }else{
        ui->label_X->setText("X=NA");
        ui->label_Y->setText("Y=NA");
        ui->label_Z->setText("Z=NA");
    }
}

void Dialog::TabGsensorDraw(){
    QPainter painter;
    QRect rc = ui->tabGsensor->rect();
    const int dy = 20;
    const int dx = (rc.width()-rc.height())/2+dy;
    const int BubbleSize = 30;

    rc.adjust(dx, dy, -dx, -dy);
    rc.translate(ui->tabGsensor->rect().right() - rc.right() - dy, 0);

    // draw
    painter.begin(ui->tabGsensor);

    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setPen(QPen(Qt::black, 2, Qt::DashDotLine, Qt::RoundCap));
    painter.setBrush(QBrush(Qt::lightGray, Qt::SolidPattern));
    painter.drawEllipse(rc);

    // cross- line
    painter.setPen(QPen(Qt::gray, 1, Qt::DotLine, Qt::RoundCap));
    painter.drawLine(rc.left(), rc.center().y(), rc.right(), rc.center().y());
    painter.drawLine(rc.center().x(), rc.top(), rc.center().x(), rc.bottom());

    if (m_bGsensorDataValid){

        // calculate bubble position
        QPoint ptOffset;

        ptOffset.setX((int)((float)(rc.width()-BubbleSize)*(float)-m_X/2000.0));
        ptOffset.setY((int)((float)(rc.height()-BubbleSize)*(float)m_Y/2000.0));
        //

        // draw bubble
        QRect rcBubble(rc.center().x(), rc.center().y(), 0, 0);
        rcBubble.adjust(-BubbleSize/2, -BubbleSize/2, BubbleSize/2, BubbleSize/2);
        rcBubble.translate(ptOffset.x(), ptOffset.y());
        painter.setPen(QPen(Qt::black, 1, Qt::SolidLine, Qt::RoundCap));
        painter.setBrush(QBrush(Qt::green, Qt::SolidPattern));
        painter.drawEllipse(rcBubble);



    }

    painter.end();
}

