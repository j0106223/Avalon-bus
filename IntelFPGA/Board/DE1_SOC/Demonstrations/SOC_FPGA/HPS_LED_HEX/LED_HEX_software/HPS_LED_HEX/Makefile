#
TARGET = HPS_LED_HEX

#
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall   -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/
LDFLAGS =  -g -Wall 
CC = $(CROSS_COMPILE)gcc
ARCH= arm
#LDFLAGS =  -g -Wall  -Iteraisc_pcie_qsys.so -ldl
#-ldl must be placed after the file calling lpxxxx funciton


build: $(TARGET)
#-lmpeg2 --> link libmpeg2.a (lib___.a)
$(TARGET): main.o seg7.o led.o
	$(CC) $(LDFLAGS)   $^ -o $@  -lpthread -lrt
#	$(CC) $(LDFLAGS)  $^ -o $@  -ldl -lmpeg2  -lmpeg2convert -lpthread
%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~ 
