//SoC instance will auto gen by script or program written in C lang
module RV32I_SoC (
    clk,//on-board Crystal-Oscillator normally 50MHz
    reset_n,//on-board button
    //DRAM or SDRAM DDR1,2,3
    //FLASH
    //I2C_0
    //I2C_1
    //I2S
    //SPI_0
    //SPI_1
    //UART_0
    //UART_1
    //PS2_Keyboard
    //PS2_Mouse
    //VGA
    //SD Card native interface
    //GPIO
);
    input clk;
    input reset_n;

    //SoC instance
    /*
    RV32I_SoC inst{
        .clk    (CLOCK_50),
        .reset_n(BUTTON[0]),
        .
        .
        .
        .
        .
    };
    */
endmodule