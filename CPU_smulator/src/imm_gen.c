#include<stdio.h>
int imm_gen(int instr){
    int format;
    format = format_decode(instr);
    switch (format)
    {
    case 0://I
        return ;
        break;
    case 1://S
        return ;
        break;
    case 2://B
        return ;
        break;
    case 3://U
        return ;
        break;
    case 4://J
        return ;
        break;
    default:
        printf("imm format decode fail!!\n");
        exit(1);
        break;
    }
}
int format_decode(int instr){
    int opcode = instr & 0x7F;
    if(opcode == 0x13){
        return 0;//I
    }
    if(opcode == 0x23){
        return 1;//S
    } 
    if(opcode == 0x63){
        return 2;//B
    } 
    if((opcode == 0x37) || (opcode == 0x17)){
        return 3;//U
    } 
    if(opcode == 0x6F){
        return 4;//J
    }
    return 5;
}

