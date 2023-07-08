using System;
using System.IO;
using System.Collections.Generic;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.Threading;
using CyUSB;
using System.Timers;


namespace Template
{
    public partial class Form1 : Form
    {
        USBDeviceList usbDevices;
        CyUSBDevice myDevice;

        CyUSBEndPoint curEndptOut;
        CyUSBEndPoint curEndpt;

        byte rled_byte0 = 0;
        byte rled_byte1 = 0;
        byte rled_byte2 = 0;
        byte gled_byte0 = 0;
        byte gled_byte1 = 0;

        byte seg_0 = 0;
        byte seg_1 = 0;
        byte seg_2 = 0;
        byte seg_3 = 0;
        byte seg_4 = 0;
        byte seg_5 = 0;
        byte seg_6 = 0;
        byte seg_7 = 0;

        System.Timers.Timer t = new System.Timers.Timer(500);
       

        public Form1()
        {
            InitializeComponent();

              t.Elapsed += new System.Timers.ElapsedEventHandler(ReceivingData);
              t.AutoReset = true;

            Form1.CheckForIllegalCrossThreadCalls = false;

            /* Connect Device */

            //   StatusLabel1.Text = "No Device Connected !";
            byte DeviceMask = 0;
            //Only CY device selected
            DeviceMask |= CyConst.DEVICES_CYUSB;
            //DeviceMask |=  CyConst.DEVICES_HID;

            usbDevices = new USBDeviceList(DeviceMask);


            usbDevices.DeviceAttached += new EventHandler(usbDevices_DeviceAttached);
            usbDevices.DeviceRemoved += new EventHandler(usbDevices_DeviceRemoved);

            myDevice = usbDevices[0] as CyUSBDevice;
            if (myDevice != null)
            {
                StatusLabel1.Text = myDevice.FriendlyName + " connected.";
                //if (USBControlPages.SelectedTab.Text == "LCD_SEG")
                //{
                //    SEG7_update();
               // }

               // if (USBControlPages.SelectedTab.Text == "LCD_SEG")
               // {
               //     LED_update();
               // }
                                
                curEndpt = myDevice.BulkOutEndPt;
                ALLEnabled();
                //rtxtDesInfo.Text = myDevice.ToString();
                curEndptOut = myDevice.BulkInEndPt;

                if (USBControlPages.SelectedTab.Text == "Button_Switch")
                {
                    if (curEndptOut != null)
                    {
                      t.Enabled = true;
                      while (!(t.Enabled))
                      {
                          t.Enabled = true;
                      }
                    }
                }
            }
            else
            {
                //ALLDisabled();
                //curEndptOut = null;
                StatusLabel1.Text = "No Device Connected.";
            }
        }

