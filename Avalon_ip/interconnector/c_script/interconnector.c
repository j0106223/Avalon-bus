#include <stdio.h>
#include <stdlib.h>
typedef struct component{
    char *slave_name;
    int source[20];//is a master stack
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