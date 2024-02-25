CC = riscv64-unknown-elf-gcc
DUMP = riscv64-unknown-elf-objdump
dump.txt:a.elf
	$(DUMP) -D a.elf > dump.txt
a.elf:main.c start.s linker.ld
	$(CC) -mabi=ilp32 -march=rv32i -o a.elf start.s main.c -nostartfiles -Wl,-Bstatic,-T,linker.ld,--strip-debug