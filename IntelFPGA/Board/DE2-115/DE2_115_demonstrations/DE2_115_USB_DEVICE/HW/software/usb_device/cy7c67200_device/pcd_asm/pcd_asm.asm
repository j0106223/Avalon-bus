;*************************************************************************************************
;	Copyright (2004), Cypress Semiconductor Corporation
;
;	This software is owned by Cypress Semiconductor Corporation (Cypress) and is
;	protected by United States copyright laws and international treaty provisions. Cypress
;	hereby grants to Licensee a personal, non-exclusive, non-transferable license to copy,
;	use, modify, create derivative works of, and compile the Cypress Source Code and
;	derivative works for the sole purpose of creating custom software in support of Licensee
;	product ("Licensee Product") to be used only in conjunction with a Cypress integrated
;	circuit. Any reproduction, modification, translation, compilation, or representation of this
;	software except as specified above is prohibited without the express written permission of
;	Cypress.
;	Disclaimer: Cypress makes no warranty of any kind, express or implied, with regard to
;	this material, including, but not limited to, the implied warranties of merchantability and
;	fitness for a particular purpose. Cypress reserves the right to make changes without
;	further notice to the materials described herein. Cypress does not assume any liability
;	arising out of the application or use of any product or circuit described herein. Cypress?
;	products described herein are not authorized for use as components in life-support
;	devices.
;	This software is protected by and subject to worldwide patent coverage, including U.S.
;	and foreign patents. Use may be limited by and subject to the Cypress Software License
;	Agreement.
;
;	Module Name:
;	    	pcd_asm.asm
;
;	Created:
;	    	9/2/2003
;
;	Description:
;	     	This file implements the chapter 9 function from ez-host
;           generate code (pcd_asm.h) to download into 67200 interal ram -Dee
;   Source from :  WINCE ver 1.1 drivers for peripheral mode 
;                 http://www.cypress.com/?rID=14386    
;	Notes:
;
;*************************************************************************************************/

.xlist
	include 67300_05.inc
	include lcp_cmd.inc 
	include lcp_data.inc 
.list



;=============================================================
; For descritor
;=============================================================


;Descriptor Types
DEVICE					equ     0x01
CONFIGURATION   		equ		0x02
STRING          		equ		0x03
INTERFACE       		equ		0x04
ENDPOINT        		equ		0x05

EP0Len          		equ		64
EP1Len          		equ		64
EP2Len          		equ		64
EP3Len          		equ		64      	
EP4Len                  equ     64

;=============================================================
; For standard command and class command
;=============================================================
; Device Request Offsets
o_bmRequest				equ		0
o_bRequest				equ		1
o_wValue  				equ		2
o_wIndex  				equ		4
o_wLength 				equ		6

;Common memory for pass data between ez-host and external CPU
CLASS_COMMAND_ADDR		equ		0x1E0

;buffer for the SIE2 mailbox
mbx_msg2				equ     0x404

;Message for SIE mailbox
SUSB_CLASS_MSG			equ     0x2000	

SET_CONTROL_LINE_STATE 	equ 	0x22

;=============================================================
; USB variables
;=============================================================
EP_DATA1      			equ 	0x40
EP_STALL      			equ 	0x20
EP_ISO        			equ 	0x10
EP_DIR_IN     			equ 	0x04
EP_ENB        			equ 	0x02
EP_ARM        			equ 	0x01
EP_STICKY     			equ 	0x80
;=============================================================
; offset for DEVx_EPx_CTL_REG
;=============================================================
o_ctl         			equ 	0x00
o_base        			equ 	0x02
o_cnt         			equ 	0x04
o_status      			equ 	0x06
o_residue     			equ 	0x08
o_ep_len      			equ 	0x0a    	; contain endpoint payload
o_ep_link     			equ 	0x0c    	; link buffer for each endpoint, 0xe reserved

;=============================================================
; flag for o_status register
;=============================================================
STALL_FLG     			equ 	0x80
ERR_FLG       			equ 	2
ACK_FLG       			equ 	1
INV_DIR_FLG   			equ 	0x300
OVF_FLG       			equ 	0x20    	; overflow flag
UNF_FLG       			equ 	0x400   	; underflow flag


;=============================================================
; address in bios for functions and variables
;=============================================================
clr_int		  			equ 	0xf048
o_call_chain  			equ 	0x4e
o_mbx_msg	  			equ 	4
USB_finish_do 			equ 	0xf16c
bitm		  			equ 	0xf50e




