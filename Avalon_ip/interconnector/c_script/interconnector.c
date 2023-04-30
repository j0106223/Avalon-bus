#include <stdio.h>
#include <stdlib.h>
//global clock reset



typedef struct component{
    char* name;//component name
    int slave_amount;
    int master_amount;
    char* slave_name[10];
    char* master_name[10];
}component;
slave create_slave();
void connector(slave);
int main(void){
    FILE *fp;
    printf("interconnecting...\n");
    if((fp = fopen("soc.arch","r")) == NULL){
        printf("soc.arch file doesn't exist\n");
        exit(1);
    }
    char *clk_name = "clk";
    char *reset_name = "reset_n";

    return 0;
}
void inst_RTL(){
    
    //ip name
    printf("%s");
    //component name
    printf("%s");
    //component wire
    printf("{");
    printf(".address(%s_address),\n");
    printf(".read(%s_read),\n");
    printf(".write(%s_write),\n");
    printf(".readdata(%s_readdata),\n");
    printf(".writedata(%s_writedata),\n");
    printf(".waitrequest(%s_waitrequest)\n");
    printf("};");
}