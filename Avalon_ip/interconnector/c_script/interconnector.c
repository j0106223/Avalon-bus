#include <stdio.h>
#include <stdlib.h>
typedef struct component{
    int role;//master or slave
    char *name;
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