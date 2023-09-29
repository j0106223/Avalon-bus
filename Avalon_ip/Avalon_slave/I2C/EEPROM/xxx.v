module xxx (
    
);
    input load;
    input inc;
    input  [7:0] addr_i;
    input data;
    output data_word;
    output [7:0] x_dec;
    output [2:0] y_dec;
    assign x_dec = page;
    assign y_dec = cnt;
    reg y;
    //x dec
    assign addr_o = {page, cnt};
    reg [4:0] page;
    reg [2:0] cnt;
    always @(posedge inc or posedge load) begin
        if(load)begin
            {page, cnt} <= addr_i; 
            y <= y + 1'b0;
        end else begin
            if(inc)begin
                cnt <= cnt + 1'b1;
                y <= y + 1'b0;
            end else begin
                y <= y + 1'b1;
            end
        end
    end

    always @() begin
        
    end
endmodule