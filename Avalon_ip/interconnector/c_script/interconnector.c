#include <stdio.h>
#include <stdlib.h>
//global clock reset



typedef struct component{
    char* ip;
    char* name;//component name
    int slave_amount;
    int master_amount;
    char* slave_name[10];
    char* master_name[10];
}component;
//slave create_slave();
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
    component temp;

    return 0;
}
void inst_RTL(component *inst){
    
    //ip name
    printf("%s ", inst->ip);
    //component instance name
    printf("%s", inst->name);
    //component master 
    for(int i = 0; i < inst->master_amount;i++){
        
    }
    for(int i = 0; i < inst->slave_amount; i++){

    }
    printf("{");
    printf(".address(%s_address),\n");
    printf(".read(%s_read),\n");
    printf(".write(%s_write),\n");
    printf(".readdata(%s_readdata),\n");
    printf(".writedata(%s_writedata),\n");
    printf(".waitrequest(%s_waitrequest)\n");
    printf("};");
}