        /* Enable all buttons */
        private void ALLEnabled()
        {
            GLED0.Enabled = true;
            GLED1.Enabled = true;
            GLED2.Enabled = true;
            GLED3.Enabled = true;
            GLED4.Enabled = true;
            GLED5.Enabled = true;
            GLED6.Enabled = true;
            GLED7.Enabled = true;
            GLED8.Enabled = true;
            RLED0.Enabled = true;
            RLED1.Enabled = true;
            RLED2.Enabled = true;
            RLED3.Enabled = true;
            RLED4.Enabled = true;
            RLED5.Enabled = true;
            RLED6.Enabled = true;
            RLED7.Enabled = true;
            RLED8.Enabled = true;
            RLED9.Enabled = true;
            RLED10.Enabled = true;
            RLED11.Enabled = true;
            RLED12.Enabled = true;
            RLED13.Enabled = true;
            RLED14.Enabled = true;
            RLED15.Enabled = true;
            RLED16.Enabled = true;
            RLED17.Enabled = true;
            BUTTON0.Enabled = true;
            BUTTON1.Enabled = true;
            BUTTON2.Enabled = true;
            BUTTON3.Enabled = true;

            SW8.Enabled = true;
            SW7.Enabled = true;
            SW6.Enabled = true;
            SW5.Enabled = true;
            SW4.Enabled = true;
            SW3.Enabled = true;
            SW6.Enabled = true;
            SW7.Enabled = true;
            SW8.Enabled = true;
            SW9.Enabled = true;
            SW10.Enabled = true;
            SW11.Enabled = true;
            SW12.Enabled = true;
            SW13.Enabled = true;
            SW14.Enabled = true;
            SW15.Enabled = true;
            SW16.Enabled = true;
            SW17.Enabled = true;
            btnLCDClear.Enabled = true;
            btnLightAll.Enabled = true;
            btnUlightAll.Enabled = true;
            SEG0.Enabled = true;
            SEG1.Enabled = true;
            SEG2.Enabled = true;
            SEG3.Enabled = true;
            SEG4.Enabled = true;
            SEG5.Enabled = true;
            SEG6.Enabled = true;
            SEG7.Enabled = true;
            btnNUDSEGReset.Enabled = true;
            Button_Switch.Enabled = true;
            SEG0_A.Enabled = true;
            SEG1_A.Enabled = true;
            SEG2_A.Enabled = true;
            SEG3_A.Enabled = true;
            SEG4_A.Enabled = true;
            SEG5_A.Enabled = true;
            SEG6_A.Enabled = true;
            SEG7_A.Enabled = true;
            SEG0_M.Enabled = true;
            SEG1_M.Enabled = true;
            SEG2_M.Enabled = true;
            SEG3_M.Enabled = true;
            SEG4_M.Enabled = true;
            SEG5_M.Enabled = true;
            SEG6_M.Enabled = true;
            SEG7_M.Enabled = true;
            t.Enabled = false;
        }
        /* Enable all buttons */
        private void ALLDisabled()
        {
            GLED0.Enabled = false;
            GLED1.Enabled = false;
            GLED2.Enabled = false;
            GLED3.Enabled = false;
            GLED4.Enabled = false;
            GLED5.Enabled = false;
            GLED6.Enabled = false;
            GLED7.Enabled = false;
            GLED8.Enabled = false;
            RLED0.Enabled = false;
            RLED1.Enabled = false;
            RLED2.Enabled = false;
            RLED3.Enabled = false;
            RLED4.Enabled = false;
            RLED5.Enabled = false;
            RLED6.Enabled = false;
            RLED7.Enabled = false;
            RLED8.Enabled = false;
            RLED9.Enabled = false;
            RLED10.Enabled = false;
            RLED11.Enabled = false;
            RLED12.Enabled = false;
            RLED13.Enabled = false;
            RLED14.Enabled = false;
            RLED15.Enabled = false;
            RLED16.Enabled = false;
            RLED17.Enabled = false;
            BUTTON0.Enabled = false;
            BUTTON1.Enabled = false;
            BUTTON2.Enabled = false;
            BUTTON3.Enabled = false;

            SW0.Enabled = false;
            SW1.Enabled = false;
            SW2.Enabled = false;
            SW3.Enabled = false;
            SW4.Enabled = false;
            SW5.Enabled = false;
            SW6.Enabled = false;
            SW7.Enabled = false;
            SW8.Enabled = false;
            SW9.Enabled = false;
            SW10.Enabled = false;
            SW11.Enabled = false;
            SW12.Enabled = false;
            SW13.Enabled = false;
            SW14.Enabled = false;
            SW15.Enabled = false;
            SW16.Enabled = false;
            SW17.Enabled = false;
            btnLCDClear.Enabled = false;
            btnLightAll.Enabled = false;
            btnUlightAll.Enabled = false;
            SEG0.Enabled = false;
            SEG1.Enabled = false;
            SEG2.Enabled = false;
            SEG3.Enabled = false;
            SEG4.Enabled = false;
            SEG5.Enabled = false;
            SEG6.Enabled = false;
            SEG7.Enabled = false;
            SEG0_A.Enabled = false;
            SEG1_A.Enabled = false;
            SEG2_A.Enabled = false;
            SEG3_A.Enabled = false;
            SEG4_A.Enabled = false;
            SEG5_A.Enabled = false;
            SEG6_A.Enabled = false;
            SEG7_A.Enabled = false;
            SEG0_M.Enabled = false;
            SEG1_M.Enabled = false;
            SEG2_M.Enabled = false;
            SEG3_M.Enabled = false;
            SEG4_M.Enabled = false;
            SEG5_M.Enabled = false;
            SEG6_M.Enabled = false;
            SEG7_M.Enabled = false;
            Button_Switch.Enabled = false;
            t.Enabled = false;
            curEndptOut = null;
            curEndpt = null;
            btnNUDSEGReset.Enabled = false;
        }
        /*Summary
         This is the event handler for Device removal 
        */
        void usbDevices_DeviceRemoved(object sender, EventArgs e)
        {
            USBEventArgs usbEvent = e as USBEventArgs;

            StatusLabel1.Text = usbEvent.FriendlyName + " removed.";
            
            ALLDisabled();
        }


        /*Summary
         This is the event handler for Device attachment
        */
        void usbDevices_DeviceAttached(object sender, EventArgs e)
        {
            USBEventArgs usbEvent = e as USBEventArgs;

            //StatusLabel1.Text = usbEvent.Device.FriendlyName + " connected.";

            byte DeviceMask = 0;
            //Only CY device selected
            DeviceMask |= CyConst.DEVICES_CYUSB;
            //DeviceMask |=  CyConst.DEVICES_HID;

            usbDevices = new USBDeviceList(DeviceMask);


            usbDevices.DeviceAttached += new EventHandler(usbDevices_DeviceAttached);
            usbDevices.DeviceRemoved += new EventHandler(usbDevices_DeviceRemoved);

            myDevice = usbDevices[0] as CyUSBDevice;
            if (myDevice != null)
            {
                StatusLabel1.Text = myDevice.FriendlyName + " connected.";
                if (USBControlPages.SelectedTab.Text == "LCD_SEG")
                {
                    if (curEndpt != null)
                    {
                        SEG7_update();
                    }
                    
                    
                }

                if (USBControlPages.SelectedTab.Text == "LED")
                {
                    if (curEndpt != null)
                    {
                        LED_update();
                    }
                   
                }
                curEndpt = myDevice.BulkOutEndPt;
                ALLEnabled();
                curEndptOut = myDevice.BulkInEndPt;

                if (USBControlPages.SelectedTab.Text == "Button_Switch")
                {
                    t.Enabled = true;
                    while (!(t.Enabled))
                    {
                        t.Enabled = true;
                    }
                }

            }
            else
            {
                
                //curEndptOut = null;
                //ALLDisabled();
                StatusLabel1.Text = "No Device Connected.";
            }
        }

          /*Summary
        Executes on closing the form. This method in turn calls the dispose() method to dispose or clear all the resources allocated.
         */
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {

            t.Enabled = false;
            while (t.Enabled)
            {
                t.Enabled = false;
            }
            if (usbDevices != null)
                {
                    if (curEndptOut != null)
                    curEndptOut.Abort();
                    usbDevices.Dispose();

                }
           
        }

 

      

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Copyright (c) Terasic 2012", Text);
        }

        private void connectDeviceToolStripMenuItem_Click(object sender, EventArgs e)
        {

            byte DeviceMask = 0;
            //Only CY device selected
            DeviceMask |= CyConst.DEVICES_CYUSB;
            //DeviceMask |=  CyConst.DEVICES_HID;

            usbDevices = new USBDeviceList(DeviceMask);


            usbDevices.DeviceAttached += new EventHandler(usbDevices_DeviceAttached);
            usbDevices.DeviceRemoved += new EventHandler(usbDevices_DeviceRemoved);

            myDevice = usbDevices[0] as CyUSBDevice;
            if (myDevice != null)
            {
                StatusLabel1.Text = myDevice.FriendlyName + " connected.";
                curEndpt = myDevice.BulkOutEndPt;
                ALLEnabled();
                //rtxtDesInfo.Text = myDevice.ToString();
                curEndptOut = myDevice.BulkInEndPt;

                if (USBControlPages.SelectedTab.Text == "Button_Switch")
                {
                    t.Enabled = true;
                }
            }
            else
            {
                StatusLabel1.Text = "No Device Connected.";
            }

        }

        private void disConnectDeviceToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ALLDisabled();
            StatusLabel1.Text = "No Device Connected.";
            //rtxtDesInfo.Text = " ";
        }
