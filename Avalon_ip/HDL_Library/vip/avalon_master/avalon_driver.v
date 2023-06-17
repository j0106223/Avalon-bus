module avalon_driver (
    address,
    read,
    write,
    readdata,
    writedata,
    waitrequest,
    valid,
    ready
);
    output address;
    output read;
    output write;
    input readdata;
    output writedata;
    input waitrequest;
    input valid;
    output ready;
    task m_write(input [AW-1:0]addr, input [DW-1:0]value);
        begin
            address = addr;
            writedata = value;
            @(posedge clk);
                #5 write = 1;
            @(negedge waitrequest);
            @(posedge clk);
            #5 write = 0;
            @(posedge clk);
        end
    endtask

    task m_read(input [AW-1:0]addr);
        begin
            @(posedge clk);
            #5;
            address = addr;
            read = 1;
            @(negedge waitrequest);
            @(posedge clk);
            #5 read = 0;
            @(posedge clk);
        end
    endtask
endmodule

