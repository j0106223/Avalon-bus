//this program is target to load elf contain to instruction memory and data memory
//initialize memory by .hex which is converted from elf
#include <stdio.h>
#include <stdlib.h>
#include "../inc/cpu.h"
void ihex2mem(char *file_name, struct memory *rom,struct memory *ram){
    FILE *fp;
    int start_addr;
    int end_addr;
    char line_text[50];
    fp = fopen(file_name, "r");
    int ;
    while(fscanf(fp, "%s", line_text) != EOF){
        switch(line_text[7]){//record type
            case '0'://data
                
                break;
            case '1'://eof
                ;
                break;
            case '2'://Extended Segment Address
                ;
                break;
            case '3'://Start Segment Address
                ;
                break;
            case '4'://Extended Linear Address
                ;
                break;
            case '5'://Start Linear Address
                ;
                break;
        }
    }
    fclose(fp);
}
int hex2int(char *){
    int result = 0;;
    while(){

    }
    return 
}
void txt2mem(char *file_name, struct memory *rom){
    FILE *fp;
    fp = fopen(file_name,"r");
    int data;
    for(int i = 0; fscanf(fp,"%X", &data) != EOF; i++){
        rom->data[i] = data;//little endian check
    }
}
int check_memory_region(int load_addr, int load_bytes, struct memory *mem){
    if(load_addr >= mem->base && (load_addr + load_bytes) <= mem->base + mem->size){
        return 1;//hit
    }
    return 0;//fail
}