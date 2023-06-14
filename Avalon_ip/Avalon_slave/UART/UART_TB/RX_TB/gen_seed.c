#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main(void){
    FILE *fp;
    int seed = time(0);
    printf("C gen seed = %d\n", seed);
    fp = fopen("date.txt","w");
    fprintf(fp,"%d",seed);
    fclose(fp);
    return 0;
}