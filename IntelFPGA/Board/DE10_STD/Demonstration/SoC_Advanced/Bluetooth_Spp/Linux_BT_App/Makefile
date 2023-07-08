#
TARGET = BT_LED_AP

#
ALT_DEVICE_FAMILY ?= soc_cv_av

HWLIBS_ROOT = $(SOCEDS_DEST_ROOT)/ip/altera/hps/altera_hps/hwlib

CROSS_COMPILE = arm-linux-gnueabihf-
#CFLAGS = -g -Wall -static -std=gnu++11 -I ${SOCEDS_DEST_ROOT}/ip/altera/hps/altera_hps/hwlib/include -I./bt/inc
CFLAGS = -g -Wall -std=c++11 -I$(HWLIBS_ROOT)/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY) -I./bt/inc
LDFLAGS =  -g -Wall  -lstdc++ -L./bt/lib -lbluetooth -lrt -lpthread
#CC = $(CROSS_COMPILE)gcc
CC = $(CROSS_COMPILE)g++
ARCH= arm

all: $(TARGET)

$(TARGET): Main.o terasic_os.o mmap.o BtSppCommand.o BtSpp.o  Queue.o QueueCommand.o PIO_LED.o PIO_BUTTON.o
	$(CC) $(LDFLAGS)   $^ -o $@

%.o : %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~
