#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting Binary File: C:\Users\Administrator\Desktop\CD_ROM\DE2-115_V.1.0.6_SystemCD\DE2-115_V.1.0.6_SystemCD\DE2_115_demonstrations\DE2_115_Web_Server\DE2_115_WEB_SERVER_MII_ENET0\software\web_server_0_syslib\ro_zipfs.zip to: "..\flash/ro.flashfs_cfi_flash.flash"
#
nios2eds/bin/bin2flash --input="C:/Users/Administrator/Desktop/CD_ROM/DE2-115_V.1.0.6_SystemCD/DE2-115_V.1.0.6_SystemCD/DE2_115_demonstrations/DE2_115_Web_Server/DE2_115_WEB_SERVER_MII_ENET0/software/web_server_0_syslib/ro_zipfs.zip" --output="../flash/ro.flashfs_cfi_flash.flash" --location=0x100000 

#
# Programming File: "..\flash/ro.flashfs_cfi_flash.flash" To Device: cfi_flash
#
nios2eds/bin/nios2-flash-programmer "../flash/ro.flashfs_cfi_flash.flash" --base=0x9000000 --sidp=0xB000140 --id=0x0 --timestamp=1353045137 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

