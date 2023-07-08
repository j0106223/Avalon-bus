#
TARGET = NET_Time

#
ALT_DEVICE_FAMILY ?= soc_cv_av

HWLIBS_ROOT = $(SOCEDS_DEST_ROOT)/ip/altera/hps/altera_hps/hwlib

CFLAGS = -g -Wall -Werror -I$(HWLIBS_ROOT)/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -Iinc -D$(ALT_DEVICE_FAMILY)
LDFLAGS = -g -Wall -Werror -ldl

CROSS_COMPILE = arm-linux-gnueabihf-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc
ARCH = arm

.PHONY: build
build: $(TARGET)

$(TARGET): main.o dl_curl.o
	$(LD) $(LDFLAGS)   $^ -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~

.PHONY: all
all: build
