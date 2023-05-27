module sram (
    
);
    parameter AW = 32;
    parameter DW = 32;
    parameter LC = 1;//latency,0,1,2

    input           clk;
    input           reset_n;
    input           cs;
    input     [3:0] we;
    input           addr;
    input  [DW-1:0] wdata;
    output [DW-1:0] rdata;

    reg [DW-1:0] mem [0:AW-1];
    //write
    always @(posedge clk or negedge reset_n) begin
        if(cs && (|we))begin
            mem[addr] <= wdata; 
        end
    end

    //read
    generate
        if(LC == 0)begin
            assign rdata = mem[addr];
        end
        else if(LC == 1) begin
            reg [DW-1:0]data;
            always @(posedge clk or negedge reset_n) begin
                if(!reset_n)begin
                    data <= 0;
                end else begin
                    if(cs && (~|we))begin
                        data <= mem[addr];
                    end
                end
            end
            assign rdata = data;
        end else begin//LC == 2
            reg [DW-1:0]data[0:1];
            always @(posedge clk or negedge reset_n) begin
                if(!reset_n)begin
                    data <= 0;
                end else begin
                    if(cs && (~|we))begin
                        data[0] <= mem[addr];
                        data[1] <= data[0];
                    end
                end
            end
            assign rdata = data[1];
        end
    endgenerate
endmodule