IRAM 					equ 	0x3E00 ; Dee-> make sure (0x3fff - IRAM ) ram space is enough for the code
	org (IRAM-16)

	dw 0xc3b6
	dw 4
	db 0
	dw 0xe000
	dw 0

	dw 0xc3b6
	dw ((END - START) +2)
	db 0
	dw IRAM

	reloc IRAM


START:
	;replace the device and configuration descriptor
	mov 	[SUSB2_DEV_DESC_VEC], dev_desc
	mov 	[SUSB2_CONFIG_DESC_VEC], conf_desc
        mov     [SUSB2_STRING_DESC_VEC], str_desc   ; Dee Add string descirptor

	mov 	[(SUSB2_CLASS_INT*2)], sie2_class_int  ;install the SIE2 class command handler
	mov 	[(SUSB2_VENDOR_INT*2)], sie2_class_int  ;install the SIE2 vendor command handler

	; Load new ISR
	mov 	[SIE2_EP2_VEC], USB2_EP2_Isr

	mov     [USB2_CTL_REG], 0x380			; pull D+ and D- down
	; delay 1000 ms
	mov  	r1,1000                    ;10000							
mdelay1:									; 1 ms
  	mov 	r2, 6751
@@: dec  	r2                         		; take 148ns for each pass
  	jnz  	@b
	dec  	r1
	jnz  	mdelay1

	; start peripheral 
	mov 	r1, 0							;full speed
	mov 	r2, 2							;SIE2 to be peripheral
	int 	SUSB_INIT_INT	
	ret 


;=============================================================
; process class commands
;=============================================================
sie2_class_int:
	mov		r8, SIE2_DEV_REQ				; SIE2 setup buffer
	cmp		b[r8+o_bRequest], SET_CONTROL_LINE_STATE
	jne		@f
	mov     [CLASS_COMMAND_ADDR], [r8+o_wValue]
	or      [mbx_msg2], SUSB_CLASS_MSG		;write to SIE2 message mailbox
@@:	mov     r0, 0
	int 	SUSB2_FINISH_INT
	ret      



;=============================================================
; ISR for ep2 of usb1
;=============================================================

USB2_EP2_Isr:
	int   	HW_SWAP_REG
    mov   	r9,DEV2_EP2_CTL_REG
    call  	clr_int

ISR_common1:
    test  	r0,ERR_FLG
    jz    	@f
arm0: 
	or    	[r9],EP_ARM               		; if USB Error, retry again
iex2: 
	int   	HW_REST_REG                  	; restore all regs + sti + ret

@@: and   	r8,r8                     		; if o_ep_link=0, just do nothing
    jz    	iex2                      		; do nothing, should not happen
    mov   	r1,[r9+o_ep_len]          		; get current ep payload
	; r8-> o_ep_link->loc
    add   	[r8],r1                   		; update next address, r8->cnt
    mov   	r10,[r8++]                		; next address
    xor   	[r9],EP_DATA1             		; toggle DATA0/DATA1
	; check if require data copy
    cmp   	r10,XRAM_BEGIN            		; check if external ram, require copy
    jb    	skip_copy                	 	; if r10 < XRAM_BEGIN, skip copy
    cmp   	r10,IROM_BEGIN          
    jae   	skip_copy
    mov   	r12,[r9+o_base]           		; get temporary buffer
    mov   	r2,r1
    test  	[r9],EP_DIR_IN            		; check direction
    jz    	dcpy
    push  	r10
    mov   	r10,r12                   		; swap r10 and r12
    pop   	r12
    sub   	[r8],r1
    jnc   	@f
    add   	r2,[r8]                   		; get correct byte len
@@: add   	[r8],r1
dcpy: 
	inc   	r2                        		; align the word copy
    shr   	r2,1
    jz    	xsk0                      		; skip if zero length
@@: mov   	[r10++],[r12++]           		; copy all the data
    dec   	r2
    jnz   	@b
xsk0: 
	mov   	r10,[r9+o_base]           		; use ctl_buf 
skip_copy:
    and   	[r8],[r8]                 		; if len=0, check transfer done
    jz    	xfer_done0
    test  	r0,UNF_FLG                		; short package, then finish
    jnz   	xfer_done0

    sub   	[r8],r1
    jnc   	@f
    add   	r1,[r8]                   		; adjust the length
    xor   	[r8],[r8]                 		; clear len
@@:   
    mov   	[r9+o_base],r10           		; new base address
    mov   	[r9+o_cnt],r1             		; new length
    jmp   	arm0                      		; ready for next package
xfer_done0:
    add   	[r8],[r9+o_residue]       		; update the residue
