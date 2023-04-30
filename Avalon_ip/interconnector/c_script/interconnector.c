#include <stdio.h>
#include <stdlib.h>
//global clock reset

char *clk_name = "clk";
char *reset_name = "reset_n";

typedef struct component{
    int role;//master or slave
    char *ip_name;
    char *inst_name;
    int slave_
    char *slave_name;
    master source[20];//is a master stack
}slave;
slave create_slave();
void connector(slave);
int main(void){
    FILE *fp;
    printf("interconnecting...\n");
    if((fp = fopen("soc.arch","r")) == NULL){
        printf("soc.arch file doesn't exist\n");
        exit(1);
    }
    return 0;
}
void inst_RTL(){
    printf("%s");
    //ip name
    //component name


}