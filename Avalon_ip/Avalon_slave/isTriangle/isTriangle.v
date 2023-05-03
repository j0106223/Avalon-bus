`default_nettype none
module isTriangle (
    clk,
    reset_n,
    address,
    read,
    write,
    writedata,
    waitrequest,
    readdata
);
    parameter pipeline_enable = 0;
    input   clk;
    input   reset_n;
    input       [1:0] address;
    input             read;
    input             write;
    input      [31:0] writedata;
    output reg        waitrequest;
    output reg [31:0] readdata;
    
    //Avalon slave interface

    reg [31:0]A, B, C;
    reg [31:0]result;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            A <= 0;
            B <= 0;
            C <= 0;
            readdata <= 0;
        end else begin
            if(write)begin
                case (address)
                    0:A <= writedata;
                    1:B <= writedata;
                    2:C <= writedata; 
                    default:{A, B, C} <= {32'hFFFFFFFF, 32'hFFFFFFFF, 32'hFFFFFFFF}; 
                endcase
            end
            if(read && (!waitrequest))begin
                case (address)
                    0:readdata <= A;
                    1:readdata <= B; 
                    2:readdata <= C; 
                    3:readdata <= result; 
                    default:readdata <= 32'hFFFFFFFF; 
                endcase
            end     
        end
    end

    //waitrequest logic
    localparam pipeline_latency = 1;
    generate
        if(pipeline_enable)begin
            reg [1:0]wait_cnt;
            always @(posedge clk or negedge reset_n) begin
                if(!reset_n)begin
                    wait_cnt  <= 0;
                    waitrequest <= 1'b1;
                end else begin
                    if(read && (address == 3))begin
                        if(wait_cnt > pipeline_latency)begin
                            wait_cnt <= 0;
                            waitrequest <= 1'b0;
                        end else begin
                            wait_cnt <= wait_cnt + 1'b1;
                            waitrequest <= 1'b1;
                        end
                    end else if(read | write)begin
                        waitrequest <= 1'b0;
                    end else begin
                        waitrequest <= 1'b1;
                    end      
                end
            end
        end else begin
            always @(posedge clk or negedge reset_n) begin
                if(!reset_n)begin
                    waitrequest <= 1'b1;
                end else begin
                    if(read | write)begin
                        waitrequest <= 1'b0;
                    end else begin
                        waitrequest <= 1'b1;
                    end
                end  
            end
        end
    endgenerate
    
    //ALU
    generate
        if(pipeline_enable)begin
            reg [31:0]AB, AC, BC;
            reg gtA,gtB,gtC;//greater than
            always @(posedge clk or negedge reset_n) begin
                if(!reset_n)begin
                    AB  <= 0;
                    AC  <= 0;
                    BC  <= 0;
                    gtA <= 0;
                    gtB <= 0;
                    gtC <= 0;
                    result <= 0;
                end else begin
                    AB <= A + B;
                    AC <= A + C;
                    BC <= B + C;
                    gtC <= (AB > C);
                    gtB <= (AC > B);
                    gtA <= (BC > A);
                    result <= gtA && gtB && gtC;
                end
            end   
        end else begin
            always @(*)begin
                result = ((A + B) > C) &&
                         ((A + C) > B) &&
                         ((B + C) > A);
            end
        end
    endgenerate
endmodule