xfer_done:
    mov   	[r9+o_ep_link],0          		; clear the link, r8->call back
    mov   	r0,[r8+2]                 		; submit to usb_idle task
    mov   	r8,r9                     		; extract endpoint info
    and   	r8,0x70                   		; just get the endpoint info
    shr   	r8,4
    or    	[r11+o_mbx_msg],b[r8+bitm] 		; Notify via Mailbox MSG
    and   	r0,r0                     		; if empty just return
    jz    	chk_ep0_done
    cmp   	[r11+o_call_chain],0      		; check this incase
    je    	@f
    call  	r0                        		; this should never happen, but incase
    int  	HW_REST_REG                		; restore all regs + sti + ret

@@: mov   	[r11+o_call_chain],r0     		; submit to usb_idle task
    int  	HW_REST_REG                		; restore all regs + sti + ret

chk_ep0_done:
    test  	r9,0x70                   		; only use for endpoint 0
    cz    	USB_finish_do             		; new feature for LYBERTY
    int  	HW_REST_REG                		; restore all regs + sti + ret


;=============================================================
; Descriptor
;=============================================================
align 2
dev_desc:
	db    	18           					; bLength
    db     	DEVICE             				; bDescriptorType
    dw  	0x0200              			; bcdUSB
    db  	0xff               				; bDeviceClass (0xFF = Vendor Specific)
    db		0xff               				; bDeviceSubClass
    db		0xff               				; bDeviceProtocol
    db		EP0Len             				; bMaxPacketSize0
    dw		0x09fb					; idVendor
    dw		0x0de2        					; idProduct
    dw      0x0               				; bcdDevice
    db		1                  				; iManufacturer - index of Manf String Descriptor
    db		1                  				; iProduct - index of Product String Descriptor
    db		1                  				; iSerialNumber - Index of Serial Number String
    db		1                  				; bNumConfigurations

conf_desc:
    db		9                  				; bLength
    db		CONFIGURATION      				; bDescriptorType
    dw		46     ;(9+9+7*4)  						; wTotalLength
    db		1                  				; bNumInterfaces
    db		1                  				; bConfigurationValue
    db		0                  				; iConfiguration
    db		0xc0               				; bmAttributes
    db		50                  			; MaxPower (x2 mA)

interface_desc:
    db		9                  				; bLength
    db		INTERFACE          				; bDescriptorType
    db		0                  				; bInterfaceNumber
    db		0                  				; bAlternateSetting
    db		4                  				; bNumEndpoints (number endpoints used, excluding EP0)
    db		0xff               				; bInterfaceClass
    db		0xff               				; bInterfaceSubClass
    db		0xff               				; bInterfaceProtocol
    db		0                  				; ilInterface  (Index of this interface string desc.)

;In endpoint
ep1: 	
    db		7                  				; bLength
    db		ENDPOINT           				; bDescriptorType
    db		0x81               				; bEndpointAddress (EP 1, IN)
    db		2                  				; bmAttributes  (0010 = Bulk)
    dw		EP1Len          				; wMaxPacketSize
    db		0                  				; bInterval (ignored for Bulk)

;Out endpoint
ep2: 	
    db		7                  				; bLength
    db		ENDPOINT           				; bDescriptorType
    db		0x02               				; bEndpointAddress (EP 2, Out)
    db		2                  				; bmAttributes  (0010 = Bulk)
    dw		EP2Len          				; wMaxPacketSize
    db		0                  				; bInterval (ignored for Bulk)
;In endpoint
ep3: 	;just for show how to add a endpoint  change  config_descriptor->wTotalLength  interface->bNumEndpoints
    db		7                  				; bLength
    db		ENDPOINT           				; bDescriptorType
    db		0x83               				; bEndpointAddress (EP 1, IN)
    db		2                  				; bmAttributes  (0010 = Bulk)
    dw		EP3Len          				; wMaxPacketSize
    db		0                  				; bInterval (ignored for Bulk)

;Out endpoint
ep4: 	;just for show how to add a endpoint  change  config_descriptor->wTotalLength  interface->bNumEndpoints
    db		7                  				; bLength
    db		ENDPOINT           				; bDescriptorType
    db		0x04               				; bEndpointAddress (EP 2, Out)
    db		2                  				; bmAttributes  (0010 = Bulk)
    dw		EP4Len          				; wMaxPacketSize
    db		0                  				; bInterval (ignored for Bulk)

align 2  ;Require the string must be align 2
;string descriptor
str_desc:
    db 4
    db 3
    dw 0x409 ; english language id
str1:
    db STR1_LEN
    db 3
    dw 'Terasic Technologies Inc.' ;Terasic EZO USB
   STR1_LEN equ ($-str1)

END:
