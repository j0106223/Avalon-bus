module eeprom (
    
);
    parameter PB = ;
    reg [7:0] mem [0:7];

    mem[x] = xxx;

    mem_page (
        clk,
        cs,
        byte_addr,
        rw,
        data_i,
        data_o
    );
endmodule