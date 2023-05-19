#include "../inc/debug.h"
void show32bit(unsigned int data){
    int i;
    for(i = 0; i < 32; i++){  
        if(data & (1 << i)){
            printf("1");
        }else {
            printf("0");
        }   
    }
}
void showNbit(unsigned int data,int n){
    int i;
    for(i = 0; i < n; i++){
        if(data & (1 << i)){
            printf("1");
        }else {
            printf("0");
        }      
    }
}