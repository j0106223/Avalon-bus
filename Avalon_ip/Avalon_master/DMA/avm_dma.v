module avm_dma (
    clk,
    reset_n,
    //master port ->source
    avs_m0_address,
    avs_m0_read,
    avs_m0_write,
    avs_m0_waitrequest,
    avs_m0_readdata,
    avs_m0_writedata
    //master port ->destination  
    avs_m1_address,
    avs_m1_read,
    avs_m1_write,
    avs_m1_waitrequest,
    avs_m1_readdata,
    avs_m1_writedata
    //slave port
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_waitrequest,
    avs_s0_readdata,
    avs_s0_writedata
);
    
endmodule