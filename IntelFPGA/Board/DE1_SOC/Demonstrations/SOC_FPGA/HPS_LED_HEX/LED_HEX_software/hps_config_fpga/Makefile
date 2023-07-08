#

TARGET = hps_config_fpga

ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
RM	:=rm -rf
C_SRC := hsp_config_fpga.c 
OBJ := $(patsubst %.c,%.o,$(C_SRC))
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/
LDFLAGS =  -g -Wall 
CC = $(CROSS_COMPILE)gcc
ARCH= arm

	
build: $(TARGET)

$(TARGET): $(OBJ) 
	$(CC) $(LDFLAGS)   $^ -o $@ 
$(OBJ): %.o: %.c Makefile soc_system_dc.rbf
	$(CC) $(CFLAGS) -c $< -o $@
# With Data Compression
soc_system_dc.rbf: HPS_LED_HEX.sof
	$(RM) cpf_option.txt
	echo bitstream_compression=on > cpf_option.txt
	quartus_cpf -c -o cpf_option.txt $< $@
	$(RM) cpf_option.txt
.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~ *.rbf