/////////////////////////////////////////////////////////////////////////////
        
        
        
        ///////////////////////////////////////////////
        //                  LCD & SEG
        ///////////////////////////////////////////////
       
        // LCD

        private void txtLCDUp_TextChanged(object sender, EventArgs e)
        {
            
            if (curEndpt == null)
            {
                MessageBox.Show("No Device Connected !");
                return;
            }

            int len = 16;
            int lenTotal = 34;
            char[] LCD_Up = txtLCDUp.Text.ToCharArray();
            char[] LCD_Down = txtLCDDown.Text.ToCharArray();

            byte[] LCD = new byte[lenTotal];
            LCD[0] = 0x02;
            LCD[1] = 0x00;
            for (int i = 0; i < len; i++)
            {
                if (i < LCD_Up.Length)
                    LCD[i + 2] = Convert.ToByte(LCD_Up[i]);
                else
                    LCD[i + 2] = 0x20;
            }
            for (int i = 0; i < len; i++)
            {
                if (i < LCD_Down.Length)
                    LCD[i + len + 2] = Convert.ToByte(LCD_Down[i]);
                else
                    LCD[i + len + 2] = 0x20;
            }

            curEndpt.XferData(ref LCD, ref lenTotal);
        }

        private void txtLCDDown_TextChanged(object sender, EventArgs e)
        {
            if (curEndpt == null)
            {
                MessageBox.Show("No Device Connected !");
                return;
            }

            int len = 16;
            int lenTotal = 34;
            char[] LCD_Up = txtLCDUp.Text.ToCharArray();
            char[] LCD_Down = txtLCDDown.Text.ToCharArray();

            byte[] LCD = new byte[lenTotal];
            LCD[0] = 0x02;
            LCD[1] = 0x00;
            for (int i = 0; i < len; i++)
            {
                if (i < LCD_Up.Length)
                    LCD[i + 2] = Convert.ToByte(LCD_Up[i]);
                else
                    LCD[i + 2] = 0x20;
            }
            for (int i = 0; i < len; i++)
            {
                if (i < LCD_Down.Length)
                    LCD[i + len + 2] = Convert.ToByte(LCD_Down[i]);
                else
                    LCD[i + len + 2] = 0x20;
            }

            curEndpt.XferData(ref LCD, ref lenTotal);
        }


        private void btnLCDClear_Click(object sender, EventArgs e)
        {
            if (curEndpt == null)
            {
                MessageBox.Show("No Device Connected !");
                return;
            }
            txtLCDUp.Text = "";
            txtLCDDown.Text = "";
            int len = 34;
            byte[] LCD = new byte[len];
            for (int i = 0; i < len; i++)
            {
                if (i == 0)
                    LCD[0] = 0x02;
                else if (i == 1)
                    LCD[1] = 0x00;
                else
                    LCD[i] = 0x20;
            }
            curEndpt.XferData(ref LCD, ref len);
        }

        // SEG

        private void SEG7_update()
        {
            if (curEndpt == null)
            {
                MessageBox.Show("No Device Connected !");
                return;
            }

            SEG0.Image = back_7SEG_pic(seg_0);
            SEG1.Image = back_7SEG_pic(seg_1);
            SEG2.Image = back_7SEG_pic(seg_2);
            SEG3.Image = back_7SEG_pic(seg_3);
            SEG4.Image = back_7SEG_pic(seg_4);
            SEG5.Image = back_7SEG_pic(seg_5);
            SEG6.Image = back_7SEG_pic(seg_6);
            SEG7.Image = back_7SEG_pic(seg_7);

            if (seg_0 == 0x00)
            {
                SEG0_M.Image = Template.Properties.Resources.left_btn_1;
                SEG0_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_0 == 0x0F)
            {
                SEG0_M.Image = Template.Properties.Resources.left_btn;
                SEG0_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG0_M.Image = Template.Properties.Resources.left_btn;
                SEG0_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_1 == 0x00)
            {
                SEG1_M.Image = Template.Properties.Resources.left_btn_1;
                SEG1_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_1 == 0x0F)
            {
                SEG1_M.Image = Template.Properties.Resources.left_btn;
                SEG1_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG1_M.Image = Template.Properties.Resources.left_btn;
                SEG1_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_2 == 0x00)
            {
                SEG2_M.Image = Template.Properties.Resources.left_btn_1;
                SEG2_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_2 == 0x0F)
            {
                SEG2_M.Image = Template.Properties.Resources.left_btn;
                SEG2_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG2_M.Image = Template.Properties.Resources.left_btn;
                SEG2_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_3 == 0x00)
            {
                SEG3_M.Image = Template.Properties.Resources.left_btn_1;
                SEG3_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_3 == 0x0F)
            {
                SEG3_M.Image = Template.Properties.Resources.left_btn;
                SEG3_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG3_M.Image = Template.Properties.Resources.left_btn;
                SEG3_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_4 == 0x00)
            {
                SEG4_M.Image = Template.Properties.Resources.left_btn_1;
                SEG4_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_4 == 0x0F)
            {
                SEG4_M.Image = Template.Properties.Resources.left_btn;
                SEG4_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG4_M.Image = Template.Properties.Resources.left_btn;
                SEG4_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_5 == 0x00)
            {
                SEG5_M.Image = Template.Properties.Resources.left_btn_1;
                SEG5_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_5 == 0x0F)
            {
                SEG5_M.Image = Template.Properties.Resources.left_btn;
                SEG5_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG5_M.Image = Template.Properties.Resources.left_btn;
                SEG5_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_6 == 0x00)
            {
                SEG6_M.Image = Template.Properties.Resources.left_btn_1;
                SEG6_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_6 == 0x0F)
            {
                SEG6_M.Image = Template.Properties.Resources.left_btn;
                SEG6_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG6_M.Image = Template.Properties.Resources.left_btn;
                SEG6_A.Image = Template.Properties.Resources.right_btn;
            }

            if (seg_7 == 0x00)
            {
                SEG7_M.Image = Template.Properties.Resources.left_btn_1;
                SEG7_A.Image = Template.Properties.Resources.right_btn;
            }
            else if (seg_7 == 0x0F)
            {
                SEG7_M.Image = Template.Properties.Resources.left_btn;
                SEG7_A.Image = Template.Properties.Resources.right_btn_1;
            }
            else
            {
                SEG7_M.Image = Template.Properties.Resources.left_btn;
                SEG7_A.Image = Template.Properties.Resources.right_btn;
            }

            byte seg_byte0 = Convert.ToByte(seg_1 * 16 + seg_0);
            byte seg_byte1 = Convert.ToByte(seg_3 * 16 + seg_2);
            byte seg_byte2 = Convert.ToByte(seg_5 * 16 + seg_4);
            byte seg_byte3 = Convert.ToByte(seg_7 * 16 + seg_6);

            int len = 6;
            byte[] Segment = new byte[len];
            Segment[0] = 0x03;
            Segment[1] = 0x00;
            Segment[2] = seg_byte0;
            Segment[3] = seg_byte1;
            Segment[4] = seg_byte2;
            Segment[5] = seg_byte3;
            curEndpt.XferData(ref Segment, ref len);



        }

        private System.Drawing.Bitmap back_7SEG_pic(byte a)
        {
            switch (a)
            {
                case 0x0: return (Template.Properties.Resources.HEX_0);
                case 0x1: return (Template.Properties.Resources.HEX_1);
                case 0x2: return (Template.Properties.Resources.HEX_2);
                case 0x3: return (Template.Properties.Resources.HEX_3);
                case 0x4: return (Template.Properties.Resources.HEX_4);
                case 0x5: return (Template.Properties.Resources.HEX_5);
                case 0x6: return (Template.Properties.Resources.HEX_6);
                case 0x7: return (Template.Properties.Resources.HEX_7);
                case 0x8: return (Template.Properties.Resources.HEX_8);
                case 0x9: return (Template.Properties.Resources.HEX_9);
                case 0xa: return (Template.Properties.Resources.HEX_a);
                case 0xb: return (Template.Properties.Resources.HEX_b);
                case 0xc: return (Template.Properties.Resources.HEX_c);
                case 0xd: return (Template.Properties.Resources.HEX_d);
                case 0xe: return (Template.Properties.Resources.HEX_e);
                case 0xf: return (Template.Properties.Resources.HEX_f);
                default: return (Template.Properties.Resources.HEX_0);
            }
        }




        private void btnNUDSEGReset_Click(object sender, EventArgs e)
        {
            seg_0 = 0;
            seg_1 = 0;
            seg_2 = 0;
            seg_3 = 0;
            seg_4 = 0;
            seg_5 = 0;
            seg_6 = 0;
            seg_7 = 0;
            SEG7_update();
        }

        private void SEG0_A_Click(object sender, EventArgs e)
        {

            if (seg_0 < 0x0f)
            {
                // SEG0_A.Image = Template.Properties.Resources.right_btn_1;
                seg_0++;
                SEG7_update();
                //  SEG0_A.Image = Template.Properties.Resources.right_btn;
            }


        }

        private void SEG0_M_Click(object sender, EventArgs e)
        {
            if (seg_0 > 0x00)
            {
                seg_0--;
                SEG7_update();
            }
        }

        private void SEG1_A_Click(object sender, EventArgs e)
        {
            if (seg_1 < 0x0f)
            {
                seg_1++;
                SEG7_update();
            }
        }
        private void SEG1_M_Click(object sender, EventArgs e)
        {
            if (seg_1 > 0x00)
            {
                seg_1--;
                SEG7_update();
            }
        }
        private void SEG2_A_Click(object sender, EventArgs e)
        {
            if (seg_2 < 0x0f)
            {
                seg_2++;
                SEG7_update();
            }
        }

        private void SEG2_M_Click(object sender, EventArgs e)
        {
            if (seg_2 > 0x00)
            {
                seg_2--;
                SEG7_update();
            }
        }
        private void SEG3_A_Click(object sender, EventArgs e)
        {
            if (seg_3 < 0x0f)
            {
                seg_3++;
                SEG7_update();
            }
        }

        private void SEG3_M_Click(object sender, EventArgs e)
        {
            if (seg_3 > 0x00)
            {
                seg_3--;
                SEG7_update();
            }
        }
        private void SEG4_A_Click(object sender, EventArgs e)
        {
            if (seg_4 < 0x0f)
            {
                seg_4++;
                SEG7_update();
            }
        }

        private void SEG4_M_Click(object sender, EventArgs e)
        {
            if (seg_4 > 0x00)
            {
                seg_4--;
                SEG7_update();
            }
        }
        private void SEG5_A_Click(object sender, EventArgs e)
        {
            if (seg_5 < 0x0f)
            {
                seg_5++;
                SEG7_update();
            }
        }

        private void SEG5_M_Click(object sender, EventArgs e)
        {
            if (seg_5 > 0x00)
            {
                seg_5--;
                SEG7_update();
            }
        }
        private void SEG6_A_Click(object sender, EventArgs e)
        {
            if (seg_6 < 0x0f)
            {
                seg_6++;
                SEG7_update();
            }
        }

        private void SEG6_M_Click(object sender, EventArgs e)
        {
            if (seg_6 > 0x00)
            {
                seg_6--;
                SEG7_update();
            }
        }


        private void SEG7_M_Click(object sender, EventArgs e)
        {
            if (seg_7 > 0x00)
            {
                seg_7--;
                SEG7_update();
            }
        }

        private void SEG7_A_Click(object sender, EventArgs e)
        {
            if (seg_7 < 0x0f)
            {
                seg_7++;
                SEG7_update();
            }
        }


        ///////////////////////////////////////////
        //                 LED
        ///////////////////////////////////////////
        private void LED_update()
        {

            if ((rled_byte0 & 0x01) == 0x01)
                RLED0.Image = Template.Properties.Resources.RLED_on;
            else
                RLED0.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte0 & 0x02) == 0x02)
                RLED1.Image = Template.Properties.Resources.RLED_on;
            else
                RLED1.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte0 & 0x04) == 0x04)
                RLED2.Image = Template.Properties.Resources.RLED_on;
            else
                RLED2.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte0 & 0x08) == 0x08)
                RLED3.Image = Template.Properties.Resources.RLED_on;
            else
                RLED3.Image = Template.Properties.Resources.LED_off;

            if ((rled_byte0 & 0x10) == 0x10)
                RLED4.Image = Template.Properties.Resources.RLED_on;
            else
                RLED4.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte0 & 0x20) == 0x20)
                RLED5.Image = Template.Properties.Resources.RLED_on;
            else
                RLED5.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte0 & 0x40) == 0x40)
                RLED6.Image = Template.Properties.Resources.RLED_on;
            else
                RLED6.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte0 & 0x80) == 0x80)
                RLED7.Image = Template.Properties.Resources.RLED_on;
            else
                RLED7.Image = Template.Properties.Resources.LED_off;

            if ((rled_byte1 & 0x01) == 0x01)
                RLED8.Image = Template.Properties.Resources.RLED_on;
            else
                RLED8.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte1 & 0x02) == 0x02)
                RLED9.Image = Template.Properties.Resources.RLED_on;
            else
                RLED9.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte1 & 0x04) == 0x04)
                RLED10.Image = Template.Properties.Resources.RLED_on;
            else
                RLED10.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte1 & 0x08) == 0x08)
                RLED11.Image = Template.Properties.Resources.RLED_on;
            else
                RLED11.Image = Template.Properties.Resources.LED_off;

            if ((rled_byte1 & 0x10) == 0x10)
                RLED12.Image = Template.Properties.Resources.RLED_on;
            else
                RLED12.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte1 & 0x20) == 0x20)
                RLED13.Image = Template.Properties.Resources.RLED_on;
            else
                RLED13.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte1 & 0x40) == 0x40)
                RLED14.Image = Template.Properties.Resources.RLED_on;
            else
                RLED14.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte1 & 0x80) == 0x80)
                RLED15.Image = Template.Properties.Resources.RLED_on;
            else
                RLED15.Image = Template.Properties.Resources.LED_off;

            if ((rled_byte2 & 0x01) == 0x01)
                RLED16.Image = Template.Properties.Resources.RLED_on;
            else
                RLED16.Image = Template.Properties.Resources.LED_off;
            if ((rled_byte2 & 0x02) == 0x02)
                RLED17.Image = Template.Properties.Resources.RLED_on;
            else
                RLED17.Image = Template.Properties.Resources.LED_off;


            if ((gled_byte0 & 0x01) == 0x01)
                GLED0.Image = Template.Properties.Resources.GLED_on;
            else
                GLED0.Image = Template.Properties.Resources.LED_off;
            if ((gled_byte0 & 0x02) == 0x02)
                GLED1.Image = Template.Properties.Resources.GLED_on;
            else
                GLED1.Image = Template.Properties.Resources.LED_off;
            if ((gled_byte0 & 0x04) == 0x04)
                GLED2.Image = Template.Properties.Resources.GLED_on;
            else
                GLED2.Image = Template.Properties.Resources.LED_off;
            if ((gled_byte0 & 0x08) == 0x08)
                GLED3.Image = Template.Properties.Resources.GLED_on;
            else
                GLED3.Image = Template.Properties.Resources.LED_off;

            if ((gled_byte0 & 0x10) == 0x10)
                GLED4.Image = Template.Properties.Resources.GLED_on;
            else
                GLED4.Image = Template.Properties.Resources.LED_off;
            if ((gled_byte0 & 0x20) == 0x20)
                GLED5.Image = Template.Properties.Resources.GLED_on;
            else
                GLED5.Image = Template.Properties.Resources.LED_off;
            if ((gled_byte0 & 0x40) == 0x40)
                GLED6.Image = Template.Properties.Resources.GLED_on;
            else
                GLED6.Image = Template.Properties.Resources.LED_off;
            if ((gled_byte0 & 0x80) == 0x80)
                GLED7.Image = Template.Properties.Resources.GLED_on;
            else
                GLED7.Image = Template.Properties.Resources.LED_off;

            if ((gled_byte1 & 0x01) == 0x01)
                GLED8.Image = Template.Properties.Resources.GLED_on;
            else
                GLED8.Image = Template.Properties.Resources.LED_off;

            // update to FPGA
            if (curEndpt == null)
            {
                MessageBox.Show("No Device Connected !");
                return;
            }
            int len = 9;
            byte[] buf = { 0x01, 0x00, gled_byte0, gled_byte1, 0x00, 0x00, rled_byte0, rled_byte1, rled_byte2 };
            curEndpt.XferData(ref buf, ref len);

        }

        private void RLED17_Click(object sender, EventArgs e)
        {
            if ((rled_byte2 & 0x02) == 0x02)
            {
                rled_byte2 &= 0xfD;
            }
            else
            {
                rled_byte2 |= 0x02;
            }

            LED_update();
        }

        private void RLED16_Click(object sender, EventArgs e)
        {
            if ((rled_byte2 & 0x01) == 0x01)
            {
                rled_byte2 &= 0xfe;
            }
            else
            {
                rled_byte2 |= 0x01;
            }

            LED_update();
        }

        private void RLED15_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x80) == 0x80)
            {
                rled_byte1 &= 0x7f;
            }
            else
            {
                rled_byte1 |= 0x80;
            }

            LED_update();
        }

        private void RLED14_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x40) == 0x40)
            {
                rled_byte1 &= 0xBf;
            }
            else
            {
                rled_byte1 |= 0x40;
            }

            LED_update();
        }

        private void RLED13_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x20) == 0x20)
            {
                rled_byte1 &= 0xDf;
            }
            else
            {
                rled_byte1 |= 0x20;
            }

            LED_update();
        }

        private void RLED12_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x10) == 0x10)
            {
                rled_byte1 &= 0xef;
            }
            else
            {
                rled_byte1 |= 0x10;
            }

            LED_update();
        }

        private void RLED11_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x08) == 0x08)
            {
                rled_byte1 &= 0xf7;
            }
            else
            {
                rled_byte1 |= 0x08;
            }

            LED_update();
        }

        private void RLED10_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x04) == 0x04)
            {
                rled_byte1 &= 0xfB;
            }
            else
            {
                rled_byte1 |= 0x04;
            }

            LED_update();
        }

        private void RLED9_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x02) == 0x02)
            {
                rled_byte1 &= 0xfD;
            }
            else
            {
                rled_byte1 |= 0x02;
            }

            LED_update();
        }

        private void RLED8_Click(object sender, EventArgs e)
        {
            if ((rled_byte1 & 0x01) == 0x01)
            {
                rled_byte1 &= 0xfe;
            }
            else
            {
                rled_byte1 |= 0x01;
            }

            LED_update();
        }
        private void RLED7_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x80) == 0x80)
            {
                rled_byte0 &= 0x7f;
            }
            else
            {
                rled_byte0 |= 0x80;
            }

            LED_update();
        }

        private void RLED6_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x40) == 0x40)
            {
                rled_byte0 &= 0xBf;
            }
            else
            {
                rled_byte0 |= 0x40;
            }

            LED_update();
        }

        private void RLED5_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x20) == 0x20)
            {
                rled_byte0 &= 0xDf;
            }
            else
            {
                rled_byte0 |= 0x20;
            }

            LED_update();
        }

        private void RLED4_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x10) == 0x10)
            {
                rled_byte0 &= 0xef;
            }
            else
            {
                rled_byte0 |= 0x10;
            }

            LED_update();
        }

        private void RLED3_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x08) == 0x08)
            {
                rled_byte0 &= 0xf7;
            }
            else
            {
                rled_byte0 |= 0x08;
            }

            LED_update();
        }

        private void RLED2_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x04) == 0x04)
            {
                rled_byte0 &= 0xfB;
            }
            else
            {
                rled_byte0 |= 0x04;
            }

            LED_update();
        }

        private void RLED1_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x02) == 0x02)
            {
                rled_byte0 &= 0xfD;
            }
            else
            {
                rled_byte0 |= 0x02;
            }

            LED_update();
        }

        private void RLED0_Click(object sender, EventArgs e)
        {
            if ((rled_byte0 & 0x01) == 0x01)
            {
                rled_byte0 &= 0xfe;
            }
            else
            {
                rled_byte0 |= 0x01;
            }

            LED_update();
        }

        private void GLED8_Click(object sender, EventArgs e)
        {
            if ((gled_byte1 & 0x01) == 0x01)
            {
                gled_byte1 &= 0xfe;
            }
            else
            {
                gled_byte1 |= 0x01;
            }

            LED_update();
        }


        private void GLED7_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x80) == 0x80)
            {
                gled_byte0 &= 0x7f;
            }
            else
            {
                gled_byte0 |= 0x80;
            }

            LED_update();
        }

        private void GLED6_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x40) == 0x40)
            {
                gled_byte0 &= 0xBf;
            }
            else
            {
                gled_byte0 |= 0x40;
            }

            LED_update();
        }

        private void GLED5_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x20) == 0x20)
            {
                gled_byte0 &= 0xDf;
            }
            else
            {
                gled_byte0 |= 0x20;
            }

            LED_update();
        }

        private void GLED4_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x10) == 0x10)
            {
                gled_byte0 &= 0xef;
            }
            else
            {
                gled_byte0 |= 0x10;
            }

            LED_update();
        }

        private void GLED3_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x08) == 0x08)
            {
                gled_byte0 &= 0xf7;
            }
            else
            {
                gled_byte0 |= 0x08;
            }

            LED_update();
        }

        private void GLED2_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x04) == 0x04)
            {
                gled_byte0 &= 0xfB;
            }
            else
            {
                gled_byte0 |= 0x04;
            }

            LED_update();
        }

        private void GLED1_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x02) == 0x02)
            {
                gled_byte0 &= 0xfD;
            }
            else
            {
                gled_byte0 |= 0x02;
            }

            LED_update();
        }

        private void GLED0_Click(object sender, EventArgs e)
        {
            if ((gled_byte0 & 0x01) == 0x01)
            {
                gled_byte0 &= 0xfe;
            }
            else
            {
                gled_byte0 |= 0x01;
            }

            LED_update();
        }

        private void btnLightAll_Click(object sender, EventArgs e)
        {
            rled_byte0 = 0xff;
            rled_byte1 = 0xff;
            rled_byte2 = 0x03;
            gled_byte0 = 0xff;
            gled_byte1 = 0x01;

            LED_update();

        }

        private void btnUlightAll_Click(object sender, EventArgs e)
        {
            rled_byte0 = 0x0;
            rled_byte1 = 0x0;
            rled_byte2 = 0x0;
            gled_byte0 = 0x0;
            gled_byte1 = 0x0;

            LED_update();
        }

        /////////////////////////////////////
        // Button Switch
        /////////////////////////////////////


        private void Tab_Changed(object sender, EventArgs e)
        {

            if (USBControlPages.SelectedTab.Text == "LCD_SEG")
            {
                if (curEndptOut == null)
                {
                    MessageBox.Show("No Device Connected !");
                    return;
                }
                if (curEndpt != null)
                {
                    SEG7_update();
                }
                t.Enabled = false;
                while (t.Enabled)
                {
                    t.Enabled = false;
                }
                if (curEndptOut != null)
                curEndptOut.Abort();
            }
            else
                if (USBControlPages.SelectedTab.Text == "LED")
            {
                if (curEndptOut == null)
                {
                    MessageBox.Show("No Device Connected !");
                    return;
                }
                if (curEndpt != null)
                {
                    LED_update();
                }
                t.Enabled = false;
                while (t.Enabled)
                {
                    t.Enabled = false;
                }
                if (curEndptOut != null)
                curEndptOut.Abort();
            }
            else
            if (USBControlPages.SelectedTab.Text == "Button_Switch")
            {
                if (curEndptOut == null)
                {
                    MessageBox.Show("No Device Connected !");
                    return;
                }
                t.Enabled = true;
                if (curEndptOut != null)
                curEndptOut.Reset();
                while (!(t.Enabled))
                {
                    t.Enabled = true;
                }

            }
            else
            {
                t.Enabled = false;
                while (t.Enabled)
                {
                    t.Enabled = false;
                }
                if (curEndptOut != null)
                curEndptOut.Abort();

            }

        }

        private void ReceivingData(object source, System.Timers.ElapsedEventArgs e)
        {

            if (USBControlPages.SelectedTab.Text == "Button_Switch")
            {
                    t.Enabled = true;
            }

            
          if(t.Enabled == true ){
            if (curEndptOut == null)
            {
                MessageBox.Show("No Device Connected !");
                return;
            }

            int bytes = 8;
            byte[] buffer = new byte[bytes];
            bool bXferCompleted = false;
            bool IsPkt = false;
            // char [] button_sw_value;
            // button_sw_value = (char *) buffer;

            //BuildDataCaption();
            //  ReceiveBox.Text += dataCaption;
            //  ReceiveBox.SelectionStart = OutputBox.Text.Length;
            //  ReceiveBox.ScrollToCaret();

            if (curEndptOut != null)
            {
                bXferCompleted = curEndptOut.XferData(ref buffer, ref bytes, IsPkt);


            }

            if (bXferCompleted)
            {


            }
            else
            {
                curEndptOut.Reset();// if not a complete 8 byte ,Reset
            }

            if (bXferCompleted)
            {
                // DisplayReferData(buffer, bytes, bXferCompleted);
                //BUTTON0
                if ((buffer[0] & 0x01) == 0x01)
                    BUTTON0.Image = Template.Properties.Resources.BUTTON_UP;
                else
                    BUTTON0.Image = Template.Properties.Resources.BUTTON_DOWN;
                //BUTTON1
                if ((buffer[0] & 0x02) == 0x02)
                    BUTTON1.Image = Template.Properties.Resources.BUTTON_UP;
                else
                    BUTTON1.Image = Template.Properties.Resources.BUTTON_DOWN;
                //BUTTON2
                if ((buffer[0] & 0x04) == 0x04)
                    BUTTON2.Image = Template.Properties.Resources.BUTTON_UP;
                else
                    BUTTON2.Image = Template.Properties.Resources.BUTTON_DOWN;
                //BUTTON3
                if ((buffer[0] & 0x08) == 0x08)
                    BUTTON3.Image = Template.Properties.Resources.BUTTON_UP;
                else
                    BUTTON3.Image = Template.Properties.Resources.BUTTON_DOWN;

                //SW0
                if ((buffer[4] & 0x01) == 0x01)
                    SW0.Image = Template.Properties.Resources.SW_up;
                else
                    SW0.Image = Template.Properties.Resources.SW_down;

                //SW1
                if ((buffer[4] & 0x02) == 0x02)
                    SW1.Image = Template.Properties.Resources.SW_up;
                else
                    SW1.Image = Template.Properties.Resources.SW_down;

                //SW2
                if ((buffer[4] & 0x04) == 0x04)
                    SW2.Image = Template.Properties.Resources.SW_up;
                else
                    SW2.Image = Template.Properties.Resources.SW_down;

                //SW3
                if ((buffer[4] & 0x08) == 0x08)
                    SW3.Image = Template.Properties.Resources.SW_up;
                else
                    SW3.Image = Template.Properties.Resources.SW_down;


                //SW4
                if ((buffer[4] & 0x10) == 0x10)
                    SW4.Image = Template.Properties.Resources.SW_up;
                else
                    SW4.Image = Template.Properties.Resources.SW_down;

                //SW5
                if ((buffer[4] & 0x20) == 0x20)
                    SW5.Image = Template.Properties.Resources.SW_up;
                else
                    SW5.Image = Template.Properties.Resources.SW_down;

                //SW6
                if ((buffer[4] & 0x40) == 0x40)
                    SW6.Image = Template.Properties.Resources.SW_up;
                else
                    SW6.Image = Template.Properties.Resources.SW_down;

                //SW7
                if ((buffer[4] & 0x80) == 0x80)
                    SW7.Image = Template.Properties.Resources.SW_up;
                else
                    SW7.Image = Template.Properties.Resources.SW_down;

                //SW8
                if ((buffer[5] & 0x01) == 0x01)
                    SW8.Image = Template.Properties.Resources.SW_up;
                else
                    SW8.Image = Template.Properties.Resources.SW_down;

                //SW9
                if ((buffer[5] & 0x02) == 0x02)
                    SW9.Image = Template.Properties.Resources.SW_up;
                else
                    SW9.Image = Template.Properties.Resources.SW_down;

                //SW10
                if ((buffer[5] & 0x04) == 0x04)
                    SW10.Image = Template.Properties.Resources.SW_up;
                else
                    SW10.Image = Template.Properties.Resources.SW_down;

                //SW11
                if ((buffer[5] & 0x08) == 0x08)
                    SW11.Image = Template.Properties.Resources.SW_up;
                else
                    SW11.Image = Template.Properties.Resources.SW_down;

                //SW12
                if ((buffer[5] & 0x10) == 0x10)
                    SW12.Image = Template.Properties.Resources.SW_up;
                else
                    SW12.Image = Template.Properties.Resources.SW_down;

                //SW13
                if ((buffer[5] & 0x20) == 0x20)
                    SW13.Image = Template.Properties.Resources.SW_up;
                else
                    SW13.Image = Template.Properties.Resources.SW_down;

                //SW14
                if ((buffer[5] & 0x40) == 0x40)
                    SW14.Image = Template.Properties.Resources.SW_up;
                else
                    SW14.Image = Template.Properties.Resources.SW_down;

                //SW15
                if ((buffer[5] & 0x80) == 0x80)
                    SW15.Image = Template.Properties.Resources.SW_up;
                else
                    SW15.Image = Template.Properties.Resources.SW_down;

                //SW16
                if ((buffer[6] & 0x01) == 0x01)
                    SW16.Image = Template.Properties.Resources.SW_up;
                else
                    SW16.Image = Template.Properties.Resources.SW_down;

                //SW17
                if ((buffer[6] & 0x02) == 0x02)
                    SW17.Image = Template.Properties.Resources.SW_up;
                else
                    SW17.Image = Template.Properties.Resources.SW_down;


            }
            }
     
        }
         
    }

}