#include "dialog.h"
#include "ui_dialog.h"

#include <QtGui>
#include <QPainter>
#include "hps_lcd/lcd_wcg12864_driver.h"

Dialog::Dialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dialog),
    m_bHPS_ButtonPressed(false),
    m_FPGA_KeyStatus(0),
    m_FPGA_SwitchStatus(0)
{

     // hps and fpga init
    hps = new HPS;
    fpga = new FPGA;
    hps_lcd = new LCD_GRAPHIC;
    hps_audio = new HPS_AUDIO;

    if (!hps_lcd->Init()){
        printf("Failed to Init LCD\r\n");
    }else{
        printf("success to init LCD\r\n");
        hps_lcd->Backlight(false);
        hps_lcd->Demo();
    }


    // hid help menu
    this->setWindowFlags(this->windowFlags() & ~Qt::WindowContextHelpButtonHint);
    ui->setupUi(this);
    ui->tabWidget->setCurrentIndex(0); // default to first page

    memset(m_ir_rx_timeout, 0, sizeof(m_ir_rx_timeout));


    // fix windows size
    this->setFixedSize(this->width(),this->height());

    // lcd demo combo box
    ui->comboBox_LcdDemo->addItem("Geometry & Font");
    ui->comboBox_LcdDemo->addItem("Checkerboard");
    ui->comboBox_LcdDemo->addItem("Full White");
    ui->comboBox_LcdDemo->addItem("Full Black");

    // overwrite draw event: draw for child widget
    ui->tabGsensor->installEventFilter(this);
    //ui->tabADC->installEventFilter(this);
    ui->tabButton->installEventFilter(this);
    ui->tabHEX->installEventFilter(this);
    ui->tabIR->installEventFilter(this);
    ui->tabAudio->installEventFilter(this);

  //  ui->tabWidget->setCurrentIndex(0); // default to first page

    // create polling timer
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(TimerHandle()));
    timer->start(100);
}

Dialog::~Dialog()
{
    fpga->VideoEnable(false); //always close video-in
    delete ui;

    delete hps;
    delete fpga;
    delete hps_lcd;
    delete hps_audio;

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
    ui->checkBox_LED8->setChecked(AllOn);
    ui->checkBox_LED9->setChecked(AllOn);
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
        ui->checkBox_LED8,
        ui->checkBox_LED9,


    };

    for(int i=0;i<10;i++){
        if (szCheck[i]->isChecked())
            ledMask |= (0x01 << i);
    }

    fpga->LedSet(ledMask);


}


bool Dialog::eventFilter(QObject* watched, QEvent* event)
{
    //static int x = 0;
    if (watched == ui->tabButton && event->type() == QEvent::Paint) {
        TabButtonDraw();
        return true; // return true if you do not want to have the child widget paint on its own afterwards, otherwise, return false.

    }else if(watched == ui->tabGsensor && event->type() == QEvent::Paint) {
        TabGsensorDraw();
        return true;
    }else if(watched == ui->tabHEX && event->type() == QEvent::Paint) {
        TabHexDraw();
        return true;
    //}else if(watched == ui->tabADC && event->type() == QEvent::Paint) {
     //   TabAdcDraw();
       // return true;
    }else if(watched == ui->tabIR && event->type() == QEvent::Paint) {
        TabIrDraw();
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


    }else if (widgetCurrent == ui->tabIR){
        TabIrPolling(fpga);
        ui->tabIR->update();

   //}else if (widgetCurrent == ui->tabADC){
          //  TabAdcPolling(fpga);
          //  ui->tabADC->update();
    }
}


void Dialog::on_spinBox_hex0_valueChanged(int arg1)
{
    ui->tabHEX->update();
    fpga->HexSet(0, ui->spinBox_hex0->value());
}

void Dialog::on_spinBox_hex1_valueChanged(int arg1)
{
    ui->tabHEX->update();
    fpga->HexSet(1, ui->spinBox_hex1->value());
}

