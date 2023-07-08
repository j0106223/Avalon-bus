#
TARGET = alsa_play

ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall -std=c++11  -D$(ALT_DEVICE_FAMILY) -I./alsa/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/ 
LDFLAGS =  -g -Wall -lstdc++ -L./alsa/library -lasound
#CC = $(CROSS_COMPILE)gcc
CC = $(CROSS_COMPILE)g++
ARCH= arm

build: $(TARGET)

$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@ 

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~