#include "dialog.h"
#include "ui_dialog.h"

#include <QtGui>
#include <QPainter>

Dialog::Dialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dialog),
    m_bHPS_ButtonPressed(false),
    m_FPGA_KeyStatus(0),
    m_FPGA_SwitchStatus(0)
{

    // hid help menu
    this->setWindowFlags(this->windowFlags() & ~Qt::WindowContextHelpButtonHint);

    ui->setupUi(this);
    ui->tabWidget->setCurrentIndex(0); // default to first page

    memset(m_ir_rx_timeout, 0, sizeof(m_ir_rx_timeout));
    // hps and fpga init
    hps = new HPS;
    fpga = new FPGA;

    // fix windows size
    this->setFixedSize(this->width(),this->height());

    // overwrite draw event: draw for child widget
    ui->tabGsensor->installEventFilter(this);
    ui->tabButton->installEventFilter(this);

    // create polling timer
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(TimerHandle()));
    timer->start(100);
}

Dialog::~Dialog()
{
    delete ui;
}

void Dialog::on_pushButton_LightAllLed_clicked()
{
    UI_LedSet(true);
    HW_SetLed();
}

void Dialog::on_pushButton_UnlightAllLed_clicked()
{
    UI_LedSet(false);
    HW_SetLed();
}

void Dialog::ClickLED(){
   // qDebug() << "HPS LED Checked:" << ((ui->checkBox_HPS_LED0->isChecked())?"Yes":"No") << "\r\n";
    HW_SetLed();
}



void Dialog::UI_LedSet(bool AllOn){
    ui->checkBox_HPS_LED0->setChecked(AllOn);
    ui->checkBox_LED0->setChecked(AllOn);
    ui->checkBox_LED1->setChecked(AllOn);
    ui->checkBox_LED2->setChecked(AllOn);
    ui->checkBox_LED3->setChecked(AllOn);
    ui->checkBox_LED4->setChecked(AllOn);
    ui->checkBox_LED5->setChecked(AllOn);
    ui->checkBox_LED6->setChecked(AllOn);
    ui->checkBox_LED7->setChecked(AllOn);
}

void Dialog::HW_SetLed(){
    //qDebug() << "HW_SetLed is called/r/n";
    hps->LedSet(ui->checkBox_HPS_LED0->isChecked());

    uint32_t ledMask = 0;
    QCheckBox *szCheck[] = {
        ui->checkBox_LED0,
        ui->checkBox_LED1,
        ui->checkBox_LED2,
        ui->checkBox_LED3,
        ui->checkBox_LED4,
        ui->checkBox_LED5,
        ui->checkBox_LED6,
        ui->checkBox_LED7,
    };

    for(int i=0;i<8;i++){
        if (szCheck[i]->isChecked())
            ledMask |= (0x01 << i);
    }

    fpga->LedSet(ledMask);
}


bool Dialog::eventFilter(QObject* watched, QEvent* event)
{
    if (watched == ui->tabButton && event->type() == QEvent::Paint) {
        TabButtonDraw();
        return true; // return true if you do not want to have the child widget paint on its own afterwards, otherwise, return false.

    }else if(watched == ui->tabGsensor && event->type() == QEvent::Paint) {
        TabGsensorDraw();
        return true;
    }
    return false;
}




void Dialog::TimerHandle(){
    QWidget *widgetCurrent = ui->tabWidget->currentWidget();

    if (widgetCurrent == ui->tabGsensor){
        TabGsensorPolling(hps);
        ui->tabGsensor->update();

    }else if (widgetCurrent == ui->tabButton){
        TabButtonPolling(hps);
        ui->tabButton->update();
    }
}