void Dialog::on_spinBox_hex2_valueChanged(int arg1)
{
    ui->tabHEX->update();
    fpga->HexSet(2, ui->spinBox_hex2->value());
}

void Dialog::on_spinBox_hex3_valueChanged(int arg1)
{
    ui->tabHEX->update();
    fpga->HexSet(3, ui->spinBox_hex3->value());
}

void Dialog::on_spinBox_hex4_valueChanged(int arg1)
{
    ui->tabHEX->update();
    fpga->HexSet(4, ui->spinBox_hex4->value());
}

void Dialog::on_spinBox_hex5_valueChanged(int arg1)
{
    ui->tabHEX->update();
    fpga->HexSet(5, ui->spinBox_hex5->value());
}



void Dialog::moveEvent(QMoveEvent * event){
    MoveVideo();
}

void Dialog::MoveVideo(){

    if (ui->tabWidget->currentWidget() != ui->tabVideoIn)
        return;

    if (!fpga->IsVideoEnabled())
        return;

    QPoint ptScreen;
    QPoint pt(ui->tabVideoIn->rect().left()+90, ui->tabVideoIn->rect().top()+10);
    ptScreen = ui->tabVideoIn->mapToGlobal(pt);
    fpga->VideoMove(ptScreen.x(),ptScreen.y());
}

void Dialog::on_tabWidget_currentChanged(int index)
{
    if (ui->tabWidget->currentWidget() == ui->tabVideoIn){
        fpga->VideoEnable(true);
        MoveVideo();
    }else{
        fpga->VideoEnable(false);
    }

}

void Dialog::on_tone_c_clicked()
{
    //fpga->PlayTone(FPGA::TONE_C);
    hps_audio->PlayTone(HPS_AUDIO::TONE_C);
}

void Dialog::on_tone_d_clicked()
{
    //fpga->PlayTone(FPGA::TONE_D);
    hps_audio->PlayTone(HPS_AUDIO::TONE_D);
}

void Dialog::on_tone_e_clicked()
{
    //fpga->PlayTone(FPGA::TONE_E);
    hps_audio->PlayTone(HPS_AUDIO::TONE_E);
}

void Dialog::on_tone_f_clicked()
{
    //fpga->PlayTone(FPGA::TONE_F);
    hps_audio->PlayTone(HPS_AUDIO::TONE_F);
}

void Dialog::on_tone_g_clicked()
{
    //fpga->PlayTone(FPGA::TONE_G);
    hps_audio->PlayTone(HPS_AUDIO::TONE_G);
}

void Dialog::on_tone_a_clicked()
{
    //fpga->PlayTone(FPGA::TONE_A);
    hps_audio->PlayTone(HPS_AUDIO::TONE_A);
}

void Dialog::on_tone_b_clicked()
{
    //fpga->PlayTone(FPGA::TONE_B);
    hps_audio->PlayTone(HPS_AUDIO::TONE_B);
}

void Dialog::on_checkBox_LCD_Backlight_clicked()
{
    bool bOn;
    bOn = ui->checkBox_LCD_Backlight->isChecked();
    hps_lcd->Backlight(bOn);
}

void Dialog::on_comboBox_LcdDemo_currentIndexChanged(int index)
{
    if (index == 0){
        ui->label_lcd_demo_image->setPixmap(QPixmap(":/new/Myresource/LCD_hello.png"));
        hps_lcd->Demo();
    }else if (index == 1){
        ui->label_lcd_demo_image->setPixmap(QPixmap(":/new/Myresource/LCD_checkerboard.png"));
        hps_lcd->Demo_Checkerboard(5);
    }else if (index == 2){
        ui->label_lcd_demo_image->setPixmap(QPixmap(":/new/Myresource/LCD_white.png"));
        hps_lcd->Fill(0x00);
    }else if (index == 3){
        ui->label_lcd_demo_image->setPixmap(QPixmap(":/new/Myresource/LCD_black.png"));
        hps_lcd->Fill(0xFF);
    }
}
