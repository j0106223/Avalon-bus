
#include "dialog.h"
#include "ui_dialog.h"
#include <stdio.h>
#include <QPainter>
#include <QtCore>


void Dialog::GetHexResourceName(int nIndex, QString &name){
    switch(nIndex){
    case 0: name = ":/new/Myresource/HEX_0.bmp"; break;
    case 1: name = ":/new/Myresource/HEX_1.bmp"; break;
    case 2: name = ":/new/Myresource/HEX_2.bmp"; break;
    case 3: name = ":/new/Myresource/HEX_3.bmp"; break;
    case 4: name = ":/new/Myresource/HEX_4.bmp"; break;
    case 5: name = ":/new/Myresource/HEX_5.bmp"; break;
    case 6: name = ":/new/Myresource/HEX_6.bmp"; break;
    case 7: name = ":/new/Myresource/HEX_7.bmp"; break;
    case 8: name = ":/new/Myresource/HEX_8.bmp"; break;
    case 9: name = ":/new/Myresource/HEX_9.bmp"; break;
    }
}



void Dialog::TabHexDraw(){
    int i;
    QLabel *lable[]={ui->label_hex0, ui->label_hex1, ui->label_hex2, ui->label_hex3, ui->label_hex4, ui->label_hex5};
    QSpinBox *spin[]={ui->spinBox_hex0, ui->spinBox_hex1, ui->spinBox_hex2, ui->spinBox_hex3, ui->spinBox_hex4, ui->spinBox_hex5};
    QString name;
    QPixmap pixmap;

    for(i=0;i<(int)(sizeof(lable)/sizeof(lable[0]));i++){
        GetHexResourceName(spin[i]->value(), name);

        pixmap.load(name);
        lable[i]->setPixmap(pixmap);
    }
}

