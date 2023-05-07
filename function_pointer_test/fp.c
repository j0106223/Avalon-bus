#include <stdio.h>
#include <stdlib.h>
struct fp
{
    /* data */
    void (*show1)(void);
    void (*show2)(void);
};

int main(void){
    printf("hello world!!\n");
    return 0;
}

void print1