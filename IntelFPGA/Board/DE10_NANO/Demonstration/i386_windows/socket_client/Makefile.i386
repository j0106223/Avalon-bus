#
TARGET = socket_client

#
CFLAGS = -O3 -Wall
LDFLAGS = -O3 -Wall
CC = g++

build: $(TARGET)

$(TARGET): main.o
	$(CC) $(LDFLAGS) $^ -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o : %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~